 if status is-interactive
    # Commands to run in interactive sessions can go here
end
function fish_greeting

# Aliases
alias yank="yay -S"
alias scan="yay -q"
alias yeet="yay -Rns"
alias hexec="hyprctl dispatch exec"
alias dots=~/dotfiles/update.sh
alias ghs="gh copilot suggest"


end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# pyenv
pyenv init - fish | source

# zoxide
zoxide init --cmd cd fish | source
