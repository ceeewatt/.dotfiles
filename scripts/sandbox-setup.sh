#!/usr/bin/sh

# Quickly setup a small sandbox environment for working with C/C++.
# Supply the script with one positional argument for the source
#  code file. The script will create a new directory and a skeleton
#  C/C++ source file. It will also attempt to copy over a generic
#  Makefile from an existing repository on the filesystem. A second
#  argument for the name of the sandbox directory can optionally be
#  supplied.
# Example: ./sandbox-setup.sh main.c mysandbox

# This is the default directory under which the sandbox is created
SANDBOX_DIR_DEFAULT='sandbox'

# Copy a generic Makefile from this directory into our sandbox
MAKEFILE_DIR="${HOME}/dev/ceeemake"

# First argument is the source file; second argument is the name of
#  the sandbox directory to create, and is optional.
SOURCE_FILE="${1}"
SANDBOX_DIR="${2:-${SANDBOX_DIR_DEFAULT}}"

# Return early if we've received an erroneous number of arguments.
if [ "${#}" -lt "1" ]; then
  printf "Usage: ./sandbox-setup.sh <source> [<directory>]\n"
  printf "Example: ./sandbox-setup.sh main.c sandbox\n"
  exit 1
fi

# Return early if the sandbox directory already exists
if [ -d ${SANDBOX_DIR} ]; then
  printf "Directory '${SANDBOX_DIR}' already exists!\n"
  exit 1
else
  printf "Creating directory '${SANDBOX_DIR}'\n"
  mkdir ${SANDBOX_DIR}
fi

# Create the specified source file and populate it with skeleton source code
printf "Creating file '${SOURCE_FILE}'\n"
touch ${SANDBOX_DIR}/${SOURCE_FILE}
printf "\n\nint main(int argc, char* argv[])\n{" >> ${SANDBOX_DIR}/${SOURCE_FILE}
printf "\n  (void)argc; (void)argv;" >> ${SANDBOX_DIR}/${SOURCE_FILE}
printf "\n\n  return 0;\n}\n" >> ${SANDBOX_DIR}/${SOURCE_FILE}

# Attempt to copy over an existing Makefile
MAKEFILE_ONE="${MAKEFILE_DIR}/Makefile"
MAKEFILE_TWO="${MAKEFILE_DIR}/config-template.mk"
if [ -f ${MAKEFILE_ONE} ] && [ -f ${MAKEFILE_TWO} ]; then
  printf "Copying '${MAKEFILE_ONE}' and '${MAKEFILE_TWO}'"
  printf " into '${SANDBOX_DIR}'\n"
  cp ${MAKEFILE_ONE} ${SANDBOX_DIR}
  cp ${MAKEFILE_TWO} ${SANDBOX_DIR}/config.mk

  # The file extension is expected to be either '.c' or '.cpp'.
  # Use the file extension to set the LANGUAGE setting in the
  #  sed command to the appropriate value.
  EXTENSION="${SOURCE_FILE##*.}"
  if [ ${EXTENSION} = c ] || [ ${EXTENSION} = C ]; then LANG='C'; else LANG='CPP'; fi

  # Edit the config file to match our source file. This will break
  #  if we can't match the strings 'LANGUAGE := C' and 'SRCS :='
  #  exactly in the config file.
  sed -i \
    -e "0,/LANGUAGE := C/{s/LANGUAGE := C/LANGUAGE := ${LANG}/}" \
    -e "0,/SRCS :=/{s/SRCS :=/SRCS := ${SOURCE_FILE}/}" \
    ${SANDBOX_DIR}/config.mk
else
  printf "Skipping Makefile... either '${MAKEFILE_ONE}' or"
  printf " '${MAKEFILE_TWO}' could not be found\n"
fi

printf "Created sandbox at '${PWD}/${SANDBOX_DIR}'\n"
