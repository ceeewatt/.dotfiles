#!/usr/bin/sh

# Quickly setup a small sandbox environment for working with C/C++.
# Supply the script with one positional argument for the source
#  code file. The script will create a new directory and a skeleton
#  C/C++ source file. It will also attempt to copy over a generic
#  Makefile from an existing repository on the filesystem.
# Usage: ./sandbox-setup.sh main.c

# Create this directory and use it as our sandbox environment
SANDBOX_DIR='sandbox'

# Copy a generic Makefile from this directory into our sandbox
MAKEFILE_DIR="${HOME}/dev/ceeemake"

# Return early if we've received an erroneous number of arguments.
# We expect a single argument, indicating the name of the source file.
if [ ${#} -ne 1 ]
then
  printf "Invalid argument: please supply the name of the C/C++"
  printf " source file as a single argument\n"
  exit 1
else
  SOURCE_FILE="${1}"
fi

# Return early if the sandbox directory already exists
if [ -d ${SANDBOX_DIR} ]
then
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
printf "\n\n  return 0;\n}\n" >> ${SANDBOX_DIR}/${SOURCE_FILE}

# Attempt to copy over an existing Makefile
MAKEFILE_ONE="${MAKEFILE_DIR}/Makefile"
MAKEFILE_TWO="${MAKEFILE_DIR}/config.mk"
if [ -f ${MAKEFILE_ONE} ] && [ -f ${MAKEFILE_TWO} ]
then
  printf "Copying '${MAKEFILE_ONE}' and '${MAKEFILE_TWO}'"
  printf " into '${SANDBOX_DIR}'\n"
  cp ${MAKEFILE_ONE} ${MAKEFILE_TWO} ${SANDBOX_DIR}
else
  printf "Skipping Makefile... either '${MAKEFILE_ONE}' or"
  printf " '${MAKEFILE_TWO}' could not be found\n"
fi

printf "Created sandbox at '${PWD}/${SANDBOX_DIR}'\n"
