
##########ALIASES###############################################################
source "$HOME/.sh/alias"

##########FUNCTIONS#############################################################
source $HOME/.sh/functions/macos
source $HOME/.sh/functions/git-aliases
source $HOME/.sh/functions/misc

##########COMPLETIONS###########################################################
autoload bashcompinit
bashcompinit
source "$HOME/.sh/completions/"*
#source "$HOME/.drush/drush.complete.sh"

##########SOURCES###############################################################
