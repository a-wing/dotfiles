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
* <kbd>⌥ Option</kbd> + <kbd>x</kbd> directory-history
* <kbd>⌥ Option</kbd> + <kbd>s</kbd> quick-sudo

## directory-history

Display the used path stack list, select the jump path

## quick-sudo

Your input:

```sh
$ ls
```

Press <kbd>⌥ Option</kbd> + <kbd>s</kbd> Key

Auto added prefix `sudo `

```sh
$ sudo ls
```

Again press <kbd>⌥ Option</kbd> + <kbd>s</kbd> Key

Auto dropped prefix `sudo `

```sh
$ ls
```

