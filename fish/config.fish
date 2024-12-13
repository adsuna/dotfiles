if status is-interactive
    # Commands to run in interactive sessions can go here
end
function fish_greeting

# Aliases
alias yank="yay -S"
alias scan="yay -q"
alias yeet="yay -Rns"
alias z="zeditor"
alias hexec="hyprctl dispatch exec"
alias dots=~/scripts/dots.sh


end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH