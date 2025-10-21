# Disable greeting
set -g fish_greeting

# Vi key bindings
fish_vi_key_bindings

# Function can be defined here or in functions/ directory
function e
    set file (fzf)
    if test -n "$file"
        nvim "$file"
    end
end

fish_add_path -a $HOME/.local/bin
fish_add_path -a $HOME/go/bin
fish_add_path -a $HOME/.npm-global/bin

set EDITOR nvim
set VISUAL nvim
set PAGER less

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
