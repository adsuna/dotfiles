if status is-interactive
    # Commands to run in interactive sessions can go here
end

function install_vencord
    bash -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
end


function tv_smart_autocomplete
    set -l current_prompt (commandline -cp)

    set -l output (tv --autocomplete-prompt "$current_prompt")

    if test -n "$output"
        # add a space if the prompt does not end with one (unless the prompt is an implicit cd, e.g. '\.')
        string match -r '.*( |./)$' -- "$current_prompt" || set current_prompt "$current_prompt "
        commandline -r "$current_prompt$output"
        commandline -f repaint
    end
end

function tv_shell_history
    set -l current_prompt (commandline -cp)

    set -l output (tv fish-history --input "$current_prompt")

    if test -n "$output"
        commandline -r "$output"
        commandline -f repaint
    end
end

bind \cT tv_smart_autocomplete
bind \cR tv_shell_history

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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# pyenv
pyenv init - fish | source

# zoxide
zoxide init --cmd cd fish | source
