##########ZSH###################################################################
##########ANTIGEN###############################################################
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
antigen bundle vundle
antigen bundle wd 
antigen bundle web-search 
antigen bundle yum 
antigen bundle zsh-autosuggestions

# COMLETIONS
# TODO: https://github.com/github/hub/blob/master/etc/hub.zsh_completion
# Syntax highlighting bundle.
antigen bundle https://github.com/hchbaw/opp.zsh.git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle https://github.com/b4b4r07/zsh-vimode-visual.git

# THEMES
antigen theme crunch
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
# https://github.com/Luciditi/powerlevel9k
antigen theme bhilburn/powerlevel9k powerlevel9k

# APPLY CONFIG
antigen apply
##########ANTIGEN###############################################################

##########OMZ###################################################################

# DYNAMIC THEME:
# Check for ZDOTDIR to detect PHPStorm
if [[ ("$TERM" = "xterm-256color" || "$TERM" = "screen") && -z "${ZDOTDIR+X}" ]] ; then

  # Setup awesome fonts & config PL9K
  if [[ -d "$HOME/.fonts" ]] ; then
    source $HOME/.fonts/*.sh
  fi

##########P9K###################################################################
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
  #POWERLEVEL9K_MODE='awesome-fontconfig'
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

# Add custom ZSH completions
#fpath=($ZSH_CUSTOM/completions $fpath)
#autoload -U compinit && compinit -u
# @TODO: Load bin/function/completion/phar/multi-dirs

##########PLUGINS CONFIGURATION#################################################
#SUDO: Ctrl+z to sudo command
bindkey "^z" sudo-command-line

#ZSH-AUTOSUGGESTIONS: Ctrl+Space to auto complete history command
bindkey '^ ' autosuggest-accept

#VI MODE: Ctrl+Space to auto complete history command
#10 ms key sequence for VI mode
KEYTIMEOUT=1

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

# Fix shift-tab bug: See https://github.com/robbyrussell/oh-my-zsh/pull/3761
bindkey '^[[Z' reverse-menu-complete

##########OMZ###################################################################
##########ZSH###################################################################
