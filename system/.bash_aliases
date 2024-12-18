alias ll='ls -lAF'
alias la='ls -AF'
alias l='ls -CF'
alias nvim='/home/colin/apps/nvim/bin/nvim'
alias refresh-desktop-entries='update-desktop-database ~/.local/share/applications'

alias signout="loginctl terminate-user $(whoami)"
alias shutdown='sudo shutdown now'
alias reboot='sudo shutdown -r now'

alias py='python3'

# Use latexmk to preview a tex document automatically as
#  it's being edited.
# Usage: latex-live-preview <file.tex>
alias latex-live-preview='latexmk -pdf -pvc'

# After finished with the latex live preview, there are a
#  number of temporary files in the current directory. Run
#  this command while in that directory to clean up those
#  files. This should leave behind just the *.tex and *.pdf
#  files.
alias latex-cleanup='latexmk -c'
