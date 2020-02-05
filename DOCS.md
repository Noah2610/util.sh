### `function is_available`
Returns `0` or `1` depending on if the given string is available as a command.

### `function is_running`
Returns `0` or `1` depending on if the command is running (using `pgrep`).

### `function check`
Exit with error message if the given string is not available as a command.

### `function check_file`
Exit with error message if the given file path does not exist.

### `function check_dir`
Exit with error message if the given directory path does not exist.

### `function msg`
Print the given string to stdout.

### `function err`
Print the given string to stderr and to the `$LOGFILE` (if one exists),  
then exit with exit code 1.

### `function warn`
Print the given string to stderr and to the `$LOGFILE`

### `function print_log`
Print the given string to the `$LOGFILE` (if one exists), and strip color from the text.

### `function _strip_ansi_codes`
Strip ansi codes from the given string.

### `function clrfg`
Echos the _FOREGROUND_ color code matching the given color argument.  
The given color string is a semantic representation of color.  
Available colors:  
```  
"black", "white", "red", "green", "blue",  
"yellow", "magenta", "cyan", "lightgray", "darkgray",  
"lightred", "lightgreen", "lightblue", "lightyellow",  
"lightmagenta", "lightcyan",  
"default", "reset"  
```  
https://misc.flogisoft.com/bash/tip_colors_and_formatting

### `function clrbg`
Echos the _BACKGROUND_ color code matching the given color argument.  
The given color string is a semantic representation of color.  
Available colors:  
```  
"black", "white", "red", "green", "blue",  
"yellow", "magenta", "cyan", "lightgray", "darkgray",  
"lightred", "lightgreen", "lightblue", "lightyellow",  
"lightmagenta", "lightcyan",  
"default", "reset"  
```

### `function clrattr`
Echos the attribute color code matching the given argument.  
The given argument string is a semantic representation of an attribute.  
Available attributes:  
```  
"bold", "dim", "underline", "blink", "invert", "hidden",  
"default", "reset"  
```

### `function clr`
Set the foreground, background, and attribute colors all at once.  
This function takes three arguments:  
- foreground color (see `clrfg`)  
- background color (see `clrbg`)  
- attribute (see `clrattr`)

### `function clrrs`
Resets all color settings to default.

### `function _color_code_generic`
Internal helper function.  
Returns the foreground color code number for the given color string.  
This is then used in the above color functions to create  
proper, printable color codes for foreground and background.

### `function semantic_date`
Print out a date string in a specifc format.  
If the command `boxed-string` is available, then it calls that with the date string.  
boxed-string: https://gist.github.com/Noah2610/2c4a92f6732419becade2f76bc943039

### `function try_run`
Tries to run the given command.  
All arguments are parsed as the command, so the first argument is the  
command, and all following arguments are passed as arguments to the command.  
Runs `err` if the command fails.  
Writes the command's output to the `$LOGFILE`.

### `function try_run_hidden`
Similar to function `try_run_hidden`, but hides the command's output.  
Tries to run the given command and hides its output.  
All arguments are parsed as the command, so the first argument is the  
command, and all following arguments are passed as arguments to the command.  
If the command fails, then it prints the output with `err`.  
Writes the command's output to the `$LOGFILE`.

### `function is_positive`
Returns `0` if the given argument represents a "positive" value (not empty and non-0).

### `function should_run_in_terminal`
Returns `0` or `1` depending on if the final command should be run in a new terminal.  
For very specific use-case(s).

### `function run_terminal`
Run the given command in a new terminal.  
The first argument is the command, any following arguments  
are passed to the command as its arguments.  
The new shell's working directory is set to the `$ROOT` variable.

### `function join_by`
https://stackoverflow.com/a/17841619
