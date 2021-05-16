# wget -O ~/.zshrc.grml https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
# source $HOME/.zshrc.grml

# Configuring Completions
autoload -Uz promptinit
promptinit

# Set Theme
prompt adam2

# Load Plugins
_ZSH_PLUGINS="/usr/share/zsh/plugins"
_enabled_plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
)

for _zsh_plugin in $_enabled_plugins[@]; do
  [[ ! -r "$_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh" ]] || source $_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh
done

source ~/dotfiles/zsh/config.sh

