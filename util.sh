# util.sh
# Version: 2.0.0-pre
# https://github.com/Noah2610/util.sh

set -o pipefail

# Returns `0` or `1` depending on if the given string is available as a command.
function is_available {
    local cmd="$1"
    [ -z "$cmd" ] && err "No command to check for availability given to function \`is_available\`"
    command -v "$cmd" &> /dev/null
}

# Returns `0` or `1` depending on if the command is running (using `pgrep`).
function is_running {
    check "pgrep"
    local to_check="$1"
    [ -z "$to_check" ] && err "No command to check if running given to function \`is_running\`"
    pgrep -xc "$to_check" &> /dev/null
}

# Exit with error message if the given string is not available as a command.
function check {
    local cmd="$1"
    [ -z "$cmd" ] && err "No command to check given to function \`check\`"
    is_available "$cmd" &> /dev/null \
        || err "\`$(clr "${CLR_CODE[@]}")${cmd}$(clrrs)\` is not available."
}

# Exit with error message if the given file path does not exist.
function check_file {
    local FILE="$1"
    [ -z "$FILE" ] && err "No file given"
    [ -f "$FILE" ] || err "File does not exist: $(clr "${CLR_CODE[@]}")${FILE}$(clrrs)"
}

# Exit with error message if the given directory path does not exist.
function check_dir {
    local DIR="$1"
    [ -z "$FILE" ] && err "No directory given"
    [ -d "$DIR" ] || err "Directory does not exist: $(clr "${CLR_CODE[@]}")${DIR}$(clrrs)"
}

# Print the given string to stdout.
function msg {
    print_log "$1"
    echo -e "$(clr "${CLR_MSG[@]}")${1}$(clrrs)"
}

# DEPRECATED
# Same as `msg`, but also makes the text bold.
function msg_strong {
    warn "Function \`msg_strong\` is deprecated"
    print_log "$( semantic_date )\n${1}"
    echo -e "$( colored "${COLOR_MSG_STRONG}" "${1}" )"
}

# Print the given string to stderr and to the `$LOGFILE` (if one exists),
# then exit with exit code 1.
function err {
    print_log "$( semantic_date )\nERROR: $1"
    (1>&2 echo -e "$(clr "${CLR_ERR[@]}")ERROR:$(clrrs) ${1}\nExiting.")
    exit 1
}

# Print the given string to stderr and to the `$LOGFILE`
function warn {
    print_log "WARNING: $1"
    (1>&2 echo -e "$(clr "${CLR_WARN[@]}")WARNING:$(clrrs) ${1}")
}

# Print the given string to the `$LOGFILE` (if one exists), and strip color from the text.
function print_log {
    local txt="$1"
    [ -z "$txt" ] && err "No message text given to function \`print_log\`"
    [ -n "$LOGFILE" ] && echo -e "$( _strip_ansi_codes "$txt" )\n" >> "$LOGFILE"
}

# Strip ansi codes from the given string.
function _strip_ansi_codes {
    local txt="$1"
    if is_available "sed"; then
        echo -e "$txt" | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"
    else
        echo -e "$txt"
    fi
}

# Echos the FOREGROUND color code matching the given color argument.
# The given color string is a semantic representation of color.
# Available colors:
#   "black", "white", "red", "green", "blue",
#   "yellow", "magenta", "cyan", "lightgray", "darkgray",
#   "lightred", "lightgreen", "lightblue", "lightyellow",
#   "lightmagenta", "lightcyan",
#   "default", "reset"
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
function clrfg {
    local color_str="$1"
    local color_code
    [ -z "$color_str" ] && err "No color argument given to function \`clrfg\`"
    color_code="$( _color_code_generic "$color_str" )"
    echo -en "\e[${color_code}m"
}

# Echos the BACKGROUND color code matching the given color argument.
# The given color string is a semantic representation of color.
# Available colors:
#   "black", "white", "red", "green", "blue",
#   "yellow", "magenta", "cyan", "lightgray", "darkgray",
#   "lightred", "lightgreen", "lightblue", "lightyellow",
#   "lightmagenta", "lightcyan",
#   "default", "reset"
function clrbg {
    local color_str="$1"
    local color_code
    [ -z "$color_str" ] && err "No color argument given to function \`clrbg\`"
    color_code="$(( 10 + $( _color_code_generic "$color_str" ) ))"
    echo -en "\e[${color_code}m"
}

# Echos the attribute color code matching the given argument.
# The given argument string is a semantic representation of an attribute.
# Available attributes:
#   "bold", "dim", "underline", "blink", "invert", "hidden",
#   "default", "reset"
function clrattr {
    local attr_str="$1"
    [ -z "$attr_str" ] && err "No attribute argument given to function \`clrattr\`"
    case "$attr_str" in
        "bold")      echo -en "\e[1m" ;;
        "dim")       echo -en "\e[2m" ;;
        "underline") echo -en "\e[4m" ;;
        "blink")     echo -en "\e[5m" ;;
        "invert")    echo -en "\e[7m" ;;
        "hidden")    echo -en "\e[8m" ;;
        "default")   echo -en "\e[20m" ;;
        "reset")     echo -en "\e[20m" ;;
        *) err "Invalid attribute argument: \"${attr_str}\"" ;;
    esac
}

# Set the foreground, background, and attribute colors all at once.
# This function takes three arguments:
#   foreground color (see clrfg)
#   background color (see clrbg)
#   attribute (see clrattr)
function clr {
    local color_fg="$1"
    local color_bg="$2"
    local color_attr="$3"
    if [ -z "$color_fg" ] || [ -z "$color_bg" ] || [ -z "$color_attr" ]; then
        err "Function \`clr\` requires 3 arguments"
    fi
    clrfg "$color_fg"
    clrbg "$color_bg"
    clrattr "$color_attr"
}

# Resets all color settings to default.
function clrrs {
    echo -en "\e[0m"
}

# Internal helper function.
# Returns the foreground color code number for the given color string.
# This is then used in the above color functions to create
# proper, printable color codes for foreground and background.
function _color_code_generic {
    local color_str="$1"
    [ -z "$color_str" ] && err "No color argument given to function \`_color_code_generic\`"
    case "$color_str" in
        "black")        echo -n "30" ;;
        "white")        echo -n "97" ;;
        "red")          echo -n "31" ;;
        "green")        echo -n "32" ;;
        "blue")         echo -n "34" ;;
        "yellow")       echo -n "33" ;;
        "magenta")      echo -n "35" ;;
        "cyan")         echo -n "36" ;;
        "lightgray")    echo -n "37" ;;
        "darkgray")     echo -n "90" ;;
        "lightred")     echo -n "91" ;;
        "lightgreen")   echo -n "92" ;;
        "lightblue")    echo -n "94" ;;
        "lightyellow")  echo -n "93" ;;
        "lightmagenta") echo -n "95" ;;
        "lightcyan")    echo -n "96" ;;
        "default")      echo -n "39" ;;
        "reset")        echo -n "39" ;;
        *) err "Invalid color argument: \"${color_str}\"" ;;
    esac
}

# DEPRECATED
# This function returns a string wrapped in ansi color codes.
# It takes two arguments:
#   color - ansi color code (ex. "0;33", "0;36;40")
#   txt   - the text to be colored
function colored {
    warn "Function \`colored\` is deprecated"
    local color="$1"
    local txt="$2"
    { [ -z "$color" ] || [ -z "$txt" ]; } \
        && err "Function \`colored\` needs two arguments: the color and the text."
    echo "\033[${color}m${txt}\033[m"
}

# Print out a date string in a specifc format.
# If the command `boxed-string` is available, then it calls that with the date string.
# boxed-string: https://gist.github.com/Noah2610/2c4a92f6732419becade2f76bc943039
function semantic_date {
    check "date"
    local dfmt
    local dstr
    dfmt='+%F %T'
    dstr="$( date "$dfmt" )"
    if is_available "boxed-string"; then
        BOXED_PADDING_HORZ=1 \
        BOXED_PADDING_VERT=0 \
            boxed-string -- "$dstr"
    else
        echo "$dstr" | tee -a "$LOGFILE"
    fi
}

# Tries to run the given command.
# All arguments are parsed as the command, so the first argument is the
# command, and all following arguments are passed as arguments to the command.
# Runs `err` if the command fails.
# Writes the command's output to the `$LOGFILE`.
function try_run {
    local cmd=( "$@" )
    [ ${#cmd} -lt 1 ] && err "No command given to function \`try_run\`"
    local out
    local cmd_display
    cmd_display="$( clr "${CLR_CODE[@]}")${cmd[*]}$(clrrs )"

    # shellcheck disable=SC2154
    msg "${spacing}Running: ${cmd_display}"
    if ! ${cmd[*]} | tee -a "$LOGFILE"; then
        err "Command failed: ${cmd_display}"
    fi
}

# Similar to function `try_run_hidden`, but hides the command's output.
# Tries to run the given command and hides its output.
# All arguments are parsed as the command, so the first argument is the
# command, and all following arguments are passed as arguments to the command.
# If the command fails, then it prints the output with `err`.
# Writes the command's output to the `$LOGFILE`.
function try_run_hidden {
    local cmd=( "$@" )
    [ ${#cmd} -lt 1 ] && err "No command given to function \`try_run_hidden\`"
    local out
    local cmd_display
    cmd_display="$( clr "${CLR_CODE[@]}")${cmd[*]}$(clrrs )"

    # shellcheck disable=SC2154
    msg "${spacing}Running: ${cmd_display}"
    if ! out="$( ${cmd[*]} 2>&1 | tee -a "$LOGFILE" )"; then
        err "\
Command failed: ${cmd_display}
Returned:
${out}"
    fi
}

# Returns `0` or `1` depending on if the final command should be run in a new terminal.
# For very specific use-case(s).
function should_run_in_terminal {
    [ -n "$RUN_NEW_TERMINAL" ] \
        && [ "$RUN_NEW_TERMINAL" != "0" ] \
        && [ -n "$TERMINAL" ] \
        && is_available "$TERMINAL"
}

# Run the given command in a new terminal.
function run_terminal {
    local cmd="$1"
    local cmd_bash="bash -c '$cmd || (echo -e \"----------\n[CONTINUE]\"; read)'"
    [ -n "$cmd" ] || err "No command given to function \`run_terminal\`."
    check "$TERMINAL"
    case "$TERMINAL" in
        "termite")
            termite -d "$ROOT" -e "$cmd_bash" & \
            disown
            ;;
        *)
            err "Function \`run_terminal\` is not configured for terminal '$TERMINAL'"
            ;;
    esac
}

check "basename"
check "dirname"
check "tee"

# Set `$ROOT` variable to the directory of this script,
# unless it was already set.
# If the name of the directory is 'bin', then set `$ROOT`
# to the parent directory of 'bin/'.
[ -z "$ROOT" ] \
    && ROOT="$( cd "$( dirname "$0" )" || exit 1; pwd )" \
    && [ "$( basename "$ROOT" )" = "bin" ] \
    && ROOT="$( dirname "$ROOT" )"

# Set the `$LOGFILE` variable unless it was already set.
[ -z "$LOGFILE" ] \
    && LOGFILE="$ROOT/.$( basename "$0" ).log"

# Create the directory path to `$LOGFILE` if it doesn't exist.
logfile_dir="$( dirname "$LOGFILE" )"
! [ -d "$logfile_dir" ] && mkdir -p "$logfile_dir"
unset logfile_dir

# Set the `$TERMINAL` variable unless it was already set.
[ -z "$TERMINAL" ] && TERMINAL="termite"

# DEPRECATED
# Set some ansi color code variables.
COLOR_ERR="1;31"
COLOR_MSG="0;33"
COLOR_MSG_STRONG="1;33"
COLOR_CODE="0;36;40"

# TODO
CLR_ERR=( "black" "red" "bold" )
CLR_WARN=( "black" "yellow" "bold" )
CLR_MSG=( "yellow" "default" "default" )
# CLR_MSG_STRONG=( "yellow" "default" "bold" )
CLR_CODE=( "blue" "black" "default" )
