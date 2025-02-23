if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting

end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# Aliases
alias yank="yay -S"
alias yeet="yay -Rns"
alias hexec="hyprctl dispatch exec"
alias dots=~/dotfiles/update.sh
alias reflect="sudo reflector --country in,sg --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias vencord_install='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# pyenv
pyenv init - fish | source

# zoxide
zoxide init --cmd cd fish | source
