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

##########ZSH###################################################################

# DYNAMIC THEME:
# Check for ZDOTDIR to detect PHPStorm
if [[ ("$TERM" = "xterm-256color" || "$TERM" = "screen") && -z "${ZDOTDIR+X}" ]] ; then

  # Setup awesome fonts & config PL9K
  if [[ -d "$HOME/.fonts" ]] ; then
    source $HOME/.fonts/*.sh
  fi

  # PL9K Theme Options

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

  ZSH_THEME="powerlevel9k/powerlevel9k"
else
  ZSH_THEME="crunch"
fi

