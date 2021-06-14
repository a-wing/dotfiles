# wget -O ~/.zshrc.grml https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
# source $HOME/.zshrc.grml
# source $HOME/Code/grml-etc-core/etc/zsh/zshrc

# Configuring Completions
autoload -Uz promptinit
promptinit

# Set Theme
# http://bewatermyfriend.org/p/2013/001/
zstyle ':prompt:grml:left:setup' items rc change-root user at host path vcs newline percent

prompt grml


# Load Plugins
_ZSH_PLUGINS="/usr/share/zsh/plugins"
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

source ~/dotfiles/zsh/config.sh

