# GNU Stow Notes

This folder is used as the stow directory.

By default, GNU Stow will place symlinks in the parent of the current directory.
Since this folder is nested under the repo, we need to explicitly specify the target directory as `$HOME`.

```bash
stow --target=$HOME <package_name>
```
