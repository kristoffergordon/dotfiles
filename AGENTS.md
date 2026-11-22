# dotfiles

Public macOS dotfiles. Each top-level folder is a GNU Stow package symlinked into `~`. `install.sh` is the single source of truth for setup; `README.md` is the human summary.

## Live symlinks

- Every packaged file is live: `~/.zshrc` *is* `zsh/.zshrc`, so editing in `~` edits the repo.
- Third-party installers append to `~/.zshrc` and so write into the repo. Read `git diff` before every commit and strip installer lines (hardcoded `/Users/...` paths, duplicate PATH entries).
- Agent shells load the user's aliases: `ls` is eza, `cat` is bat. Use `/bin/ls` and `command cat` when you parse output.

## Adding things

- **Tool:** add it to `Brewfile`, then `brew bundle --no-upgrade --file=Brewfile`. The Brewfile is the full inventory, language servers included (no Mason); `--no-upgrade` leaves unrelated formulas alone.
- **Dotfile:** create package `<name>/` mirroring the path from `~`, move the file in, `stow -d ~/dotfiles -t ~ <name>`, then add `<name>` to the stow line in `install.sh` and the README table.
- **Shell init for a tool:** guard it with `command -v <tool> &>/dev/null &&` so a machine without the tool still starts cleanly.

## PATH and Python

- `.zprofile` runs `brew shellenv` so Homebrew precedes `/usr/bin`; `.zshrc` prepends `~/.local/bin`.
- `python` and `python3` come from `uv python install 3.12 --default` (links in `~/.local/bin`); without it, `python3` is Apple's 3.9. Keep Python out of aliases and the Brewfile.

## Claude Code

`claude/.claude/settings.json` runs hooks from `~/.claude/hooks/`, which the separate harness repo (`~/Projects/harness`) links in; its `install.sh` also merges hook entries into `settings.json` through the stow symlink. Missing hooks make the PreToolUse hook exit 2 and block every Bash call, so `install.sh` runs the harness install after stowing.

## Neovim

- One file, `nvim/.config/nvim/init.lua`, with plugins from the built-in `vim.pack`. Commit `nvim-pack-lock.json` with every plugin change.
- Keep the config small: add a plugin only for a need the user has actually hit.
- Format on save looks for a formatting client at write time, because Ruff registers formatting only after it attaches.

## Verify

Run every check that covers the files you touched:

- `shellcheck install.sh` and `bash -n install.sh`; `zsh -n zsh/.zshrc zsh/.zprofile zsh/.aliases`.
- `zsh -i -c exit` exits 0 (the `can't change option: zle` warning is a no-TTY artifact).
- `nvim --headless -c 'lua io.stdout:write(vim.v.errmsg)' -c qa` prints nothing. For LSP, open a file headless and `vim.wait` up to 15 s for `vim.lsp.get_clients()`: servers take several seconds to attach.
- `~/Projects/harness/install.sh --dry-run` exits 0 after touching `claude/` or `install.sh`.

## Commits

`type: short description`, with type one of `feat`, `fix`, `docs`, `chore`, `refactor`, `test`. Secrets live in `~/.secrets` and machine-specific values in `*.local` files, both gitignored.
