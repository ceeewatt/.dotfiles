###
#  Function: rm_parse_command_line()
#  Usage: rm_parse_command_line <entry-name>...
#  Description: Parse command line arguments for the 'rm' command.
#   The specified entries to remove are placed in the variable
#   'RM_ENTRIES'. If no entries are specified, exit early.
###
rm_parse_command_line()
{
  if [ "${#}" -eq "0" ]; then
    notify_print_error "must specify at least one manifest entry for 'rm' command"
    exit 1
  fi

  RM_ENTRIES="${@}"
}

###
#  Function: rm_remove_symlink()
#  Usage: rm_remove_symlink <entry-name>...
#  Description: For each specified <entry-name> remove the
#   associated entry in the manifest and delete the corresponding
#   symlink.
###
rm_remove_symlink()
{
  rm_parse_command_line "${@}"

  for entry in ${RM_ENTRIES}; do
    target_and_link=$(manifest_get_entry_target_and_link "${entry}")

    if [ ! -n "${target_and_link}" ]; then
      notify_print_error "no entry '${entry}' found in manifest"
      continue
    fi

    target=$(echo "${target_and_link}" | awk '{print $1}')
    link=$(echo "${target_and_link}" | awk '{print $2}')

    if [ -L "${link}" ]; then
      rm "${link}"
      notify_print_status "removed symlink '${link}' to '${target}'"
    else
      notify_print_error "symlink '${link}' does not exist"
    fi

    manifest_remove_entry "${entry}"
    notify_print_status "removed entry '${entry}' from manifest"
  done
}
