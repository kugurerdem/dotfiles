#!/usr/bin/env sh

set -eu

if ! command -v pacman >/dev/null 2>&1; then
    printf '%s\n' "pacman is not available on this system." >&2
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
