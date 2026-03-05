if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting

end
function install_vencord
    bash -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
end

alias hexec="hyprctl dispatch exec"
alias reflect="sudo reflector --country in,sg --age 12 --sort rate --save /etc/pacman.d/mirrorlist"
