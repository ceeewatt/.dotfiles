if [ $(whoami) = "root" ]; then
  HOMEDIR="/home/${SUDO_USER}"
else
  HOMEDIR="${HOME}"
fi

MANIFEST="manifest.symp"
MANIFEST_DIR="${HOMEDIR}/.dotfiles"
MANIFEST_FILE="${MANIFEST_DIR}/${MANIFEST}"

