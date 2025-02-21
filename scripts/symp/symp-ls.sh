###
#  Function: ls_print_manifest()
#  Usage: ls_print_manifest
#  Description: Print out the entire manifest file. This is just
#   a placeholder in case I later want to do something special
#   with manifest before printing it out.
###
ls_print_manifest()
{
  cat "${MANIFEST_FILE}" | sort
}

###
#  Function: ls_parse_command_line()
#  Usage: ls_parse_command_line <entry-name>...
#  Description: Parse command line arguments for the 'ls' command.
#   For each <entry-name>, ensure it exists in the manifest and
#   then add that entry to the variable 'LS_ENTRIES'. If no
#   entries are specified, print out the entire manifest file.
###
ls_parse_command_line()
{
  if [ "${#}" -eq "0" ]; then
    ls_print_manifest
  else
    # Ensure that each entry exists in the manifest before calling
    #  ls_list_entries().
    for entry in ${@}; do
      search_result=$(manifest_entry_search "${entry}")

      if [ -n "${search_result}" ]; then
        LS_ENTRIES="${LS_ENTRIES}${search_result}\n"
      else
        notify_print_error "no entry '${entry}' found in manifest"
      fi
    done
  fi
}

###
#  Function: ls_list_entries()
#  Usage: ls_list_entries <entry-name>...
#  Description: Print out each valid entry in the provided list
#   of entry names.
###
ls_list_entries()
{
  ls_parse_command_line "${@}"

  printf "${LS_ENTRIES}"
}
