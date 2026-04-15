# Disable default Fish greeting
set -g fish_greeting

# Enable vi-style key bindings
fish_vi_key_bindings

# Add user-level binaries to PATH
fish_add_path -a $HOME/.local/bin
fish_add_path -a $HOME/go/bin
fish_add_path -a $HOME/.npm-global/bin
fish_add_path -a $HOME/.config/herd-lite/bin

# Determine Helix binary name per OS
# On Linux: usually "helix"
# On macOS: typically installed as "hx"
set -gx HELIX helix
if test (uname) = Darwin
    set -gx HELIX hx
end

# Set default editor environment variables
set EDITOR $HELIX
set VISUAL $HELIX
set PAGER less
set SHELL fish

# Git UI shortcut
alias lg="lazygit"

# Define "e" command based on selected editor:
# - If using Helix: open current directory directly
# - If using Vim/Neovim: use fzf to select a file
switch $EDITOR
    case $HELIX
        # Fast directory open for Helix
        alias e='$HELIX .'

    case nvim vim
        # Interactive file picker for Vim-based editors
        function e
            set file (fzf)
            if test -n "$file"
                $EDITOR "$file"
            end
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
