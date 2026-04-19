---
name: dotfiles
description: Repository knowledge for this dotfiles setup. Use when adding tools, editing shell configs, understanding the architecture, or working with GNU Stow.
---

# Dotfiles Repository Knowledge

## Architecture

```
dotfiles/
├── Brewfile              # Declarative tool manifest — edit this to add tools
├── install.sh            # Fresh machine setup script
├── AGENTS.md             # Development conventions
├── SKILL.md              # This file — repo knowledge for AI agents
├── prompts.md            # Prompt engineering reference
├── zsh/
│   ├── .zshrc            # Shell entry point
│   └── .aliases          # All aliases and modern tool overrides
├── p10k/
│   └── .p10k.zsh         # Powerlevel10k prompt config
├── git/
│   ├── .gitconfig        # Git user, aliases, defaults
│   └── .gitignore_global # Global gitignore
└── claude/
    └── .claude/
        └── settings.json # Claude Code settings
```

## Adding a Tool

**Never run `brew install` directly. Always add to the Brewfile first.**

1. Add to `Brewfile`:
   ```
   brew "toolname"
   ```
2. Run `brew bundle --file=~/dotfiles/Brewfile`
3. If the tool needs shell config (aliases, init), add to `zsh/.aliases` or `zsh/.zshrc`
4. Commit and push

## Adding a Dotfile (Stow package)

1. Create package folder mirroring the `~` path:
   ```bash
   mkdir -p ~/dotfiles/toolname/.config/toolname
   ```
2. Move the original file in:
   ```bash
   mv ~/.config/toolname/config.toml ~/dotfiles/toolname/.config/toolname/config.toml
   ```
3. Stow it:
   ```bash
   stow -d ~/dotfiles -t ~ toolname
   ```
4. Commit and push

## GNU Stow — How It Works

Stow creates symlinks from `~` into the repo. Each top-level folder is a "package". The directory tree inside a package mirrors `~`:

```
dotfiles/zsh/.zshrc   →   ~/.zshrc (symlink)
dotfiles/git/.gitconfig   →   ~/.gitconfig (symlink)
```

Editing `~/.zshrc` edits the repo file directly — `git status` picks it up automatically.

## Secrets

This repo is public. Never commit secrets.

- API keys live in `~/.secrets` (never tracked)
- `~/.zshrc` loads it at runtime: `[[ -f ~/.secrets ]] && source ~/.secrets`
- Git identity lives in `~/.gitconfig` (tracked, contains no secrets)

## Packages Currently Managed

| Package | Stow command | Files |
|---|---|---|
| `zsh` | `stow zsh` | `.zshrc`, `.aliases` |
| `p10k` | `stow p10k` | `.p10k.zsh` |
| `git` | `stow git` | `.gitconfig`, `.gitignore_global` |
| `claude` | `stow claude` | `.claude/settings.json` |
