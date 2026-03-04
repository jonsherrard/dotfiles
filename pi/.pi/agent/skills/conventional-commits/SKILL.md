---
name: conventional-commits
description: Write git commit messages following the Conventional Commits specification. Use when committing code, preparing commits, or when the user asks for conventional commit formatting.
---

# Conventional Commits

Write commit messages following the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

## Types

| Type | When to use |
|------|------------|
| `feat` | A new feature |
| `fix` | A bug fix |
| `docs` | Documentation only changes |
| `style` | Formatting, semicolons, etc. (no code change) |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf` | Performance improvement |
| `test` | Adding or correcting tests |
| `build` | Build system or external dependencies (npm, cargo, etc.) |
| `ci` | CI configuration and scripts |
| `chore` | Other changes that don't modify src or test files |
| `revert` | Reverts a previous commit |

## Rules

1. **Type is required** and must be lowercase
2. **Scope is optional**, in parentheses: `feat(auth): add login`
3. **Description is required**, lowercase, no period at end, imperative mood
4. **Breaking changes** use `!` after type/scope: `feat!: remove API` or a `BREAKING CHANGE:` footer
5. **Body** is free-form, separated from description by a blank line
6. **Footers** use `token: value` or `token #value` format (e.g. `Refs #123`, `Reviewed-by: Name`)

## Examples

Simple:
```
feat: add user authentication
```

With scope:
```
fix(api): handle null response from payment gateway
```

Breaking change:
```
feat(auth)!: migrate to OAuth2

BREAKING CHANGE: removes legacy session-based auth
```

Multi-line with body and footer:
```
refactor(db): simplify connection pooling logic

Extract pool manager into separate module. Reduce default pool
size from 20 to 10 based on production metrics.

Refs #442
```

Chore/config:
```
chore: update dotfiles sync script
```

## Workflow

When the user asks to commit (or you need to commit):

1. Run `git diff --staged` (or `git diff` if nothing staged) to see changes
2. Determine the appropriate type and optional scope from the diff
3. Write a concise imperative description of what the change does
4. Add a body only if the "what" and "why" aren't obvious from the description
5. Commit with: `git commit -m "<message>"`
6. For multi-line messages use:
   ```bash
   git commit -m "<type>[scope]: <description>" -m "<body>" -m "<footer>"
   ```

## Dotfiles Repo

The user's dotfiles live in `~/dotfiles` and use GNU Stow for symlinking.
Packages: `zsh`, `tmux`, `pi`.

When committing dotfiles:

```bash
cd ~/dotfiles
git add <file>
git commit -m "<conventional commit message>"
git push
```
