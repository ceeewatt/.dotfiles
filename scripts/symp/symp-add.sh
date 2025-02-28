###
#  Function: add_parse_command_line()
#  Usage:
#    add_parse_command_line [-n <entry-name>] <target> <link>
#    add_parse_command_line --update -n <entry-name> <target> <link>
#  Description: Parse command line arguments for the 'add' command. Places
#   the target, link, name, and update flag in the following variables:
#   - TARGET_CMDLINE
#   - LINK_CMDLINE
#   - NAME_CMDLINE
#   - UPDATE
###
add_parse_command_line()
{
  #example1_good="-n name target link"
  #example2_good="target -n name link"
  #example3_good="target link -n name"
  #example4_good="target link"
  #example1_bad="-n target link"
  #example2_bad="target -n link"
  #example3_bad="target link -n"

  # This command accepts two separate options/flags:
  # -n name: specify the name of the manifest entry to be created
  # --update: if this is provided along with the -n option, the specified entry
  #  will be reused for a new target/link
  GETOPT_OUTPUT=$(getopt --unquoted -o n: --longoptions update -- ${@})

  if [ "${?}" -ne "0" ]; then
    notify_print_error "issue parsing command line options"
    exit 1
  fi

  # Replace this functions positional arguments with the results of getopt
  # See: https://stackoverflow.com/questions/77186508/explain-use-of-eval-set-args-with-getopt-in-bash
  eval set -- "${GETOPT_OUTPUT}"

  # Getopt will produce an output string string of the form: '--update -n name -- target link'.
  # Fetch everything after the '--' to get the target and link arguments.
  local suffix="${GETOPT_OUTPUT#* -- }"

  if [ $(echo "${suffix}" | wc -w) -ne "2" ]; then
    notify_print_error "a target and link file must be provided"
    exit 1
  else
    TARGET_CMDLINE=$(echo "${suffix}" | awk '{print $1}')
    LINK_CMDLINE=$(echo "${suffix}" | awk '{print $2}')
  fi

  while true; do
    case "${1}" in
      ("--update")
        UPDATE=true; shift ;;
      ("-n")
        NAME_CMDLINE="${2}"; shift; shift ;;
      ("--")
        break ;;
      (*)
        shift
    esac
  done

  # If no entry name was provided, use a default name. If the --update flag
  #  was provided, exit early with an error if no entry name was provided.
  if [ -z "${NAME_CMDLINE}" ]; then
    if [ "${UPDATE}" = "true" ]; then
      notify_print_error "--update requires an entry name (-n <name>)"
      exit 1
    else
      NAME_CMDLINE=$(basename "${TARGET_CMDLINE}")
    fi
  fi
}

###
#  Function: add_symlink_to_manifest()
#  Usage: add_symlink_to_manifest <entry-name> <target> <link>
#  Description: this is a helper function for add_create_symlink().
#   It passes the <entry-name>, <target>, and <link> to the
#   manifest handler and prints out appropriate status/error
#   information.
###
add_symlink_to_manifest()
{
  new_entry=$(manifest_new_entry "${1}" "${2}" "${3}")

  # If the return status is 1, the attempt to create the new entry
  #  failed due to a naming collision.
  if [ "${?}" -eq "1" ]; then
    notify_print_error "a manifest entry with name ${1} already exists: ${new_entry}"
    notify_print_status "suggestion: try re-adding the symlink with a different entry name"
    exit 1
  fi

  notify_print_status "created manifest entry: ${new_entry}"
}

###
#  Function: add_create_symlink()
#  Usage:
#    add_create_symlink [-n <entry-name>] <target> <link>
#    add_create_symlink --update -n <entry-name> <target> <link>
#  Description: Given the command line arguments for a target and link
#   file (and optionally a manifest entry name) create a the specified
#   symlink to the specified target and create a corresponding entry
#   (with the name <entry-name>) in the manifest file. If the link is
#   a directory, the symlink will be created in that directory and will
#   take on the same name as the target file. If no <entry-name> is
#   provided, the manifest entry will take on the same name as the target
#   file.
#   In the second form, if the --update flag is provided (along with an
#    entry name), the specified entry in the manifest is updated with the
#    new target and link.
###
add_create_symlink()
{
  add_parse_command_line "${@}"

  # Resolve the full path to the provided target file so that there are no
  #  issues with relative paths
  TARGET_FILE=$(realpath -s "${TARGET_CMDLINE}")

  if [ ! -e "${TARGET_FILE}" ]; then
    notify_print_error "target file '${TARGET_FILE}' doesn't exist"
    exit 1
  fi

  # Get the full path to the specified symlink file. The user can
  #  optionally specify a directory instead of an explicit filename
  #  for the symlink. In which case, the symlink will be created in
  #  the specified directory and it will take on the same name as
  #  the target file.
  if [ -d "${LINK_CMDLINE}" ]; then
    LINK_FILE="$(realpath ${LINK_CMDLINE})/$(basename ${TARGET_FILE})"
  else
    LINK_FILE="$(realpath $(dirname ${LINK_CMDLINE}))/$(basename ${LINK_CMDLINE})"
  fi

  # If the update flag is given, remove the specified entry before we
  #  create the new symlink.
  if [ "${UPDATE}" = "true" ]; then
    if [ -z "$(manifest_get_entry_target_and_link ${NAME_CMDLINE})" ]; then
      notify_print_error "no entry '${entry}' found in manifest"
      exit 1
    else
      rm_remove_symlink "${NAME_CMDLINE}"
    fi
  fi

  # If the user provided a symlink that already exists on the
  #  filesystem, we don't bother invoking the 'ln' command.
  #  Instead, just pass the information to the manifest handler
  #  in case we're not already tracking this particular symlink.
  if [ -L "${LINK_FILE}" ] && [ $(realpath "${LINK_FILE}") = "${TARGET_FILE}" ]; then
    notify_print_status "symbolic link '${LINK_FILE}' to target '${TARGET_FILE}' already exists"
    add_symlink_to_manifest ${NAME_CMDLINE} ${TARGET_FILE} ${LINK_FILE}
    exit 0
  fi

  # Verbose output has the format: 'link' -> 'target'
  LN_OUTPUT=$(ln -sv "${TARGET_FILE}" "${LINK_FILE}" 2>&1)

  if [ "${?}" -ne "0" ]; then
    notify_print_error "${LN_OUTPUT}"
    exit 1
  fi

  notify_print_status "created symlink: ${LN_OUTPUT}"

  add_symlink_to_manifest ${NAME_CMDLINE} ${TARGET_FILE} ${LINK_FILE}
}

###
#  Function: add_create_symlink_dumb()
#  Usage: add_create_symlink_dumb <target> <link>
#  Description: this function mostly serves as a helper for
#   init_manifest(). This will unconditionally call 'ln' on
#   the provided target and link arguments and will not attempt
#   to add an entry to the manifest. The target and link arguments
#   are expected to be full paths to the respective files.
###
add_create_symlink_dumb()
{
  LN_OUTPUT=$(ln -sv "${1}" "${2}" 2>&1)

  if [ "${?}" -eq "0" ]; then
    notify_print_status "created symlink: ${LN_OUTPUT}"
  else
    notify_print_error "${LN_OUTPUT}"
  fi
}
