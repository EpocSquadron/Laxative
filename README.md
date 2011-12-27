#MySQL CleanDump

This is a simple script for standardizing MySQL database dumps to a form more suitable to daily development needs.
It is meant to make db dumps git trackable, lightweight, and easy to import into any environment.

##Note to MAMP Users

If you have not already, you need to make bash able to find the mysqldump command.  This is hidden away inside nonstandard directories in MAMP. An easy solution is to create a symlink to the standard directory:

	ln -s /Applications/MAMP/Library/bin/mysqldump /usr/local/bin/mysqldump
