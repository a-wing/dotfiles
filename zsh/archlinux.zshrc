# wget -O ~/.zshrc.grml https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
# source $HOME/.zshrc.grml
# source $HOME/Code/grml-etc-core/etc/zsh/zshrc

# Configuring Completions
autoload -Uz promptinit
promptinit

# Set Theme
#prompt adam2


# prompt grml
# Use two lines prompt
function prompt_grml_precmd () {
    emulate -L zsh
    local grmltheme=grml
    local -a left_items right_items
    left_items=(rc change-root user at host path vcs newline percent)
    right_items=(sad-smiley)

    prompt_grml_precmd_worker
}

prompt_grml_precmd


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

