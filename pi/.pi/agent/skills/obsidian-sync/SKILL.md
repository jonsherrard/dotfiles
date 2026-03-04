---
name: obsidian-sync
description: Read, write, and sync Obsidian vaults. Use when the user asks about notes, obsidian, vault content, syncing vaults, or wants to create/edit markdown notes in their Obsidian vaults.
---

# Obsidian Sync

Read, write, and sync Obsidian vaults using `ob` (obsidian-headless CLI) and direct file access.

## Vault Locations

| Vault | Local Path | Remote Name | Remote ID |
|-------|-----------|-------------|-----------|
| L2L Vault | `/Users/jonsherrard/L2L Vault` | L2L Vault | `83f630415cdb6cfef05e6b0bc2df1416` |
| que-vida | `/Users/jonsherrard/Documents/que-vida` | — (local only) | — |
| jps-main | _Not yet cloned locally_ | jps-main | `50a04f49922abb3f1a655f4b41e1883a` |

## Before Syncing — Check for Obsidian Desktop

**Always run this check before any `ob sync` command.** The Obsidian desktop app has its own sync process and running `ob sync` concurrently causes race conditions and data loss.

```bash
pgrep -x "Obsidian" >/dev/null 2>&1
```

- **If it returns 0 (running):** Do NOT run `ob sync`. Tell the user:
  > "Obsidian desktop is currently running and will handle syncing automatically. Close Obsidian first if you want me to sync via CLI."
  You can still read/write files directly — just skip the sync step.
- **If it returns non-zero (not running):** Safe to proceed with `ob sync`.

## Syncing a Vault

```bash
# One-shot sync (pull + push)
ob sync --path "/Users/jonsherrard/L2L Vault"
```

Only vaults that have been set up with `ob sync-setup` can be synced. Check configured vaults:

```bash
ob sync-list-local
```

### First-Time Setup (if a vault shows "No vaults configured")

```bash
ob sync-setup --vault "L2L Vault" --path "/Users/jonsherrard/L2L Vault"
# Will prompt for encryption password if the vault uses E2EE
```

To clone a remote vault that doesn't exist locally yet (e.g. jps-main):

```bash
mkdir -p /Users/jonsherrard/jps-main
ob sync-setup --vault "jps-main" --path "/Users/jonsherrard/jps-main"
ob sync --path "/Users/jonsherrard/jps-main"
```

## Reading Notes

Use the `read` tool directly on markdown files:

```
read "/Users/jonsherrard/L2L Vault/Some Note.md"
```

To find notes by name or content:

```bash
# Find by filename
find "/Users/jonsherrard/L2L Vault" -name "*.md" | grep -i "search term"

# Find by content
grep -rl "search term" "/Users/jonsherrard/L2L Vault" --include="*.md"

# List all notes
find "/Users/jonsherrard/L2L Vault" -name "*.md" -not -path "*/.obsidian/*"
```

## Writing / Editing Notes

Use `write` or `edit` tools directly on the vault files. Standard Obsidian markdown conventions:

- **Wiki-links:** `[[Note Name]]` or `[[Note Name|Display Text]]`
- **Tags:** `#tag` or in YAML frontmatter `tags: [tag1, tag2]`
- **Frontmatter:** YAML block at top of file between `---` fences
- **Daily notes:** stored in `Daily Notes/` subfolder (L2L Vault)

After writing, run `ob sync` (if Obsidian desktop is not running) to push changes to the remote vault.

## Useful Commands

```bash
ob sync-status --path "/Users/jonsherrard/L2L Vault"   # Check sync status
ob sync-config --path "/Users/jonsherrard/L2L Vault"    # View/change sync config
ob sync-list-remote                                      # List all remote vaults
ob sync-list-local                                       # List locally configured vaults
```

## Workflow Summary

1. Check if Obsidian desktop is running (`pgrep -x "Obsidian"`)
2. If not running, optionally `ob sync --path <vault>` to pull latest
3. Read/write files as needed
4. If not running, `ob sync --path <vault>` to push changes
5. If running, just read/write files — desktop app syncs automatically
