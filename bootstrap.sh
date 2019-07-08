# Run the following inside the directory of your bash script:
#   curl "https://raw.githubusercontent.com/Noah2610/util.sh/master/download-util.sh" > download-util.sh
# Put the code below at the beginning of your bash script:

_dir="$( dirname "$0" )"
[ -f "${_dir}/util.sh" ] || "${_dir}/download-util.sh" || exit 1
# shellcheck source=./util.sh
source "${_dir}/util.sh"
unset _dir
