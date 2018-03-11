
#######   ALIASES   ############################################################
source "$HOME/.sh/alias"

#######   FUNCTIONS   ##########################################################
source "$HOME/.sh/functions/macos"
source "$HOME/.sh/functions/git-aliases"
source "$HOME/.sh/functions/misc"
source "$HOME/.sh/functions/iterm2"
source "$HOME/.sh/functions/iterm2-shell-integration"

#######   COMPLETIONS   ########################################################
autoload bashcompinit
bashcompinit
source "$HOME/.sh/completions/"*
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
#######   BASH   ###############################################################
# Get the aliases and functions
if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

#Set File Colors
export CLICOLOR=1

#######   APP CONFIG   #########################################################


#######   CHEAT   ##############################################################
export CHEAT_EDITOR="vim"
export CHEATCOLORS=true

#######   ORACLE   #############################################################
# Setup Oracle Environment If Installed
if [ -d /usr/lib/oracle/instantclient ]; then
  export ORACLE_HOME=/usr/lib/oracle/instantclient
  export LD_LIBRARY_PATH=$ORACLE_HOME/
  export TNS_ADMIN=/etc
  export NLS_LANG=AMERICAN_AMERICA.UTF8
fi
