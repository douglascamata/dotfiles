# AGENTS.md

## When doing code changes

Always give me a summary of the changes at the end and exlain why they are done.

## When to run tests?

If you modify a test file, always run it to confirm everything is good.

If you are about to change code, find its test and run it. Also run the test after
the code changes are done.

## Using `git`

I use a custom pager (delta). So adjust accordingly if you
need to use `git diff` or any other commands that could be affected.

NEVER commit or push anything if I didn't explicitly ask you to do so.

## Code Search Tools

- **Primary tool for structural/syntax-aware searches**: Use `ast-grep` (`sg`) command
  - For Rust code: `sg -lang rust -p '‹pattern>'`
  - For other languages: Set `--lang` appropriately (e.g., `--lang javascript`, `--lang python`)
  - Only fallback to `rg` or `grep` for plain-text searches when explicitly requested
- **When to use ast-grep**: Function/class definitions, method calls, structs, import statements, or any code structure matching
- When working in an environment with `ast-grep`, use `ast-grep --lang ruby -p '<pattern>'` (or set `--lang` appropriately) for syntax-aware or structural matching, avoiding text-only tools like `rg` or `grep` unless explicitly requested for plain-text search
