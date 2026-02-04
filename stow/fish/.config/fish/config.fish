# Disable greeting
set -g fish_greeting

# Vi key bindings
fish_vi_key_bindings

# If fzf is available, create a utility for opening files through fzf in neovim
if type -q fzf
    function e
        set file (fzf)
        if test -n "$file"
            nvim "$file"
        end
    end
end

# If yazi is available, create a shell wrapper for it
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

fish_add_path -a $HOME/.local/bin
fish_add_path -a $HOME/go/bin
fish_add_path -a $HOME/.npm-global/bin
fish_add_path -a $HOME/.config/herd-lite/bin

set EDITOR nvim
set VISUAL nvim
set PAGER less
set SHELL fish

alias lg="lazygit"
alias diary="$EDITOR $HOME/Documents/my/diary/$(date +%G).md"

# If direnv is available hook it into the shell
if type -q direnv
    direnv hook fish | source
end

# If zoxide is availabe hook it into the shell
if type -q zoxide
    zoxide init fish | source
end

