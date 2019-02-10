#######   ANTIGEN   ############################################################
# UNCOMMENT TO PROFILE:
#zmodload zsh/zprof

# @TODO: Determine if we'll lookup source
source /usr/local/share/antigen/antigen.zsh

# OMZ
# https://github.com/Luciditi/oh-my-zsh
antigen use oh-my-zsh

# PLUGINS
# Bundles from oh-my-zsh
antigen bundle aws
antigen bundle battery
antigen bundle composer
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle heroku
antigen bundle git
antigen bundle gitfast
antigen bundle git-extras
antigen bundle git_remote_branch
antigen bundle grunt
antigen bundle history
antigen bundle jira
antigen bundle jsontools
antigen bundle node
antigen bundle npm
antigen bundle nvm
antigen bundle osx
antigen bundle pip
antigen bundle redis-cli
antigen bundle rsync
antigen bundle safe-paste
antigen bundle sudo
antigen bundle symfony2
antigen bundle urltools
antigen bundle vagrant
antigen bundle vi-mode
antigen bundle vundl
antigen bundle wd
antigen bundle web-search
antigen bundle yum
antigen bundle z
antigen bundle zsh-autosuggestion

# Other ZSH plugins
antigen bundle changyuheng/fz
antigen bundle https://github.com/hchbaw/opp.zsh.git
antigen bundle supercrabtree/k
antigen bundle unixorn/git-extra-commands
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle https://github.com/b4b4r07/zsh-vimode-visual.git

# THEMES
antigen theme crunch
if [[ -f "$HOME/.zshrc.theme" ]]; then
  THEME=$(cat "$HOME/.zshrc.theme")
  antigen theme "$THEME"
else
  POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
  POWERLEVEL9K_MODE='awesome-fontconfig'
  # https://github.com/Luciditi/powerlevel9k
  antigen theme bhilburn/powerlevel9k powerlevel9k
fi

# APPLY CONFIG
antigen apply
#######   ANTIGEN   ############################################################

#######   OMZ   ################################################################

# DYNAMIC THEME:
# Check for ZDOTDIR to detect PHPStorm
if [[ ("$TERM" = "xterm-256color" || "$TERM" = "screen") && -z "${ZDOTDIR+X}" ]] ; then

##########P9K###################################################################
  # Setup awesome fonts & config PL9K
  if [[ -d "$HOME/.fonts" ]] ; then
    source $HOME/.fonts/*.sh
  fi

  ##### POWERLEVEL9K_CUSTOM_WIFI_SIGNAL:
  POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="black"
  POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="yellow"
  function zsh_wifi_signal() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
      AIRPORT="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
      if [ -x "$(command -v $AIRPORT)" ]; then
        SIGNAL=$(${AIRPORT} -I | grep 'agrCtlRSSI' | sed -e 's/^.*://g' | xargs -I SIGNAL echo "SIGNAL")
        local COLOR='%F{yellow}'
        [[ $SIGNAL -lt -80 ]] && COLOR='%F{red}'
        [[ $SIGNAL -gt -60 ]] && COLOR='%F{green}'
        [[ ! "$SIGNAL" =~ "^-?[0-9]+([0-9]+)?$" ]] && COLOR='%F{red}'
        echo -n "%{$COLOR%} $SIGNAL%{%f%}"
      fi
    fi
  }
  POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
  ##### POWERLEVEL9K_CUSTOM_WIFI_SIGNAL:

  # Set PL9K Segment options
  POWERLEVEL9K_CHANGESET_HASH_LENGTH=7
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=10
  #POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon load ram disk_usage swap custom_wifi_signal ip public_ip battery newline)
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_wifi_signal context root_indicator dir dir_writable vcs vi_mode)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs history time)
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  POWERLEVEL9K_SHOW_CHANGESET=true
  POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false

  source "$HOME/.zsh/powerlevel9k-override.zsh-theme"
##########P9K###################################################################
else
  ZSH_THEME="crunch"
fi

#Hide host on local machine
DEFAULT_USER=me

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Smart URLs (escape control chars)
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

#Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

##########PLUGINS CONFIGURATION#################################################
#SUDO: !! to sudo command
bindkey -M vicmd '!!' sudo-command-line

#ZSH-AUTOSUGGESTIONS: Set highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

#ZSH-AUTOSUGGESTIONS: Ctrl+\ to remove auto complete suggestion
# Requires iterm2 ^⌫  to be mapped to ESC sequence: "[[CD"
bindkey '^[[[CD' autosuggest-clear

#ZSH-AUTOSUGGESTIONS: Ctrl+Enter to auto complete history command & execute
# Requires iterm2 ^⏎  to be mapped to ESC sequence: "[[CE"
bindkey '^[[[CE' autosuggest-execute

#ZSH-AUTOSUGGESTIONS: Ctrl+Space to auto complete history command
bindkey '^ ' autosuggest-accept

#HELP: K to load man page for command
bindkey -M vicmd 'K' run-help

#VI MODE: Ctrl+Space to auto complete history command
#10 ms key sequence for VI mode
KEYTIMEOUT=1

# Use ctrl+v in cmd mode for editing buffer in vim
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

#Set custom cursor for vi mode
function zle-keymap-select zle-line-init {
  # change cursor shape in iTerm2
  case $KEYMAP in
    vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
    viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
  esac

  zle reset-prompt
  zle -R
}
function zle-line-finish {
  print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

#Fix search results to reverse cron
history-beginning-search-backward-then-append() {
  zle history-beginning-search-backward
  zle vi-add-eol
}
zle -N history-beginning-search-backward-then-append

# Bind L in normal/visual mode to EOL
bindkey -M vicmd 'L' end-of-line
bindkey -M vivis 'L' vi-visual-eol

# 'i' will switch back to insert mode
bindkey -M vivis 'i' vi-visual-exit-to-insert

# Fix shift-tab bug: See https://github.com/robbyrussell/oh-my-zsh/pull/3761
bindkey '^[[Z' reverse-menu-complete
#######   OMZ   ################################################################


#######   ALIASES   ############################################################
source "$HOME/.sh/alias"

#######   FUNCTIONS   ##########################################################
source "$HOME/.sh/functions/cpv"
source "$HOME/.sh/functions/macos"
source "$HOME/.sh/functions/misc"
source "$HOME/.sh/functions/iterm2"
source "$HOME/.sh/functions/iterm2-shell-integration"
source "$HOME/.zsh/functions/misc"

#######   COMPLETIONS   ########################################################
# Add custom ZSH completions
fpath=("$HOME/.zsh/completions" $fpath)
autoload -U compinit && compinit -u

autoload bashcompinit
bashcompinit
for SCRIPT in "$HOME"/.sh/completions/*.bash; do source "$SCRIPT"; done
#source "$HOME/.drush/drush.complete.sh"

#######   SOURCES   ############################################################

# Set custom bin paths
PATH=$PATH:$HOME/.bin

# Configure Go Paths
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Add Custom Config
if [ -f "$HOME/.luciditi/config" ]; then
  source "$HOME/.luciditi/config"
fi

# Export / File Mask
export PATH
umask 007
#######   ZSH   ################################################################

# Expand history size to 100K
HISTSIZE=100000
SAVEHIST=100000

#######   APP CONFIG   #########################################################


#######   CHEAT   ##############################################################
export CHEAT_EDITOR="vim"
export CHEATCOLORS=true

#######   DIRENV   #############################################################
eval "$(direnv hook zsh)"

#######   FZF   ################################################################
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

#######   ORACLE   #############################################################
# Setup Oracle Environment If Installed
if [ -d /usr/lib/oracle/instantclient ]; then
  export ORACLE_HOME=/usr/lib/oracle/instantclient
  export LD_LIBRARY_PATH=$ORACLE_HOME/
  export TNS_ADMIN=/etc
  export NLS_LANG=AMERICAN_AMERICA.UTF8
fi

# UNCOMMENT TO PROFILE:
#zprof
