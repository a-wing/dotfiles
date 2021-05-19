
# Disable flowcontrol
# unset Ctrl-S && Ctrl-Q
unsetopt flowcontrol
stty -ixon


# bindkey '\eq' push-line
# Need support heredoc
bindkey '\eq' push-line-or-edit

# FZF Plugin
if [[ `uname` == "Darwin" ]]; then
  # brew --prefix fzf
  # source $(brew --prefix fzf)/shell/completion.zsh
  # source $(brew --prefix fzf)/shell/key-bindings.zsh
  _FZF_PLUGINS=${_FZF_PLUGINS:="/usr/local/opt/fzf/shell"}
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

# https://github.com/grml/grml-etc-core/pull/119
sudo-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  local cmd="sudo "
  if [[ ${BUFFER} == ${cmd}* ]]; then
    CURSOR=$(( CURSOR-${#cmd} ))
    BUFFER="${BUFFER#$cmd}"
  else
    BUFFER="${cmd}${BUFFER}"
    CURSOR=$(( CURSOR+${#cmd} ))
  fi
  zle reset-prompt
}

zle     -N    sudo-command-line
bindkey '^S'  sudo-command-line

# Ctrl-Q, heredoc
# bindkey '^Q' push-line
bindkey '^Q' push-line-or-edit
bindkey '^[Q' push-line-or-edit
bindkey '^[q' push-line-or-edit

# Frok from: https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_zsh
nnn_cd () {
  # Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
  # To cd on quit only on ^G, remove the "export" as in:
  #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  # NOTE: NNN_TMPFILE is fixed, should not be modified
  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef

  nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

#bindkey -s '^N' 'nnn_cd\n'


# Fork from: https://github.com/ranger/ranger/blob/master/examples/shell_automatic_cd.sh
ranger_cd() {
  local temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX.${USERNAME}")"
  ranger --choosedir="$temp_file" -- "${@:-$PWD}"
  if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
    cd -- "$chosen_dir"
  fi
  rm -f -- "$temp_file"
}

# This binds Ctrl-O to ranger_cd:
#bindkey -s '^O' 'ranger_cd\n'
bindkey -s '^N' 'ranger_cd\n'



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

