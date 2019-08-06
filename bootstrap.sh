# Run the following inside the directory of your bash script:
#   curl "https://raw.githubusercontent.com/Noah2610/util.sh/master/download-util.sh" > download-util.sh
# Put the code below at the beginning of your bash script:

# shellcheck source=./util.sh  # Optional; fixes shellcheck's `source` warning
_dir="$( dirname "$0" )"
[ -f "${_dir}/util.sh" ] || bash "${_dir}/download-util.sh" || exit 1
source "${_dir}/util.sh"
unset _dir
