# vim:ft=zsh ts=2 sw=2 sts=2
#

# If set_default not defined, we must be on a different theme so don't continue.
if ( ! typeset -f set_default > /dev/null); then
  return 0
fi

#CUSTOM DIR PROMPT
prompt_dir() {

  local current_path="$(print -P "%~")"
  if [[ -n "$POWERLEVEL9K_SHORTEN_DIR_LENGTH" || "$POWERLEVEL9K_SHORTEN_STRATEGY" == "truncate_with_folder_marker" ]]; then
    set_default POWERLEVEL9K_SHORTEN_DELIMITER $'\U2026'

    case "$POWERLEVEL9K_SHORTEN_STRATEGY" in
      truncate_middle)
        current_path=$(pwd | sed -e "s,^$HOME,~," | sed $SED_EXTENDED_REGEX_PARAMETER "s/([^/]{$POWERLEVEL9K_SHORTEN_DIR_LENGTH})[^/]+([^/]{$POWERLEVEL9K_SHORTEN_DIR_LENGTH})\//\1$POWERLEVEL9K_SHORTEN_DELIMITER\2\//g")
      ;;
      truncate_from_right)
        current_path=$(truncatePathFromRight "$(pwd | sed -e "s,^$HOME,~,")" )
      ;;
      truncate_with_package_name)
        local name repo_path package_path current_dir zero

        # Get the path of the Git repo, which should have the package.json file
        if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]]; then
          # Get path from the root of the git repository to the current dir
          local gitPath=$(git rev-parse --show-prefix)
          # Remove trailing slash from git path, so that we can
          # remove that git path from the pwd.
          gitPath=${gitPath%/}
          package_path=${$(pwd)%%$gitPath}
          # Remove trailing slash
          package_path=${package_path%/}
        elif [[ $(git rev-parse --is-inside-git-dir 2> /dev/null) == "true" ]]; then
          package_path=${$(pwd)%%/.git*}
        fi

        # Replace the shortest possible match of the marked folder from
        # the current path. Remove the amount of characters up to the
        # folder marker from the left. Count only the visible characters
        # in the path (this is done by the "zero" pattern; see
        # http://stackoverflow.com/a/40855342/5586433).
        local zero='%([BSUbfksu]|([FB]|){*})'
        current_dir=$(pwd)
        # Then, find the length of the package_path string, and save the
        # subdirectory path as a substring of the current directory's path from 0
        # to the length of the package path's string
        subdirectory_path=$(truncatePathFromRight "${current_dir:${#${(S%%)package_path//$~zero/}}}")
        # Parse the 'name' from the package.json; if there are any problems, just
        # print the file path
        defined POWERLEVEL9K_DIR_PACKAGE_FILES || POWERLEVEL9K_DIR_PACKAGE_FILES=(package.json composer.json)

        local pkgFile="unknown"
        for file in "${POWERLEVEL9K_DIR_PACKAGE_FILES[@]}"; do
          if [[ -f "${package_path}/${file}" ]]; then
            pkgFile="${package_path}/${file}"
            break;
          fi
        done

        local packageName=$(jq '.name' ${pkgFile} 2> /dev/null \
          || node -e 'console.log(require(process.argv[1]).name);' ${pkgFile} 2>/dev/null \
          || cat "${pkgFile}" 2> /dev/null | grep -m 1 "\"name\"" | awk -F ':' '{print $2}' | awk -F '"' '{print $2}' 2>/dev/null \
          )
        if [[ -n "${packageName}" ]]; then
          # Instead of printing out the full path, print out the name of the package
          # from the package.json and append the current subdirectory
          current_path="`echo $packageName | tr -d '"'`$subdirectory_path"
        else
          current_path=$(truncatePathFromRight "$(pwd | sed -e "s,^$HOME,~,")" )
        fi
      ;;
      truncate_with_folder_marker)
        local last_marked_folder marked_folder
        set_default POWERLEVEL9K_SHORTEN_FOLDER_MARKER ".shorten_folder_marker"

        # Search for the folder marker in the parent directories and
        # buildup a pattern that is removed from the current path
        # later on.
        for marked_folder in $(upsearch $POWERLEVEL9K_SHORTEN_FOLDER_MARKER); do
          if [[ "$marked_folder" == "/" ]]; then
            # If we reached root folder, stop upsearch.
            current_path="/"
          elif [[ "$marked_folder" == "$HOME" ]]; then
            # If we reached home folder, stop upsearch.
            current_path="~"
          elif [[ "${marked_folder%/*}" == $last_marked_folder ]]; then
            current_path="${current_path%/}/${marked_folder##*/}"
          else
            current_path="${current_path%/}/$POWERLEVEL9K_SHORTEN_DELIMITER/${marked_folder##*/}"
          fi
          last_marked_folder=$marked_folder
        done

        # Replace the shortest possible match of the marked folder from
        # the current path.
        current_path=$current_path${PWD#${last_marked_folder}*}
      ;;
      truncate_to_unique)
        # for each parent path component find the shortest unique beginning
        # characters sequence. Source: https://stackoverflow.com/a/45336078
        paths=(${(s:/:)PWD})
        cur_path='/'
        cur_short_path='/'
        for directory in ${paths[@]}
        do
          cur_dir=''
          for (( i=0; i<${#directory}; i++ )); do
            cur_dir+="${directory:$i:1}"
            matching=("$cur_path"/"$cur_dir"*/)
            if [[ ${#matching[@]} -eq 1 ]]; then
              break
            fi
          done
          cur_short_path+="$cur_dir/"
          cur_path+="$directory/"
        done
        current_path="${cur_short_path: : -1}"
      ;;
      *)
        current_path="$(print -P "%$((POWERLEVEL9K_SHORTEN_DIR_LENGTH+1))(c:$POWERLEVEL9K_SHORTEN_DELIMITER/:)%${POWERLEVEL9K_SHORTEN_DIR_LENGTH}c")"
      ;;
    esac
  fi

  if [[ "${POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER}" == "true" ]]; then
    current_path="${current_path[2,-1]}"
  fi

  if [[ "${POWERLEVEL9K_DIR_PATH_SEPARATOR}" != "/" ]]; then
    current_path="$( echo "${current_path}" | sed "s/\//${POWERLEVEL9K_DIR_PATH_SEPARATOR}/g")"
  fi

  if [[ "${POWERLEVEL9K_HOME_FOLDER_ABBREVIATION}" != "~" ]]; then
    current_path=${current_path/#\~/${POWERLEVEL9K_HOME_FOLDER_ABBREVIATION}}
  fi

  typeset -AH dir_states
  dir_states=(
    "DEFAULT"         "FOLDER_ICON"
    "HOME"            "HOME_ICON"
    "HOME_SUBFOLDER"  "HOME_SUB_ICON"
    "NOT_WRITABLE"    "LOCK_ICON"
  )
  local current_state="DEFAULT"
  if [[ "${POWERLEVEL9K_DIR_SHOW_WRITABLE}" == true && ! -w "$PWD" ]]; then
    current_state="NOT_WRITABLE"
  elif [[ $(print -P "%~") == '~' ]]; then
    current_state="HOME"
  elif [[ $(print -P "%~") == '~'* ]]; then
    current_state="HOME_SUBFOLDER"
  fi
  "$1_prompt_segment" "$0_${current_state}" "$2" "blue" "white" "${current_path}" "${dir_states[$current_state]}"
}

#CUSTOM VCS PROMPT
prompt_vcs() {
  VCS_WORKDIR_DIRTY=false
  VCS_WORKDIR_HALF_DIRTY=false
  current_state=""

  # Actually invoke vcs_info manually to gather all information.
  vcs_info
  local vcs_prompt="${vcs_info_msg_0_}"

  if [[ -n "$vcs_prompt" ]]; then
    if [[ "$VCS_WORKDIR_DIRTY" == true ]]; then
      # $vcs_visual_identifier gets set in +vi-vcs-detect-changes in functions/vcs.zsh,
      # as we have there access to vcs_info internal hooks.
      current_state='modified'
    else
      if [[ "$VCS_WORKDIR_HALF_DIRTY" == true ]]; then
        current_state='modified'
      else
        current_state='clean'
      fi
    fi

    #git-remote-current
    "$1_prompt_segment" "${0}_${(U)current_state}" "$2" "${vcs_states[$current_state]}" "$DEFAULT_COLOR" "$vcs_prompt" "$vcs_visual_identifier"
  fi
}

#CUSTOM DETECT OVERRIDE
function +vi-vcs-detect-changes() {
  if [[ "${hook_com[vcs]}" == "git" ]]; then

    local remote=$(git ls-remote --get-url 2> /dev/null)
    if [[ "$remote" =~ "github" ]] then
      vcs_visual_identifier='VCS_GIT_GITHUB_ICON'
    elif [[ "$remote" =~ "bitbucket" ]] then
      vcs_visual_identifier='VCS_GIT_BITBUCKET_ICON'
    elif [[ "$remote" =~ "gitlab" ]] then
      vcs_visual_identifier='VCS_GIT_GITLAB_ICON'
    else
      vcs_visual_identifier='VCS_GIT_ICON'
    fi

  elif [[ "${hook_com[vcs]}" == "hg" ]]; then
    vcs_visual_identifier='VCS_HG_ICON'
  elif [[ "${hook_com[vcs]}" == "svn" ]]; then
    vcs_visual_identifier='VCS_SVN_ICON'
  fi

  if [[ -n "${hook_com[staged]}" ]] || [[ -n "${hook_com[unstaged]}" ]]; then

    # Get 2nd opinion from submodules vs. changed
    NON_SUBMODULE_CHANGES=""
    GIT_PATH=$(git rev-parse --show-toplevel)
    if [[ -f "$GIT_PATH/.gitmodules" ]]; then
      SUBMODULES=$(cat "$GIT_PATH/.gitmodules" | grep path\ =\ | cut -d'=' -f2 | sed 's/^ *//;s/ *$//')

      # For all changed files:
      CHANGED_FILES=$(git ls-files --full-name --exclude-per-directory=.gitignore --others -m "$GIT_PATH" )
      while read -r FILE; do

        # Look for non-submodules
        SEARCH=$(echo "$SUBMODULES" | grep "^$FILE$" | xargs)
        if [[ -z "$SEARCH" ]]; then
          NON_SUBMODULE_CHANGES="$NON_SUBMODULE_CHANGES$FILE"
        fi
      done <<< "$CHANGED_FILES"

      # Confirm dirty on non-submodules changes
      if [[ ! -z "$NON_SUBMODULE_CHANGES" ]]; then
        VCS_WORKDIR_DIRTY=true
      else
        hook_com[unstaged]=""
        VCS_WORKDIR_DIRTY=false
      fi

    # Otherwise, assume true
    else
      VCS_WORKDIR_DIRTY=true
    fi

  else
    VCS_WORKDIR_DIRTY=false
  fi
}


#CUSTOM VI PROMPT
set_default POWERLEVEL9K_VI_INSERT_MODE_STRING "INSERT"
set_default POWERLEVEL9K_VI_COMMAND_MODE_STRING "NORMAL"
prompt_vi_mode() {
  COMMAND_MODE="ː"
  INSERT_MODE="↳"
  VISUAL_MODE="Ꮖ"

  case ${KEYMAP} in
    ##N: 9FDD2D ~ AFFF00 | 64C44A
    (vicmd) "$1_prompt_segment" "$0_${current_state}" "$2" "83" "black" "$COMMAND_MODE";;
    ##V: E39C26 ~ FFAF00 | 1942C6
    (vivis) "$1_prompt_segment" "$0_${current_state}" "$2" "26" "black" "$VISUAL_MODE";;
    (main | viins | *) if [[ -z $POWERLEVEL9K_VI_INSERT_MODE_STRING ]]
      then
        return
      fi
      ##I: 1D9EE1 ~ 0087FF | CCC951
      "$1_prompt_segment" "$0_${current_state}" "$2" "185" "black" "$INSERT_MODE" ;;
  esac
}


#CUSTOM KUBE PROMPT
prompt_kubecontext() {
  local kubectl_version="$(kubectl version --client 2>/dev/null)"

  if [[ -n "$kubectl_version" ]]; then
    # Get the current Kuberenetes context
    local cur_ctx=$(kubectl config view -o=jsonpath='{.current-context}')
    cur_namespace="$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${cur_ctx}\")].context.namespace}")"
    # If the namespace comes back empty set it default.
    if [[ -z "${cur_namespace}" ]]; then
      cur_namespace="default"
    fi

    local k8s_final_text=""

    if [[ "$cur_ctx" == "$cur_namespace" ]]; then
      # No reason to print out the same identificator twice
      k8s_final_text="$cur_ctx"
    else
      k8s_final_text="$cur_ctx/$cur_namespace"
    fi

    "$1_prompt_segment" "$0" "$2" "033" "black" "$k8s_final_text" "KUBERNETES_ICON"
  fi
}


#CUSTOM AWS PROMPT
prompt_aws() {
  local aws_profile="${AWS_PROFILE:-$AWS_DEFAULT_PROFILE}"

  if [[ -n "$aws_profile" ]]; then
    "$1_prompt_segment" "$0" "$2" "208" "black" "$aws_profile" 'AWS_ICON'
  fi
}


#CUSTOM GCP PROMPT
prompt_gcp() {
  #CLOUDSDK_CORE_ACCOUNT
  #CLOUDSDK_CORE_PROJECT
  GCP_USER=$(gcloud config list --format 'value(core.account)' 2> /dev/null)
  GCP_PROJ=$(gcloud config list --format 'value(core.project)' 2> /dev/null)
  GCP_INFO=" $GCP_USER | $GCP_PROJ"

  if [[ -n "$GCP_INFO" ]]; then
    "$1_prompt_segment" "$0" "$2" "22" "black" "$GCP_INFO" 
  fi
}

