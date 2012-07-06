# Laxative

This is a simple script for standardizing MySQL database dumps to a form more suitable to daily development needs. In other words, a "dump softener". It is meant to make db dumps as git trackable, lightweight, and easy to import into any environment as possible.

## Requirements

A working installation (findable in BASH's PATH) of the following:

 - mysql (& mysqldump)
 - sed (BSD or GNU)
 - grep

### Note to MAMP Users

If you have not already, you need to make bash able to find the mysqldump command.  This is hidden away inside nonstandard directories in MAMP. An easy solution is to create a symlink to the standard directory:

	ln -s /Applications/MAMP/Library/bin/mysqldump /usr/local/bin/mysqldump

Or add the MAMP MySQL binaries to your PATH in ~/.bash_profile:

	PATH=$PATH:/Applications/MAMP/Library/bin


## Installation

Simply copy lax to it's own directory inside the root of your project.  Laxative will save and load databases from that directory. Configuration for each environment will either be inherited from your ee-master-config configuration, or from .conf files in it's own directory matching the syntax of template.conf.


## Usage

Laxative works via the script `lax`, which accepts a command followed by an "environment shortname".  The environment shortname is the abbreviation by which you name the configuration files for accessing your database.

### Take a Dump

	lax dump <environment_shortname>

### Load a Dump

	lax load <environment_shortname>

### Replace One Environment's Dump with Another's

	lax usurp <from_environment_shortname> <to_environment_shortname>
