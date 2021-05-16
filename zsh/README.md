# nvim

## Depend

* fzf
* zimfw (opt)
* sudo (opt)

## Install

`.zshrc` append

```sh
source ${HOME}/dotfiles/zsh/config.sh
```

## Feature

* <kbd>⌃ Control</kbd> + <kbd>r</kbd> fzf-history
* <kbd>⌃ Control</kbd> + <kbd>t</kbd> transpose-chars
* <kbd>⌃ Control</kbd> + <kbd>s</kbd> quick-sudo
* <kbd>⌥ Option</kbd> + <kbd>x</kbd> directory-history

## directory-history

Display the used path stack list, select the jump path

## quick-sudo

Your input:

```sh
ls
```

Press `Ctrl+s` Keys

Auto added prefix `sudo`

```sh
sudo ls
```

Again press `Ctrl+s` Keys

Auto dropped prefix `sudo`

```sh
ls
```

