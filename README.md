# dotfiles

Personal dotfiles for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Package | File | Purpose |
|---|---|---|
| `zsh` | `.zshrc` | Shell config, aliases, PATH |
| `p10k` | `.p10k.zsh` | Powerlevel10k prompt theme |
| `claude` | `.claude/settings.json` | Claude Code settings |

## Fresh machine setup

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install dependencies

```bash
brew install stow git
```

### 3. Set zsh as default shell (if not already)

```bash
chsh -s /bin/zsh
```

### 4. Clone this repo

```bash
git clone https://github.com/kristoffergordon/dotfiles.git ~/dotfiles
```

### 5. Create your secrets file

This file is never committed. Add any API keys or tokens here.

```bash
cat > ~/.secrets << 'EOF'
# Secret environment variables — never commit this file
export OPENAI_API_KEY=your-key-here
EOF
```

### 6. Install Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
```

### 7. Stow all packages

```bash
stow -d ~/dotfiles -t ~ zsh p10k claude
```

Your dotfiles are now symlinked. Any edits to files in `~` will be reflected directly in `~/dotfiles`, ready to commit and push.

## Adding a new dotfile

1. Create a package folder: `mkdir ~/dotfiles/<tool>`
2. Mirror the path from `~`: e.g. for `~/.config/foo/bar.conf` → `~/dotfiles/foo/.config/foo/bar.conf`
3. Move the original file in: `mv ~/.config/foo/bar.conf ~/dotfiles/foo/.config/foo/bar.conf`
4. Stow it: `stow -d ~/dotfiles -t ~ foo`
5. Commit and push

## What is never committed

- `~/.secrets` — API keys and tokens (loaded by `.zshrc` at runtime)
- `~/.ssh/` — SSH private keys
- `*.local` files — machine-specific overrides
