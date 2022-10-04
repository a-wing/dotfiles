
# https://docs.brew.sh/Shell-Completion
#if type brew &>/dev/null; then
#	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
#fi

### nerdctl
# ln -s `which nerdctl.lima` ~/.bin/nerdctl
# nerdctl completion zsh > ~/.zsh-completions/_nerdctl

if [[ -d "${HOME}/.zsh-completions" ]]; then
	FPATH="${HOME}/.zsh-completions:${FPATH}"
fi

# Configuring Completions
# Grml is enabled promptinit, not set
# autoload -Uz promptinit; promptinit

# wget -O ~/.zshrc.grml https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
# source ${HOME}/Code/grml-etc-core/etc/zsh/zshrc
if [[ -f "${HOME}/.zshrc.grml" ]]; then
	source "${HOME}/.zshrc.grml"
fi

### bash_completion
autoload -U +X bashcompinit && bashcompinit

# only `wg`, note: `wg-quick` must bash
source $(brew --prefix)/etc/bash_completion.d/wg

# Disable completion ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}!={A-Z}'

# Set few items style
zstyle ':completion:*' menu select


# Set Theme
# http://bewatermyfriend.org/p/2013/001/
if [[ -z "${SSH_TTY}" ]]; then
	zstyle ':prompt:grml:left:setup' items rc change-root path vcs newline percent
else
	zstyle ':prompt:grml:left:setup' items rc change-root user at host path vcs newline percent
fi

prompt grml


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

alias vim=nvim

# Disable flowcontrol
# unset Ctrl-S && Ctrl-Q
unsetopt flowcontrol
stty -ixon


# bindkey '\eq' push-line
# Need support heredoc
bindkey '\eq' push-line-or-edit

# Ctrl-Q, heredoc
# bindkey '^Q' push-line
bindkey '^Q' push-line-or-edit
bindkey '^[Q' push-line-or-edit
bindkey '^[q' push-line-or-edit

zle     -N    sudo-command-line
bindkey '^S'  sudo-command-line

# === FZF Plugin ===
if [[ `uname` == "Darwin" ]]; then
  # brew --prefix fzf
  _FZF_PLUGINS=${_FZF_PLUGINS:="$(brew --prefix fzf)/shell"}
else
  _FZF_PLUGINS=${_FZF_PLUGINS:="/usr/share/fzf"}
fi

source $_FZF_PLUGINS/key-bindings.zsh
source $_FZF_PLUGINS/completion.zsh

# CTRL-R - Paste the selected command from history into the command line
# CTRL-T - Paste the selected file path(s) into the command line
# ALT-C - cd into the selected directory

# Disable fzf CTRL-T, use zsh default
# bindkey '^T' fzf-file-widget
bindkey '^T' transpose-chars


# Default ALT-C, For Mac OS: Option-C
if [[ `uname` == "Darwin" ]]; then
	bindkey 'ç' fzf-cd-widget
fi


fzf-dirs-widget() {
  # eval cd $(dirs -v | fzf --height 40% --reverse | cut -b3-)
  local dir=$(dirs -v | fzf --height ${FZF_TMUX_HEIGHT:-40%} --reverse | cut -b3-)
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  eval cd ${dir}
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}

zle     -N    fzf-dirs-widget

# Default ALT-X, For Mac OS: Option-X
if [[ `uname` == "Darwin" ]]; then
  bindkey '≈' fzf-dirs-widget
else
  bindkey '\ex' fzf-dirs-widget
fi

# === FZF Plugin ===


# Load path
_enabled_paths=(
  'go/bin'
  '.bin'
  '.local/bin'
  '.cargo/bin'
)

for _enabled_path in $_enabled_paths[@]; do
  [[ -d "$HOME/${_enabled_path}" ]] && PATH="$HOME/${_enabled_path}:$PATH"
done


# Frok from: https://github.com/ohmyzsh/ohmyzsh/blob/71cc861806f30d8f7fd3d0040db86737cab62581/lib/directories.zsh
alias -g ...='../..'
alias -g ....='../../..'

#alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'

export EDITOR='nvim'
export VISUAL='nvim'

