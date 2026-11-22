#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
REPO="https://github.com/kristoffergordon/dotfiles.git"
HARNESS_DIR="$HOME/Projects/harness"
HARNESS_REPO="https://github.com/kristoffergordon/harness.git"

echo "==> Starting dotfiles installation"

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for the rest of this script (Apple Silicon path)
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "==> Homebrew already installed, skipping"
fi

# Bootstrap stow and git (needed before cloning and brew bundle)
echo "==> Installing stow and git"
brew install stow git

# Clone dotfiles (must precede brew bundle, which reads the Brewfile from the repo)
if [ -d "$DOTFILES_DIR" ]; then
  echo "==> Dotfiles repo already exists at $DOTFILES_DIR, pulling latest"
  git -C "$DOTFILES_DIR" pull
else
  echo "==> Cloning dotfiles repo"
  git clone "$REPO" "$DOTFILES_DIR"
fi

# Brewfile packages
echo "==> Installing Brewfile packages"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Default Python (provides python/python3 in ~/.local/bin)
echo "==> Installing default Python via uv"
uv python install 3.12 --default

# zsh as default shell
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "==> Setting zsh as default shell"
  chsh -s /bin/zsh
else
  echo "==> zsh already default shell, skipping"
fi

# Secrets file
if [ ! -f "$HOME/.secrets" ]; then
  echo "==> Creating empty ~/.secrets (add your API keys here)"
  cat > "$HOME/.secrets" << 'EOF'
# Secret environment variables — never commit this file
export OPENAI_API_KEY=your-key-here
EOF
else
  echo "==> ~/.secrets already exists, skipping"
fi

# Powerlevel10k
if [ ! -d "$HOME/.powerlevel10k" ]; then
  echo "==> Installing Powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.powerlevel10k"
else
  echo "==> Powerlevel10k already installed, skipping"
fi

# Stow all packages
echo "==> Stowing dotfiles"
stow -d "$DOTFILES_DIR" -t "$HOME" --restow zsh p10k git claude nvim

# Claude Code harness (hooks referenced by claude/.claude/settings.json; must follow stow)
if [ -d "$HARNESS_DIR" ]; then
  echo "==> Harness repo already exists at $HARNESS_DIR, pulling latest"
  git -C "$HARNESS_DIR" pull
else
  echo "==> Cloning harness repo"
  git clone "$HARNESS_REPO" "$HARNESS_DIR"
fi
echo "==> Linking harness into ~/.claude"
"$HARNESS_DIR/install.sh"

echo ""
echo "Done! Open a new terminal to apply your shell config."
echo "Remember to add your API keys to ~/.secrets"
