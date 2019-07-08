# `util.sh`
Bash utility functions. Primarily for my personal use.

## Installation
### Manually
The easiest way to use my `util.sh` script is to simply download the [`util.sh`][util.sh] script directly  
and `source` it yourself from within your bash script.

### Using `download-util.sh`
If you want to make things slightly more ~complicated~ _fun_ for yourself,  
you can also download the provided [`download-util.sh`][download-util.sh] script  
and run that from within your script to download the newest version of `util.sh`.  
`download-util.sh` attempts to download `util.sh` using `curl`.  
It will never overwrite an existing file.

### Using the bootstrap
To quickly copy/paste the often-similar boilerplate code for using `util.sh`,  
I have provided the [`bootstrap.sh`][bootstrap.sh] file.  
The file is quite self-explanatory, once you look inside.  
It provides some boilerplate code, which downloads `util.sh` (using `download-util.sh`),  
unless the `util.sh` file already exists, and `source`s the file.

---

__TODO:__ Documentation

[util.sh]:          https://raw.githubusercontent.com/Noah2610/util.sh/master/util.sh
[download-util.sh]: https://raw.githubusercontent.com/Noah2610/util.sh/master/download-util.sh
[bootstrap.sh]:     https://raw.githubusercontent.com/Noah2610/util.sh/master/bootstrap.sh
