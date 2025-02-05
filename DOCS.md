# util.sh  
Version: `2.2.6`  
https://github.com/Noah2610/util.sh

<details>
<summary>Table of Contents</summary>

<sub>Generated with [`gentoc`](https://github.com/Noah2610/GenTOC)<sub>

- [Variables](#variables)
  - [`$ROOT`](#root)
  - [`$LOGFILE`](#logfile)
  - [`$TERMINAL`](#terminal)
  - [`$NO_COLOR`](#no_color)
- [Functions](#functions)
  - [`is_available()`](#is_available)
  - [`is_running()`](#is_running)
  - [`check()`](#check)
  - [`check_file()`](#check_file)
  - [`check_dir()`](#check_dir)
  - [`msg()`](#msg)
  - [`err()`](#err)
  - [`warn()`](#warn)
  - [`print_log()`](#print_log)
  - [`clrfg()`](#clrfg)
  - [`clrbg()`](#clrbg)
  - [`clrattr()`](#clrattr)
  - [`clr()`](#clr)
  - [`clrrs()`](#clrrs)
  - [`semantic_date()`](#semantic_date)
  - [`try_run()`](#try_run)
  - [`try_run_hidden()`](#try_run_hidden)
  - [`is_positive()`](#is_positive)
  - [`is_negative()`](#is_negative)
  - [`should_run_in_terminal()`](#should_run_in_terminal)
  - [`run_terminal()`](#run_terminal)
  - [`prompt_question()`](#prompt_question)
  - [`is_absolute_path()`](#is_absolute_path)
  - [`is_relative_path()`](#is_relative_path)
  - [`join_by()`](#join_by)
  - [`realpath()`](#realpath)
</details>

---

## Variables

### `$ROOT`
Set `$ROOT` variable to the directory of this script,  
unless it was already set.  
If the name of the directory is 'bin', then set `$ROOT`  
to the parent directory of 'bin/'.

### `$LOGFILE`
Set the `$LOGFILE` variable unless it was already set.

### `$TERMINAL`
Set the `$TERMINAL` variable unless it was already set.

### `$NO_COLOR`
Set `$NO_COLOR` to disable color output.

## Functions

### `is_available()`
Returns `0` or `1` depending on if the given string is available as a command.

### `is_running()`
Returns `0` or `1` depending on if the command is running (using `pgrep`).

### `check()`
Exit with error message if the given string is not available as a command.

### `check_file()`
Exit with error message if the given file path does not exist.

### `check_dir()`
Exit with error message if the given directory path does not exist.

### `msg()`
Print the given string to stdout.

### `err()`
Print the given string to stderr and to the `$LOGFILE` (if one exists),  
then exit with exit code 1.

### `warn()`
Print the given string to stderr and to the `$LOGFILE`

### `print_log()`
Print the given string to the `$LOGFILE` (if one exists), and strip color from the text.

### `clrfg()`
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

### `clrbg()`
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

### `clrattr()`
Echos the attribute color code matching the given argument.  
The given argument string is a semantic representation of an attribute.  
Available attributes:  
```  
"bold", "dim", "underline", "blink", "invert", "hidden",  
"default", "reset"  
```

### `clr()`
Set the foreground, background, and attribute colors all at once.  
This function takes three arguments:  
- foreground color (see `clrfg`)  
- background color (see `clrbg`)  
- attribute (see `clrattr`)

### `clrrs()`
Resets all color settings to default.

### `semantic_date()`
Print out a date string in a specifc format.  
If the command `boxed-string` is available, then it calls that with the date string.  
boxed-string: https://gist.github.com/Noah2610/2c4a92f6732419becade2f76bc943039

### `try_run()`
Tries to run the given command.  
All arguments are parsed as the command, so the first argument is the  
command, and all following arguments are passed as arguments to the command.  
Runs `err` if the command fails.  
Writes the command's output to the `$LOGFILE`.

### `try_run_hidden()`
Similar to function `try_run_hidden`, but hides the command's output.  
Tries to run the given command and hides its output.  
All arguments are parsed as the command, so the first argument is the  
command, and all following arguments are passed as arguments to the command.  
If the command fails, then it prints the output with `err`.  
Writes the command's output to the `$LOGFILE`.

### `is_positive()`
Returns `0` if the given argument represents a "positive" value (not empty and non-0).

### `is_negative()`
Returns `0` if the given argument represents a "negative" value (empty or 0).

### `should_run_in_terminal()`
Returns `0` or `1` depending on if the final command should be run in a new terminal.  
For very specific use-case(s).

### `run_terminal()`
Run the given command in a new terminal.  
The first argument is the command, any following arguments  
are passed to the command as its arguments.  
The new shell's working directory is set to the `$ROOT` variable.

### `prompt_question()`
Returns `0` or `1` depending on if the user answers  
positively (`y`) or negatively (`n`).  
The first argument is the message/question printed to `stdout`.  
Optionally, pass a second argument to set the default answer ("y" or "n").  
If no default is given, then the user will continue to be prompted until they  
answer with a valid input.

### `is_absolute_path()`
Returns `0` if the given argument is an absolute path (starts with "/").

### `is_relative_path()`
Returns `0` if the given argument is a relative path (does _not_ start with "/").

### `join_by()`
Joins the given arguments (starting at `$2`) with the given delimiter `$1`.  
https://stackoverflow.com/a/17841619

### `realpath()`
`realpath` wrapper function.  
Executes `realpath` if it is available, otherwise  
it just uses a combination of `cd` and `pwd`.
