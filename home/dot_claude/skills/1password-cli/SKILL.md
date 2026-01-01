---
name: 1password-cli
description: "Use the 1Password CLI (`op`) to securely retrieve secrets. Load this skill when users ask to 'get a password from 1Password', 'retrieve a secret', 'fetch credentials from the vault', 'use op to read', or need to pass secrets to commands, environment variables, or files. CRITICAL: Never display secret values in conversation - always consume them inline with redirection or command substitution."
---

## 1Password CLI Integration

Use the 1Password CLI (`op`) to securely retrieve secrets from the user's 1Password vault without ever exposing secret values in conversation output.

## CRITICAL SECURITY RULES

**The Bash tool captures command output and includes it in conversation history.** Running `op read` alone exposes the secret. Always consume secrets inline.

### Mandatory Patterns

| Pattern | Example |
|---------|---------|
| **Redirect to file** | `op read "op://vault/item/field" > /path/to/file` |
| **Inline substitution** | `curl -u "user:$(op read 'op://vault/item/password')" https://api.example.com` |
| **Export + command** | `export TOKEN=$(op read "op://vault/item/token") && ./deploy.sh` |
| **Pipe to consumer** | `op read "op://vault/item/key" \| kubectl create secret generic my-secret --from-file=key=/dev/stdin` |

### What NOT to Do

```bash
# ❌ WRONG - secret appears in Bash tool output
op read "op://vault/item/password"

# ❌ WRONG - echo displays the secret  
PASSWORD=$(op read "op://vault/item/password")
echo "Password is: $PASSWORD"

# ✅ CORRECT - secret consumed immediately, only confirmation shown
export DB_PASS=$(op read "op://vault/item/password") && echo "Secret loaded successfully"
```

### Additional Rules

1. **Use `--no-newline`** when writing to files where trailing newlines cause issues
2. **Report success generically** - Never mention the secret's content, length, or characteristics

## Secret Reference Syntax

```
op://vault/item/field
```

- **vault**: The name or ID of the vault containing the item
- **item**: The name or ID of the item
- **field**: The field name (e.g., `password`, `username`, `credential`, or custom field names)

### Common Field Names

| Field | Description |
|-------|-------------|
| `password` | Primary password field |
| `username` | Username/login field |
| `credential` | API credential field |
| `notesPlain` | Notes field (plain text) |
| `one-time password` | TOTP/OTP field |

## Core Commands

### Find Items

```bash
# List vaults
op vault list --format=json

# List items in a vault
op item list --vault="VaultName" --format=json

# Search by title
op item list --format=json | jq -r '.[] | select(.title | test("search_term"; "i")) | "\(.id) | \(.title)"'

# Get item field structure
op item get "ItemName" --format=json | jq '.fields[] | {label, type}'
```

### Read Secrets (always consume inline)

```bash
# Environment variable
export DB_PASSWORD=$(op read "op://Private/Database/password")

# Write to file
op read "op://Private/SSHKey/private key" > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa

# Inline in command
curl -u "user:$(op read 'op://Private/API/credential')" https://api.example.com
```

### Check Authentication

```bash
op whoami --format=json 2>/dev/null && echo "Authenticated" || echo "Not signed in - run: op signin"
```

### Categories

Common item categories for `--categories` filter:
Login, Password, API Credential, Secure Note, SSH Key, Database, Server, Document.

## Additional Resources

See `examples.md` in this skill folder for detailed workflow examples, query parameters, and advanced patterns like `op run` and `op inject`.

For comprehensive documentation: [1Password CLI Reference](https://developer.1password.com/docs/cli/)
