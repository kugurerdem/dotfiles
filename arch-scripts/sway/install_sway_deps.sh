#!/usr/bin/env sh

set -eu

if ! command -v pacman >/dev/null 2>&1; then
    printf '%s\n' "pacman is not available on this system." >&2
    exit 1
fi

if ! command -v git >/dev/null 2>&1; then
    printf '%s\n' "git is required but not installed." >&2
    exit 1
fi

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
packages_file="$script_dir/packages.txt"

if [ ! -f "$packages_file" ]; then
    printf '%s\n' "Package list not found: $packages_file" >&2
    exit 1
fi

packages="$(sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' "$packages_file")"

if [ -z "$packages" ]; then
    printf '%s\n' "No packages found in $packages_file" >&2
    exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
    pacman -S --needed --noconfirm $packages
else
    sudo pacman -S --needed --noconfirm $packages
fi

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
