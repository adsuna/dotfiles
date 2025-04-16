if status is-interactive
    # Commands to run in interactive sessions can go here
end


function install_vencord
    bash -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
end

function fish_greeting

end

function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd


# Aliases
alias hexec="hyprctl dispatch exec"
alias dots=~/dotfiles/update.sh
alias reflect="sudo reflector --country in,sg --age 12 --sort rate --save /etc/pacman.d/mirrorlist"
alias yay="~/.config/hypr/scripts/yay-wrapper.sh"


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# pyenv
pyenv init - fish | source

# zoxide
zoxide init --cmd cd fish | source
