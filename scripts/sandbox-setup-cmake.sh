#!/usr/bin/sh

SANDBOX_DIR_DEFAULT='sandbox'

# First argument is the source file; second argument is the name of
#  the sandbox directory to create, and is optional
SOURCE_FILE=${1}
SANDBOX_DIR=${2:-${SANDBOX_DIR_DEFAULT}}

# Command line argument validation
if [ ${#} -lt 1 ]; then
    echo "Usage: ./sandbox-setup-cmake.sh <source-file> [<sandbox-dir>]"
    echo "Example: ./sandbox-setup-cmake.sh main.cpp sandbox"
    exit 1
fi

if [ -d ${SANDBOX_DIR} ]; then
    echo "Directory '${SANDBOX_DIR}' already exists!"
    exit 1
fi

if [ ! -x $(which cmake) ]; then
    echo "cmake executable not found!"
    exit 1
fi

CMAKE_VERSION=$(cmake --version | sed -E 's/cmake version (.*)/\1/' | head -n 1)

append_to_file()
{
    local msg="${1}"
    local file="${2}"

    printf "${msg}" >> "${file}"
}

mkdir ${SANDBOX_DIR}
echo "[sandbox-setup] created directory '${SANDBOX_DIR}'"

touch ${SANDBOX_DIR}/${SOURCE_FILE}
echo "[sandbox-setup] created source file '${SANDBOX_DIR}/${SOURCE_FILE}'"

append_to_file "\n\n"                                "${SANDBOX_DIR}/${SOURCE_FILE}"
append_to_file "int main(int argc, char* argv[])\n"  "${SANDBOX_DIR}/${SOURCE_FILE}"
append_to_file "{\n"                                 "${SANDBOX_DIR}/${SOURCE_FILE}"
append_to_file "    (void)argc; (void)argv;\n\n"     "${SANDBOX_DIR}/${SOURCE_FILE}"
append_to_file "    return 0;\n"                     "${SANDBOX_DIR}/${SOURCE_FILE}"
append_to_file "}\n"                                 "${SANDBOX_DIR}/${SOURCE_FILE}"

CMAKE_FILE=${SANDBOX_DIR}/CMakeLists.txt
touch ${CMAKE_FILE}
echo "[sandbox-setup] created CMakeLists.txt file '${CMAKE_FILE}'"

append_to_file "# Created with '${0}' script\n\n"                    "${CMAKE_FILE}"
append_to_file "cmake_minimum_required(VERSION ${CMAKE_VERSION})\n"  "${CMAKE_FILE}"
append_to_file "project(sandbox)\n\n"                                "${CMAKE_FILE}"
append_to_file "add_executable(sandbox ${SOURCE_FILE})\n"            "${CMAKE_FILE}"
