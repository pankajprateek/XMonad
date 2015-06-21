
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias emacs="emacs -nw"
alias gti="git"
alias e="emacs"
alias ne="emacs -nw"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git sudo z python svn coloured-man)

source $ZSH/oh-my-zsh.sh

# User configuration

# export PATH=$HOME/bin:$HOME/.gem/ruby/2.1.0/bin:/usr/local/bin:$PATH
# export PATH=$HOME/.cabal/bin/:$PATH
export MANPATH="/usr/local/man:$MANPATH"
source .zshenv

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs -nw'
else
  export EDITOR='emacs -nw'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/"

source /home/pankaj/scripts/z/z.sh
unset GREP_OPTIONS

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
  export PS1="%{$fg_bold[white]%}%M "$PS1
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) 
	  SESSION_TYPE=remote/ssh
	  export PS1="%{$fg_bold[white]%}%M "$PS1;;
  esac
fi

if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
#  unfunction precmd
 # unfunction preexec
  PS1='%c $ '
else
    cat << 'EOF'
[H[2J
        [1;36m,[1;36m                       _     _ _
       [1;36m/#\[1;36m        __ _ _ __ ___| |__ | (_)_ __  _   ___  __
      [1;36m,###\[1;36m      / _` | '__/ __| '_ \| | | '_ \| | | \ \/ /
     [1;36m/#####\[1;36m    | (_| | | | (__| | | | | | | | | |_| |>  <
    [1;36m/##[0;36m,-,##\[1;36m    \__,_|_|  \___|_| |_|_|_|_| |_|\__,_/_/\_\
   [0;36m/##(   )##`
  [0;36m/#.--   --.#\[1;37m   A simple, lightweight linux distribution.
 [0;36m/`           `\[0m
EOF
  fortune | cowsay -f $(ls /usr/share/cows/ | shuf -n1) | lolcat
fi
