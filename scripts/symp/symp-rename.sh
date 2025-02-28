###
#  Function: rename_entry()
#  Usage: rename_entry <existing_entry> <new_entry>
#  Description: Find <existing_entry> in the manifest and rename
#   it to <new_entry>, without touching the target/link. Exit with
#   an error if <existing_entry> is not found in the manifest.
###
rename_entry()
{
  if [ "${#}" -ne "2" ]; then
    notify_print_error "rename operation requires two arguments"
    exit 1
  fi

  manifest_rename_entry "${1}" "${2}"

  if [ "${?}" -ne "0" ]; then
    notify_print_error "no entry '${1}' found in manifest"
    exit 1
  else
    notify_print_status "renamed entry '${1}' ==> '${2}'"
  fi
}
