# AGENTS.md

Always talk using simple and clear language.

## Language

Use controlled natural language in the spirit of **ASD-STE100 (Simplified Technical English)**:
short sentences, one idea per sentence, plain words, active voice, and consistent
terms. Prefer clarity over rhetorical style so readers can understand the text
quickly. Explain stuff in a BFS way. When explaining something, explain it to
me simply, as if I am not an expert on the topic. Try to use as few words as
possible.

## When doing code changes

- Always give me a summary of the changes at the end and explain why they are done.
- Keep your changes as minimal as possible.
- Keep single responsibility principle in mind.
- Tautological tests should be considered harmful.

Plus, follow the principles below:

### Minimize defensive programming

Before adding nil checks, synchronization, validation, retries, fallbacks, bounds
checks, or other defensive behavior, first investigate whether the problematic state
is actually possible under the program's intended invariants.
Use callers, constructors, business rules, tests, API contracts, and ownership/lifecycle
semantics to establish those invariants.
If the invariant cannot be established from the repository, call out the uncertainty
instead of silently adding defensive code.

### Laziness Protocol

Prefer deletion and the smallest change that solves the problem. Flatten call chains;
if answering a question takes more than about three files or layers, collapse them.
Put a repeated decision in one place and pass the result. Question any new signal
that must be threaded through types, schemas, or pipelines. Kill tiny pass-throughs
before they become coordination cost. If a human maintainer would find it exhausting,
it is the wrong shape.

### Foundational Thinking

Choose core types and data structures before writing logic. Match structure to
dominant access patterns. Scaffold (shared types, tests, lint, CI) before features.
Before sharing state across actors, ask what happens if another actor mutates it
concurrently; isolate unless the answer is "nothing." Keep commits small and single-purpose.

### Redesign from First Principles

When a new requirement does not fit the current shape, redesign as if that
requirement had been there from day one. Do not bolt a compatibility wart
onto the old design.

### Subtract Before You Add

Remove dead weight first: unused adapters, redundant validators, stub references,
speculative guards, leftover prompt text. Then build on the simpler base. Leave
the surface slightly smaller and more capable than you found it.

### Minimize Reader Load

Count layers between a question and its answer, and how much hidden state a
reader must hold. Collapse one-caller wrappers. Shrink mutable scope.

### Outcome-Oriented Execution

On rewrites and migrations, converge on the target architecture. Do not
keep throwaway compatibility states just to make intermediate phases look smooth.

### Experience First

Choose the user's result over implementation convenience. Ship fewer polished
features rather than more rough ones.

### Exhaust the Design Space

When there is no precedent, build two or three competing sketches and compare
them before committing. Do not pick the first design that compiles.

### Build the Lever

For non-trivial work, do one unit by hand to learn the recipe, then write the
smallest script, codemod, generator, or check that does or proves the rest.
The lever is what a reviewer reruns. Skip it only for a couple of obvious edits.
Do not build a framework.

### Verification

**Prove it works.** Before calling work done, check the real artifact: run the
feature path, read the stored value, inspect the diff, walk the UI or CLI
the user would use. "It compiles," a cached screenshot, an mtime, or a subagent's
summary is not proof. When a check fails, suspect the observation method before
suspecting the system. Trust delegated work via artifacts, not self-report.

**Fix root causes.** Reproduce first. Ask why until you hit the mechanism.
Do not ship nil-checks, retries, or guards that only silence a crash.
If a workaround needs a long comment, the code is wrong. Grep for the pattern,
not just the instance. Restart-only failures: suspect stale state (caches,
lockfiles, serialized config) before suspecting code that did not change.

**Sequence work into verifiable units.** Break multi-step work into small units
that each end in a checkable state. Verify each unit before starting the
next. Order commits and PRs so a reviewer can watch the sequence prove itself
(failing repro, then fix; scaffold, then behavior).

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
