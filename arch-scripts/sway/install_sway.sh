#!/usr/bin/env sh

repo_url="https://github.com/kugurerdem/sway"
repo_dir="$HOME/sway"

if [ -d "$repo_dir/.git" ]; then
    git -C "$repo_dir" pull --ff-only
elif [ -e "$repo_dir" ]; then
    printf '%s\n' "Path exists and is not a git repo: $repo_dir" >&2
    exit 1
else
    git clone "$repo_url" "$repo_dir"
fi

if [ "$(id -u)" -eq 0 ]; then
    (cd "$repo_dir" && ./sway-install.sh)
else
    (cd "$repo_dir" && sudo ./sway-install.sh)
fi
