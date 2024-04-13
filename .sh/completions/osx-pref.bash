#/usr/bin/env bash

# Complete macos-pref based on pref pane dir.
_macos-pref_completions()
{
  if [[ -d "/System/Library/PreferencePanes" ]]; then
    PREF_PANES=$(ls /System/Library/PreferencePanes/ | sed -e 's/\.prefPane//g')
  else
    PREF_PANES=""
  fi
  COMPREPLY=($(compgen -W "$PREF_PANES" "${COMP_WORDS[1]}"))
}
complete -F _macos-pref_completions macos-pref
