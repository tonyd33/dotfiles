# dotfiles

This README is for me in the future, who will inevitably forget how to set
everything back up.

`PKGLIST` contains all of the packages that I _manually_ installed, but not
all that are installed as dependencies. Use it with `pacman` at your own
disgression to figure what you want to keep.

We used [GNU Stow](https://www.gnu.org/software/stow/) to manage easy
packing/unpacking of configuration files. `make` will install everything for
you (if future me is reading this, thank past me for the laborious effort
of setting this up).

In addition, there's a small build process that's included in `make`. This
just involves my
[dotpreprocessor script](https://github.com/tonyd33/dotpreprocessor) that was
built to centralize shared variables and does a simple token replacement in
`.dot` files across the repo and spits out the built result for `stow` to ship
the changes.

# Screenshots

![image](https://github.com/tonyd33/dotfiles/blob/glass/screenshot1.png?raw=true)

![image](https://github.com/tonyd33/dotfiles/blob/glass/screenshot2.png?raw=true)
