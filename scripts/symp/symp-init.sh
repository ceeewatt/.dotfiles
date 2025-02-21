###
#  Function: init_manifest()
#  Usage: init_manifest
#  Description: Initialize each symlink in the manifest.
###
init_manifest()
{
  while true; do
    manifest_read_next_line

    if [ -n "${MAN_NEXT_LINE}" ]; then
      # The entry is stored in this variable as:
      # <name> <target> <link>
      target=$(echo "${MAN_NEXT_LINE}" | awk '{print $2}')
      link=$(echo "${MAN_NEXT_LINE}" | awk '{print $3}')
      add_create_symlink_dumb "${target}" "${link}"
    else
      break
    fi
  done
}
