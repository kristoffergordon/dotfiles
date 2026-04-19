# Powerlevel10k instant prompt (keep near top of .zshrc)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH"

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# Load p10k config (run `p10k configure` to regenerate)
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
[[ -f ~/.secrets ]] && source ~/.secrets
[[ -f ~/.aliases ]] && source ~/.aliases
