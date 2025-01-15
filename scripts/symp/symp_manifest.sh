###
#  Function: manifest_check_file()
#  Usage: manifest_check_file
#  Description: return status code 0 if the manifest file exists.
#   Otherwise, return status code 1.
###
manifest_check_file()
{
  if [ ! -e "${MANIFEST_FILE}" ]; then
    return 1
  fi

  return 0
}

###
#  Function: manifest_home_to_tilde()
#  Usage: manifest_home_to_tilde <filepath>
#  Description: given a file path, replace the user's HOME
#   directory with a tilde. If there is no HOME directory
#   to replace, simply echo back out the filepath argument.
###
manifest_home_to_tilde()
{
  echo "$(echo "${1}" | sed -E "s:^${HOMEDIR}:~:")"
}

###
#  Function: manifest_tilde_to_home()
#  Usage: manifest_tilde_to_home <filepath>
#  Description: given a file path, replace a leading tilde (~)
#   with the HOME directory. If there is no leading tilde,
#   simply echo back out the filepath argument.
###
manifest_tilde_to_home()
{
  echo "$(echo "${1}" | sed -E "s:^~:${HOMEDIR}:")"
}

###
#  Function: manifest_entry_search()
#  Usage: manifest_entry_search <entry-name>
#  Description: search the manifest for an entry of a given name.
#   Returns the first match found in the manifest, otherwise,
#   returns an empty string.
###
manifest_entry_search()
{
  echo $(grep -F "[${1}]" "${MANIFEST_FILE}" | head -n 1)
}

###
#  Function: manifest_get_entry_target_and_link()
#  Usage: manifest_get_entry_target_and_link <entry-name>
#  Description: Given an entry in the manifest, return the
#   corresponding target and link files. The target and link
#   are returned in a string as such: "<target> <link>",
#   where <target> and <link> are absolute paths.
#   If the entry does not exist in the manifest, an empty
#   string is returned.
###
manifest_get_entry_target_and_link()
{
  search_result=$(manifest_entry_search "${1}")

  if [ -n "${search_result}" ]; then
    # An entry looks like: [<name>] 'link' -> 'target'
    # Capture the target and link files within quotes.
    target_and_link=$(echo "${search_result}" | sed -E -n "s/\[.*\] '([^']*)' -> '([^']*)'/\2 \1/p")

    # Split off target and link into their own strings
    target=$(echo "${target_and_link}" | awk '{print $1}')
    link=$(echo "${target_and_link}" | awk '{print $2}')

    # Expand tilde into HOME
    target=$(manifest_tilde_to_home "${target}")
    link=$(manifest_tilde_to_home "${link}")
    printf "%s %s" "${target}" "${link}"
  else
    printf ""
  fi
}

###
#  Function: manifest_new_entry()
#  Usage: manifest_new_entry <entry-name> <target> <link>
#  Description: add a new entry to the manifest file. An entry
#   takes the following form: [<entry-name>] '<link>' -> '<target>'.
#   The target and link arguments are expected to be the full path
#   to the respective files. Upon success, return the newly added
#   manifest entry with a status code of 0. If the entry cannot be
#   created because of a naming collision, return the existing
#   entry with a status code of 1.
###
manifest_new_entry()
{
  entry_name="${1}"
  target=$(manifest_home_to_tilde "${2}")
  link=$(manifest_home_to_tilde "${3}")

  search_result=$(manifest_entry_search ${entry_name})
  if [ -n "${search_result}" ]; then
    printf "${search_result}"
    return 1
  fi

  entry=$(printf "[%s] '%s' -> '%s'" "${entry_name}" "${link}" "${target}")
  printf "${entry}\n" >> "${MANIFEST_FILE}"

  printf "${entry}"
  return 0
}

###
#  Function: manifest_remove_entry()
#  Usage: manifest_remove_entry <entry-name>
#  Description: Attempts to remove the specified entry from the
#   manifest. If the entry is found and removed, a status code
#   of 0 is returned. If the entry is not found, a status code
#   of 1 is returned.
###
manifest_remove_entry()
{
  search_result=$(manifest_entry_search "${1}")

  if [ ! -n "${search_result}" ]; then return 1; fi

  # Delete the line in the manifast that matches the specified
  #  entry. Make the changes in-place with the -i option.
  # Note: sed -i option only supported by GNU sed.
  sed -i "/\[${1}\]/d" "${MANIFEST_FILE}"
  return 0
}

###
#  Function: manifest_read_next_line()
#  Usage: manifest_read_next_line
#  Description: Starting from the first line, read a single entry
#   from the manifest, return the results, and progress the line
#   counter such that the next line is read on each successive
#   call. After each entry is read, the results are saved to the
#   variable 'MAN_NEXT_LINE', which contains the entry name,
#   target, and link in a single string: '<name> <target> <link>'.
#   After each entry has been read, successive calls to this
#   function place an empty string in 'MAN_NEXT_LINE'.
###
MANLINE="1"
MANLINES=$(wc -l < "${MANIFEST_FILE}")
manifest_read_next_line()
{
  if [ "${MANLINE}" -le "${MANLINES}" ]; then
    entry=$(sed -n "${MANLINE}p" "${MANIFEST_FILE}")
    entry_name=$(echo "${entry}" | sed -E "s/\[(.*)\].*/\1/")
    target_and_link=$(manifest_get_entry_target_and_link "${entry_name}")
    MAN_NEXT_LINE=$(printf "%s %s" "${entry_name}" "${target_and_link}")
    MANLINE=$(expr "${MANLINE}" + "1")
  else
    MAN_NEXT_LINE=""
  fi
}
