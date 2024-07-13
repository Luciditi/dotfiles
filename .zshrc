# UNCOMMENT TO PROFILE:
#zmodload zsh/zprof

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#######   BREW #################################################################
if [[ ! -x "$(command -v brew)" && -d "/home/linuxbrew/" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

#######   M1   #################################################################
CPU=$(sysctl -n machdep.cpu.brand_string 2>&1 || true)
if [[ $CPU =~ "M1" ]]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

#######   ANTIGEN   ############################################################
HB=$(brew config | grep HOMEBREW_PREFIX | cut -d':' -f2 | xargs)
source $HB/share/antigen/antigen.zsh

# OMZ
# https://github.com/Luciditi/oh-my-zsh
antigen use oh-my-zsh

if [[ ! -d "$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/cache/completions" ]]; then
  mkdir -p "$HOME/.antigen/bundles/robbyrussell/oh-my-zsh/cache/completions"
fi

# PLUGINS
# Bundles from oh-my-zsh
antigen bundle aws
antigen bundle battery
antigen bundle composer
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle heroku
antigen bundle httpie
antigen bundle gcloud
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
antigen bundle terraform
antigen bundle urltools
antigen bundle vagrant
antigen bundle vi-mode
antigen bundle vundl
antigen bundle wd
antigen bundle web-search
antigen bundle yum
antigen bundle z

# Other ZSH plugins
antigen bundle AlexisBRENON/oh-my-zsh-reminder
antigen bundle djui/alias-tips
antigen bundle Valiev/almostontop 
antigen bundle changyuheng/fz
antigen bundle cal2195/q
antigen bundle gerges/oh-my-zsh-jira-plus
antigen bundle hchbaw/opp.zsh
antigen bundle hchbaw/zce.zsh
antigen bundle macunha1/zsh-terraform
antigen bundle MichaelAquilina/zsh-auto-notify
antigen bundle MichaelAquilina/zsh-history-filter
antigen bundle supercrabtree/k
antigen bundle unixorn/docker-helpers.zshplugin 
antigen bundle unixorn/git-extra-commands
antigen bundle zsh-users/zsh-autosuggestions@v0.5.0
antigen bundle zsh-vi-more/vi-motions
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle b4b4r07/zsh-vimode-visual

# THEMES
antigen theme crunch
if [[ -f "$HOME/.zshrc.theme" ]]; then
  THEME=$(cat "$HOME/.zshrc.theme")
  antigen theme "$THEME"
else
  POWERLEVEL10K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/romkatv/powerlevel10k
  antigen theme romkatv/powerlevel10k
fi

# APPLY CONFIG
antigen apply
#######   ANTIGEN   ############################################################

#######   OMZ   ################################################################

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

# Check bin existence
function exists { which $1 &> /dev/null }

#ZSH-AUTOSUGGESTIONS: Ctrl+Space to auto complete history command | (or Ctrl+R if empty)
function _zle-autosuggest-accept {
  if [ -z "$BUFFER" ]; then
    percol_select_history
  else
    zle autosuggest-accept
  fi
}
zle -N _zle-autosuggest-accept
bindkey '^ ' _zle-autosuggest-accept

#HELP: K to load man page for command
bindkey -M vicmd 'K' run-help

#VI MODE: Ctrl+Space to auto complete history command
#10 ms key sequence for VI mode
KEYTIMEOUT=1

# Use B in cmd mode for editing buffer in vim
zle -N edit-command-line
bindkey -M vicmd 'B' edit-command-line

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

bindkey -M vicmd '^ ' zce
# Filters for history
#export HISTORY_FILTER_EXCLUDE=("" "")
#######   OMZ   ################################################################


#######   ALIASES   ############################################################
source "$HOME/.sh/alias"

#######   FUNCTIONS   ##########################################################
source "$HOME/.sh/functions/cpv"
source "$HOME/.sh/functions/docker"
source "$HOME/.sh/functions/macos"
source "$HOME/.sh/functions/misc"
source "$HOME/.sh/functions/iterm2"
source "$HOME/.zsh/functions/misc"
source "$HOME/.zsh/functions/iterm2-shell-integration"

#######   COMPLETIONS   ########################################################
# Add custom ZSH completions
fpath=("$HOME/.zsh/completions" $fpath)
# cache only once a day
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

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
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Configure Cargo Path
export PATH=$PATH:$HOME/.cargo/bin

# Add Custom Project Config in "$HOME/.projects/*/config"
if [ -d "$HOME/.projects/" ]; then
  PROJECTS=$(find "$HOME/.projects/" -type d -maxdepth 1 -mindepth 1 | sort)
  while IFS= read -r PROJECT; do
    if [ -f "$PROJECT/config" ]; then
      source "$PROJECT/config"
    fi
  done <<< "$PROJECTS"
fi

# Export / File Mask
export PATH
umask 007
#######   ZSH   ################################################################

# Expand history length
HISTSIZE=200000
SAVEHIST=200000

# More prominent EOL
PROMPT_EOL_MARK=""

#######   APP CONFIG   #########################################################

#######   ALMOSONTOP   #########################################################
ALMOSONTOP=false

#######   ATUIN   ##############################################################

# init w/disable up arrow mode
eval "$(atuin init zsh --disable-up-arrow)"

# bind to Ctrl+u
bindkey '^u' atuin-search

# bind to the up key, which depends on terminal mode
#bindkey '^[[A' atuin-up-search
#bindkey '^[OA' atuin-up-search

#######   AUTONOTIFY   #########################################################
# Add docker to list of ignored commands (also: disable_auto_notify /enable_auto_notify)
AUTO_NOTIFY_IGNORE+=("bat"  "docker" "g" "vi")

#######   CHEAT   ##############################################################
export CHEAT_EDITOR="vim"
export CHEATCOLORS=true

#######   DIRENV   #############################################################
eval "$(direnv hook zsh)"

#######   FZF   ################################################################
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#######   ORACLE   #############################################################
# Setup Oracle Environment If Installed
if [ -d /usr/lib/oracle/instantclient ]; then
  export ORACLE_HOME=/usr/lib/oracle/instantclient
  export LD_LIBRARY_PATH=$ORACLE_HOME/
  export TNS_ADMIN=/etc
  export NLS_LANG=AMERICAN_AMERICA.UTF8
fi

##########P10K##################################################################

# DYNAMIC THEME:
# Check for ZDOTDIR to detect PHPStorm
if [[ ("$TERM" = "xterm-256color" || "$TERM" = "screen") && -z "${ZDOTDIR+X}" ]] ; then
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  ZSH_THEME="crunch"
fi
##########P10K##################################################################

# UNCOMMENT TO PROFILE:
#zprof
