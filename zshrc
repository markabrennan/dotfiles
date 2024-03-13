set -o vi
bindkey -v
# Taking some options from:
# https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
set -o AUTO_CD
# correct commands
set -o CORRECT
# correct all arguments
set -o CORRECT_ALL
set -o  NO_CASE_GLOB
set -o  EXTENDED_HISTORY
# share history across multiple zsh sessions
set -o SHARE_HISTORY
# append to history
set -o APPEND_HISTORY
set -o INC_APPEND_HISTORY
# expire duplicates first
set -o HIST_EXPIRE_DUPS_FIRST 
# do not store duplications
set -o HIST_IGNORE_DUPS
#ignore duplicates when searching
set -o HIST_FIND_NO_DUPS
# removes blank lines from history
set -o HIST_REDUCE_BLANKS
set -o HIST_IGNORE_SPACE
set -o HIST_VERIFY


# enable powerful zsh auto completion
autoload -Uz compinit && compinit

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="bira"
#ZSH_THEME="Jonathan"
#ZSH_THEME="Gnzh"
#ZSH_THEME="Kphoen"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git poetry)
plugins+=(zsh-vi-mode)
plugins+=(git zsh-autosuggestions)
plugins+=(git zsh-syntax-highlighting)
plugins+=(git zsh-bat)


source $ZSH/oh-my-zsh.sh


###########################################################
# User configuration
###########################################################
#
# Connecting to resources inside AWS VPCs
function ec2get() {
  INSTANCE=$1
  ATTR=$2
  VALUE=$(
    aws ec2 describe-instances --filters \
    "Name=tag:Name,Values=${INSTANCE}" \
    --query "Reservations[*].Instances[*].[InstanceId,LaunchTime,${ATTR}]" \
    --output text | sort -k 2 | tail -1| awk '{print $3}'
  )
  echo $VALUE
}
#function ssmsh() {
  #SPEC=$1
  #PARAMS=""
  #if [[ $SPEC = *@* ]]; then
    #USER=${SPEC%@*}
    #PARAMS="command='sudo su $USER'"
  #else
    #PARAMS="command='bash'"
  #fi
  #HOST=${SPEC#*@}
  #if [[ $HOST = i-* ]]; then
    #ID=$HOST
  #else
    #ID=$(ec2get $HOST InstanceId)
  #fi
  #aws ssm start-session --target $ID \
    #--document-name AWS-StartInteractiveCommand --parameters $PARAMS
#}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

###########################################################

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='/usr/bin/vim'
 else
   export EDITOR='/usr/local/bin/mvim -v'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

###########################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias vim='nvim'
alias vi='mvim -v'
alias ll='eza -alF -snew' 
alias xl='xplr'

###########################################################


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(direnv hook zsh)"

###########################################################
# HISTORY settings
###########################################################
export HISTFILE=${HOME}/.zsh_history
export SAVEHIST=100000
export HISTSIZE=50000
export HISTCONTROL=ignorespace:ignoredups
setopt appendhistory

###########################################################
# PATH settings
###########################################################
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
#export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/openssl@3.2/bin:$PATH"
export PATH="/Users/markb/.vim/bundle/fzf/bin:$PATH"
export PATH="/Users/markb/projects/greenfield/scripts:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

# Previously needed to clean up old paths
#export PATH=$(echo $PATH|sed s'|:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin||' | sed s'|:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin||' | sed s'|:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin||')


# Apparently this is need to resolve openssl (-lssl) libraries for linking
# for the psycopg2 pip install!
export LDFLAGS="-I/usr/local/opt/openssl/include -L/usr/local/opt/openssl/lib" 

###########################################################
# Pyenv
###########################################################
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv virtualenv-init -)"
eval "$(pyenv init -)"
# virtualenv settings
export WORKON_HOME=$HOME/.virtualenvs   # Optional
# ensue we get the virtualenv prompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PROJECT_HOME=$HOME/projects      # Optional
#source /Users/markbrennan/.pyenv/shims/virtualenvwrapper.sh

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###########################################################
# Eza
###########################################################
export EZA_COLORS="da=32"
