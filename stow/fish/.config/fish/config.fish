# Disable default Fish greeting
set -g fish_greeting

# Enable vi-style key bindings
fish_vi_key_bindings

# Add user-level binaries to PATH
fish_add_path -a $HOME/.local/bin
fish_add_path -a $HOME/go/bin
fish_add_path -a $HOME/.npm-global/bin
fish_add_path -a $HOME/.config/herd-lite/bin

# Set default editor environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set PAGER less
set SHELL fish

# Git UI shortcut
alias lg="lazygit"

# Open a file selected with fzf in Neovim
function e
    set file (fzf)
    if test -n "$file"
        $EDITOR "$file"
    end
end

# Integrate yazi file manager with shell directory tracking
# Changes current directory after exiting yazi
if type -q yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end

# Hook direnv into Fish for automatic environment loading
if type -q direnv
    direnv hook fish | source
end

# Initialize zoxide for smarter directory navigation
if type -q zoxide
    zoxide init fish | source
end

if status is-interactive
    atuin init fish | source
end
