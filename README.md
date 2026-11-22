# dotfiles

Personal dotfiles for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level folder is a package whose contents are symlinked into `~`.

| Package | Files |
|---|---|
| `zsh` | `.zprofile`, `.zshrc`, `.aliases` |
| `p10k` | `.p10k.zsh` |
| `git` | `.gitconfig`, `.gitignore_global` |
| `claude` | `.claude/settings.json` (hooks come from [harness](https://github.com/kristoffergordon/harness)) |
| `nvim` | `.config/nvim/init.lua` |

Tools are declared in the [`Brewfile`](./Brewfile).

## Install

```bash
git clone https://github.com/kristoffergordon/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

The script is safe to rerun. Afterwards, add API keys to `~/.secrets`.

## Day to day

- **Edit a config:** edit it in `~`; the symlink means the change is already in the repo. Commit it.
- **Add a tool:** add it to the `Brewfile`, then `brew bundle --file=~/dotfiles/Brewfile`.
- **Add a dotfile:** mirror its path under a new package, move it in, then stow it:

  ```bash
  mkdir -p ~/dotfiles/foo/.config/foo
  mv ~/.config/foo/config ~/dotfiles/foo/.config/foo/
  stow -d ~/dotfiles -t ~ foo
  ```

  Then add `foo` to the stow line in `install.sh`.

## Never committed

`~/.secrets` (API keys, sourced by `.zshrc`), `~/.ssh/`, and `*.local` files.
