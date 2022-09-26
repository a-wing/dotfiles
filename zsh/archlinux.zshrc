# wget -O ~/.zshrc.grml https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
# source ${HOME}/Code/grml-etc-core/etc/zsh/zshrc
if [[ -f "${HOME}/.zshrc.grml" ]]; then
	source "${HOME}/.zshrc.grml"
fi

# Set Theme
# http://bewatermyfriend.org/p/2013/001/
if [[ -z "${SSH_TTY}" ]]; then
	zstyle ':prompt:grml:left:setup' items rc change-root path vcs newline percent
else
	zstyle ':prompt:grml:left:setup' items rc change-root user at host path vcs newline percent
fi

prompt grml


# Configuring Completions
autoload -Uz promptinit
promptinit

zstyle ':completion:*' menu select

# Load Plugins
_ZSH_PLUGINS="/usr/share/zsh/plugins"
if [[ -f "`which brew`" ]]; then
	_ZSH_PLUGINS="$(brew --prefix)/share"
fi

_enabled_plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-history-substring-search
)

for _zsh_plugin in $_enabled_plugins[@]; do
  [[ ! -r "$_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh" ]] || source $_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh
done

# zsh-history-substring-search
bindkey "^[OA" history-substring-search-up
bindkey "^[OB" history-substring-search-down

# source ~/dotfiles/zsh/config.sh

alias vim=nvim

# source /home/metal/.config/broot/launcher/bash/br
