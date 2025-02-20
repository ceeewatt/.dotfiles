alias ll='ls -lhAF'
alias la='ls -AF'
alias l='ls -CF'
alias bat='batcat'
alias cal='ncal -bw'
alias py='python3'

alias cp='cp -i'
alias mv='mv -i'
alias t='trash-put'

# Run this when new desktop entries are created
alias refresh-desktop-entries='update-desktop-database ~/.local/share/applications'

alias signout="loginctl terminate-user $(whoami)"
alias shutdown='sudo shutdown now'
alias reboot='sudo shutdown -r now'

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

# Print the available space on all currently mounted file systems
alias disk-usage='df -BG'
# Print memory usage in human readable format
alias memory-usage='free -h'

# nvim-private will not use a Shada file, meaning data won't
#  be saved outside of that nvim session.
alias nvim='/home/colin/apps/nvim/bin/nvim'
alias nvim-private='nvim -i NONE'

# img-viewer-private will not write any cache or temporary
#  files.
alias imgv='sxiv'
alias imgv-private='sxiv -p'
