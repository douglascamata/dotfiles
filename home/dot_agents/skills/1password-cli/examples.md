# 1Password CLI Examples

Detailed examples for common 1Password CLI operations. See `SKILL.md` for core rules and security constraints.

## Workflow Example

When user asks to "get the Portainer password from 1Password":

1. **Find the item** (show this to user):

   ```bash
   op item list --format=json | jq -r '.[] | select(.title | test("portainer"; "i")) | "\(.id) | \(.title) | \(.vault.name)"'
   ```

2. **Confirm with user** which item they want

3. **Read the secret programmatically** (do NOT show output):

   ```bash
   export PASSWORD=$(op read "op://Private/Portainer/password") && echo "Secret loaded"
   ```

4. **Use the secret** in whatever operation is needed

5. **Report success** to user WITHOUT revealing the secret value:
   > "Successfully retrieved the Portainer password and used it to authenticate."

## Safe Usage Patterns

### Environment Variables

```bash
# Single secret
export DB_PASSWORD=$(op read "op://Private/Database/password")

# Multiple secrets (chained)
export DB_USER=$(op read "op://Private/Database/username") && \
export DB_PASS=$(op read "op://Private/Database/password") && \
echo "Database credentials loaded"
```

### Writing to Files

```bash
# SSH key with proper permissions
op read "op://Private/SSHKey/private key" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

# Without trailing newline (important for some configs)
op read --no-newline "op://Private/API/token" > /etc/myapp/token

# Config file with secrets
op read "op://DevOps/TLS/certificate" > /etc/ssl/cert.pem
op read "op://DevOps/TLS/private key" > /etc/ssl/key.pem
chmod 600 /etc/ssl/key.pem
```

### Inline Command Usage

```bash
# curl with basic auth
curl -u "user:$(op read 'op://Private/API/credential')" https://api.example.com

# Docker login
echo "$(op read 'op://DevOps/Docker/password')" | docker login -u myuser --password-stdin

# Git credential
git clone "https://$(op read 'op://Private/GitHub/token')@github.com/user/repo.git"
```

### Kubernetes Secrets

```bash
# Create secret from stdin
op read "op://DevOps/k8s-secret/token" | kubectl create secret generic my-secret --from-file=token=/dev/stdin

# Create TLS secret
kubectl create secret tls my-tls \
  --cert=<(op read "op://DevOps/TLS/certificate") \
  --key=<(op read "op://DevOps/TLS/private key")
```

## Query Parameters

The `op read` command supports query parameters for special cases:

```bash
# Get SSH private key in OpenSSH format
op read "op://vault/item/private key?ssh-format=openssh"

# Get one-time password (TOTP)
op read "op://vault/item/one-time password?attribute=otp"

# Get file attachment
op read "op://vault/item/my-attachment.txt"
```

## Multi-Account Usage

```bash
# Specify account for users with multiple 1Password accounts
op read --account "my-account.1password.com" "op://VaultName/ItemName/password"

# List accounts
op account list
```

## Advanced: op run (Command Execution)

Use `op run` to execute commands with secrets automatically injected as environment variables:

```bash
# Create .env.template with secret references
cat > .env.template << 'EOF'
DB_HOST=localhost
DB_USER=op://Private/Database/username
DB_PASS=op://Private/Database/password
EOF

# Run command with secrets injected
op run --env-file=.env.template -- ./my-script.sh

# One-liner with inline secret
op run --env-file=.env.template -- printenv DB_PASS  # Output goes to command, not console
```

## Advanced: op inject (Template Injection)

For multiple secrets written to a file, use `op inject` with a template:

```bash
# Create template.env (safe to commit to version control)
cat > template.env << 'EOF'
DB_HOST=localhost
DB_USER=op://Private/Database/username
DB_PASS=op://Private/Database/password
API_KEY=op://Private/API/credential
EOF

# Inject secrets into output file (NEVER commit .env)
op inject -i template.env -o .env

# Verify (shows variable names, not values)
cat .env | cut -d= -f1
```

## Error Handling

### Authentication Issues

```bash
# Check if signed in
op whoami --format=json 2>/dev/null && echo "Authenticated" || echo "Not signed in"

# Sign in (interactive)
op signin

# Sign in to specific account
op signin --account my-account.1password.com
```

### Item Not Found

```bash
# List all items to help user find correct name
op item list --format=json | jq -r '.[] | .title' | sort

# Search across all vaults
op item list --format=json | jq -r '.[] | "\(.title) (\(.vault.name))"' | sort

# Get item by ID (more reliable than name)
op item get "abc123xyz" --format=json
```

### Vault Access Issues

```bash
# List accessible vaults
op vault list --format=json | jq -r '.[] | "\(.id) | \(.name)"'

# Check vault permissions
op vault get "VaultName" --format=json | jq '.type'
```

## Searching and Filtering

### By Category

```bash
# All logins
op item list --categories=Login --format=json

# All API credentials
op item list --categories="API Credential" --format=json

# Multiple categories
op item list --categories=Login,Password --format=json
```

### By Tag

```bash
op item list --tags=production --format=json
op item list --tags=aws,production --format=json
```

### Complex Searches with jq

```bash
# Items containing "prod" in title
op item list --format=json | jq -r '.[] | select(.title | test("prod"; "i")) | "\(.id) | \(.title)"'

# Items in specific vault with specific category
op item list --vault=DevOps --categories=Login --format=json | jq -r '.[] | .title'

# Items modified in last 7 days
op item list --format=json | jq -r '.[] | select(.updated_at > (now - 604800 | todate)) | .title'
```
