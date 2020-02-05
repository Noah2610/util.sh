# Run the following inside the directory of your bash script:
#   curl "https://raw.githubusercontent.com/Noah2610/util.sh/v2/download-util.sh" > download-util.sh
# Place the code below at the beginning of your bash script.
# Set the `UTIL_VERSION` variable to a different git reference, to specify a custom version.
# The version can be a branch, a tag, or a git hash.

# shellcheck source=./util.sh disable=SC2155
function _dl_util_sh {
    local UTIL_VERSION="v2.1.2"
    local dir="$( dirname "$( realpath "$1" )" )"
    [ -f "${dir}/util.sh" ] || bash "${dir}/download-util.sh" "$UTIL_VERSION" || exit 1
    source "${dir}/util.sh"
}; _dl_util_sh "$0"
