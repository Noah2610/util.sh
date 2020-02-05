# util.sh  
Version: `2.2.2`  
https://github.com/Noah2610/util.sh

<details>
<summary>
Table of Contents
</summary>

- [Functions](#functions)
  - [`function is_available`](#function-is_available)
  - [`function is_running`](#function-is_running)
  - [`function check`](#function-check)
  - [`function check_file`](#function-check_file)
  - [`function check_dir`](#function-check_dir)
  - [`function msg`](#function-msg)
  - [`function err`](#function-err)
  - [`function warn`](#function-warn)
  - [`function print_log`](#function-print_log)
  - [`function clrfg`](#function-clrfg)
  - [`function clrbg`](#function-clrbg)
  - [`function clrattr`](#function-clrattr)
  - [`function clr`](#function-clr)
  - [`function clrrs`](#function-clrrs)
  - [`function semantic_date`](#function-semantic_date)
  - [`function try_run`](#function-try_run)
  - [`function try_run_hidden`](#function-try_run_hidden)
  - [`function is_positive`](#function-is_positive)
  - [`function is_negative`](#function-is_negative)
  - [`function should_run_in_terminal`](#function-should_run_in_terminal)
  - [`function run_terminal`](#function-run_terminal)
  - [`function prompt_question`](#function-prompt_question)
  - [`function is_absolute_path`](#function-is_absolute_path)
  - [`function is_relative_path`](#function-is_relative_path)
  - [`function join_by`](#function-join_by)

</details>

---

## Functions

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

### `function is_negative`
Returns `0` if the given argument represents a "negative" value (empty or 0).

### `function should_run_in_terminal`
Returns `0` or `1` depending on if the final command should be run in a new terminal.  
For very specific use-case(s).

### `function run_terminal`
Run the given command in a new terminal.  
The first argument is the command, any following arguments  
are passed to the command as its arguments.  
The new shell's working directory is set to the `$ROOT` variable.

### `function prompt_question`
Returns `0` or `1` depending on if the user answers  
positively (`y`) or negatively (`n`).  
The first argument is the message/question printed to `stdout`.

### `function is_absolute_path`
Returns `0` if the given argument is an absolute path (starts with "/").

### `function is_relative_path`
Returns `0` if the given argument is a relative path (does _not_ start with "/").

### `function join_by`
https://stackoverflow.com/a/17841619
