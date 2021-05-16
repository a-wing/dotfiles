# Zsh-config

<!-- vim-markdown-toc GFM -->

* [Common](#common)
  * [Depend](#depend)
  * [Install](#install)
  * [Feature](#feature)
  * [directory-history](#directory-history)
  * [quick-sudo](#quick-sudo)
* [Archlinux](#archlinux)
  * [Depend](#depend-1)
  * [Install](#install-1)

<!-- vim-markdown-toc -->

## Common

### Depend

* fzf
* zimfw (opt)
* sudo (opt)

### Install

`.zshrc` append

```sh
source ${HOME}/dotfiles/zsh/config.sh
```

### Feature

* <kbd>⌃ Control</kbd> + <kbd>r</kbd> fzf-history
* <kbd>⌃ Control</kbd> + <kbd>t</kbd> transpose-chars
* <kbd>⌃ Control</kbd> + <kbd>s</kbd> quick-sudo
* <kbd>⌥ Option</kbd> + <kbd>x</kbd> directory-history

### directory-history

Display the used path stack list, select the jump path

### quick-sudo

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

## Archlinux

### Depend

* grml-zsh-config
* zsh-autosuggestions
* zsh-syntax-highlighting
* zsh-completions

### Install

```sh
pacman -S grml-zsh-config zsh-autosuggestions zsh-syntax-highlighting zsh-completions
```

`.zshrc` append

```sh
source ${HOME}/dotfiles/zsh/config.sh
```

