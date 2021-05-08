
source /usr/local/opt/fzf/shell/completion.zsh
source /usr/local/opt/fzf/shell/key-bindings.zsh
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

quick-sudo-widget() {
  local cmd="sudo "
  if [[ ${LBUFFER:0:${#cmd}} == ${cmd} ]]; then
    LBUFFER="${LBUFFER:${#cmd}}"
  else
    LBUFFER="${cmd}${LBUFFER}"
  fi
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N    quick-sudo-widget

# Default ALT-S, For Mac OS: Option-S
if [[ `uname` == "Darwin" ]]; then
  bindkey 'ß' quick-sudo-widget
else
  bindkey '\es' quick-sudo-widget
fi


# Frok from: https://github.com/ohmyzsh/ohmyzsh/blob/71cc861806f30d8f7fd3d0040db86737cab62581/lib/directories.zsh
alias -g ...='../..'
alias -g ....='../../..'

#alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
#alias 3='cd -3'

# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# This completion so slow
# source <(kubectl completion zsh)
#if command kubectl > /dev/null; then
#	#source <(kubectl completion zsh)
#	source ~/.zsh-completions/_kubectl.zsh
#fi

# kubectl completion zsh > ~/.zsh-completions/_kubectl.zsh
if [[ -d "${HOME}/.zsh-completions" ]]; then
	FPATH=${HOME}/.zsh-completions:$FPATH
fi

#autoload -Uz compinit
#compinit


export EDITOR='nvim'
export VISUAL='nvim'

