#!/usr/bin/sh

print_help()
{
  printf "NAME\n"
  printf "\tsymp - symbolic link placer\n"
  printf "\n"
  printf "SYNOPSIS\n"
  printf "\tsymp add [-n <entry-name>] <target> <link>\n"
  printf "\tsymp rm <entry-name>...\n"
  printf "\tsymp ls <entry-name>...\n"
  printf "\tsymp init\n"
  printf "\tsymp [-h | --help | help]\n"
  printf "\n"
  printf "DESCRIPTION\n"
  printf "\tSymp is a tool for managing symbolic links.\n"
  printf "\tSymbolic links are managed via a plain text manifest file.\n"
  printf "\tThe 'add' command will create a symbolic link and create a corresponding entry in the manifest.\n"
  printf "\tThe 'rm' command will likewise remove one or more symbolic links from the filesystem and the manifest.\n"
  printf "\tThe 'ls' command will print the specified manifest entries or all entries if no additional arguments are supplied.\n"
  printf "\tThe 'init' command ensures each entry in the manifest file exists on the filesystem.\n"
  printf "\n"
  printf "\tSymp will look for a manifest file at the location specified in the 'symp_config.sh' script.\n"
  printf "\tTo see this help message, execute symp without any arguments or provide the '-h', '--help', or 'help' argument.\n"
}

# Find the absolute path to this script.
# This is needed for sourcing other symp scripts.
if [ -h "${0}" ]; then
  # If a symlink, resolve the path using 'realpath'
  HERE=$(dirname $(realpath "${0}"))
else
  HERE=$(dirname "${0}")
fi

. "${HERE}"/color.sh
. "${HERE}"/symp-config.sh
. "${HERE}"/symp-notify.sh
. "${HERE}"/symp-manifest.sh
. "${HERE}"/symp-add.sh
. "${HERE}"/symp-rm.sh
. "${HERE}"/symp-ls.sh
. "${HERE}"/symp-init.sh

# Exit if there's no manifest file found
manifest_check_file
if [ "${?}" -eq "1" ]; then
    notify_print_error "no manifest file; expected file '${MANIFEST}' at '${MANIFEST_DIR}'"
    notify_print_status "suggestion: create manifest with 'touch ${MANIFEST_DIR}/${MANIFEST}'"
    exit 1
fi

SUBCOMMAND="${1}"
if [ "${#}" -ge "1" ]; then shift; fi

case "${SUBCOMMAND}" in
  "add")
    add_create_symlink "${@}"
    ;;
  "rm")
    rm_remove_symlink "${@}"
    ;;
  "ls")
    ls_list_entries "${@}"
    ;;
  "init")
    init_manifest
    ;;
  "-h" | "--help" | "help")
    print_help
    ;;
  *)
    print_help
    ;;
esac
