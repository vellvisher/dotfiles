dotfiles
========

Dotfiles

Aliases
=======
Add `source $HOME/.bash_aliases` to `.bashrc`

## Inbox Triage (mu4e)

### Entry points

| Key | Where | Action |
|-----|-------|--------|
| `T` | mu4e main | Open inbox sorted by sender (triage view) |
| `b n` | mu4e main | Inbox filtered to mailing lists & newsletters (`flag:list`) |
| `b f` | mu4e main | Inbox filtered to statements & payments |
| `b p` | mu4e main | Inbox filtered to privacy, terms & surveys |

### Inside headers view

| Key | Action |
|-----|--------|
| `S` | Narrow to all inbox messages from this sender |
| `Z` | Narrow to all inbox messages with this subject |
| `* t` | Mark all visible messages for trash |
| `* r` | Mark all visible for archive/refile instead |
| `x` | Execute all marks |

### Recommended loop for inbox zero

1. `T` → triage view (sorted by sender, emails from same sender cluster together)
2. Spot a noisy sender → `S` → narrows to just their emails
3. `* t` → mark all for trash (or `* r` to archive)
4. `x` → execute, repeat
5. Use `b n`, `b f`, `b p` to batch-process newsletters, statements, and privacy noise
