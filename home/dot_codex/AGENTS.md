# AGENTS.md

Always talk using simple and clear language.

## Language

You should rely on the controlled natural language ASD-STE100 (Simplified
Technical English) as much as possible to ensure all text you write is well
understood and easy to comprehend.

## When doing code changes

- Always give me a summary of the changes at the end and explain why they are done.
- Keep your changes as minimal as possible.
- Keep single responsibility principle in mind.

## When talking about issues found in code reviews, bugs or other problems

- Always provide a clear explanation of the problem, why it is a problem, a couple
  possible solutions (with their pros and cons) and your recommendation.

## When to run tests?

- If you modify a test file, always run it to confirm everything is good.
- If you are about to change code, find its test and run it. Also run the test after
  the code changes are done.

## When asking questions to the user

- If you have any questions to ask, use the request user input tool.

## Using `git`

- I use a custom pager (delta). So adjust accordingly if you
need to use `git diff` or any other commands that could be affected.

- NEVER commit or push anything if I didn't explicitly ask you to do so.

- Commit to the branch I am on, always. Never create a branch first, not even
  when that branch is `main` or another default branch. Branch only if I ask
  for it.

## Interacting with Github

- Prefer the `gh` CLI to interact with Github.

## Code Search Tools

- **Primary tool for structural/syntax-aware searches**: Use the `ast-grep` command
  - **When to use ast-grep**: Function/class definitions, method calls, structs, import statements, or any code structure matching
  - For Rust code: `ast-grep -lang rust -p '‹pattern>'`
  - For other languages: Set `--lang` appropriately (e.g., `--lang javascript`, `--lang python`)
  - Only fallback to `rg` or `grep` for plain-text searches when explicitly requested
  - For seeing the outline of a file or folder, use `ast-grep outline <path>`. It can
    be combined with `-p` for pattern searching. The outline can be also
    enriched with `--view` for `names`, `signatures`, or be `expanded` (the
    default is `auto`.

## Temporary directory for experiments

When you need to experiment with anything that needs a temporary repository,
use `~/code/tmp` as the base directory. Create a subdirectory named like so:
`<CHAT_NAME>-<LAST_6_DIGITS_OF_SESSION_ID>` and put anything temporary there.
