###
#  Function: symp_manifest_get_entry_names()
#  Usage: symp_manifest_get_entry_names
#  Description: Print all entry names found in the manifest in
#   order in a single column.
###
symp_manifest_get_entry_names()
{
  local MANIFEST_FILE="${HOME}/.dotfiles/manifest.symp"
  echo $(sed -E "s/\[(.*)\] .*/\1/" "${MANIFEST_FILE}")
}

###
#  Function _symp.sh()
#  Usage: n/a
#  Description: This function is used for tab completion
#   logic of the 'symp.sh' command, as specified by the
#   'complete' builtin command below. Bash will automatically
#   call this function (assuming this script in placed in the
#   correct location.
###
_symp.sh()
{
  local commands="add rm ls init"

  # The current text typed at the command line
  local curr=${COMP_WORDS[COMP_CWORD]}

  local sympCmd=${COMP_WORDS[1]}

  # symp.sh add [-n <name>] <target> <link>
  # symp.sh rm <name...>
  # symp.sh ls <name...>
  # symp.sh init
  case ${sympCmd} in
    ("add")
      if [ "${curr}" = "-" ]; then
        COMPREPLY=("-n")
      else
        COMPREPLY=( $(compgen -o default -- "${curr}") )
      fi
      ;;
    ("rm")
      COMPREPLY=( $(compgen -W "$(symp_manifest_get_entry_names)" -- "${curr}") )
      ;;
    ("ls")
      COMPREPLY=( $(compgen -W "$(symp_manifest_get_entry_names)" -- "${curr}") )
      ;;
    ("init")
      # No completions
      ;;
    (*)
      COMPREPLY=( $(compgen -W "${commands}" -- "${sympCmd}") )
      ;;
  esac
}

# Execute the function _symp.sh for completion logic of the
#  symp.sh command. The '-o filenames' option is necessary
#  for the expected default behavior when matching files
#  or directories.
# See: https://superuser.com/questions/564716/bash-completion-for-filename-patterns-or-directories
complete -o filenames -F _symp.sh symp.sh
