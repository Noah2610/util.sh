# Run the following inside the directory of your bash script:
#   curl "https://gist.githubusercontent.com/Noah2610/68f0351ff2d4970f0403edb03cc5bde6/raw/7a87eedb583d1cf2d3c93b60952db7e511d3f4e6/download-util.sh" > download-util.sh
# Put the code below at the beginning of your bash script:

_dir="$( dirname "$0" )"
[ -f "${_dir}/util.sh" ] || "${_dir}/download-util.sh" || exit 1
# shellcheck source=./util.sh
source "${_dir}/util.sh"
unset _dir