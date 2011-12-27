#!/bin/bash

# Check for existence of mysqldump
hash mysqldump 2>&- || { echo >&2 "The mysqldump utility is required but is either not installed or not in your PATH.  Aborting."; exit 1; }

# Settings for db connection
case "$1" in
  "local" )
	HOST=
	PORT=
	USER=
	PASS=""
	DB=
	ENV="local"
  ;;
  "test" )
  	HOST=
	PORT=
	USER=
	PASS=""
	DB=
	ENV="test"
  ;;
  * )
  	cat <<HEREDOC
	Usage:
		Specify which enivornment you're in.  Environment credentials must be added to the file ahead of time.

	Environments:
		local - Localhost database.
		test - Testing database on remote server.
HEREDOC
  	exit;
  ;;
esac

# Let's find out where the script is
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# # Create a dump of the database schema
# mysqldump \
## Connection to localhost
# 	--host=$HOST \
# 	--port=$PORT \
# 	--user=$USER \
# 	--password=$PASS \
## Drop everything first - Not drop database
##  for compatibility with cPanel
# 	--add-drop-table \
## Skip commenting, as timestamp changes diff
#  --skip-comments
## Make sure to recreate every detail
# 	--create-options \
## Use utf8
# 	--default-character-set=utf8 \
## Don't dump the data
# 	--no-data \
## Save db to schema.sql
# 	$DB >schema.sql

mysqldump --host=$HOST --port=$PORT --user=$USER --password=$PASS --add-drop-table --skip-comments --create-options --default-character-set=utf8 --no-data $DB >$DIR/schema.sql

# # Create a dump of the actual data
# mysqldump \
## Connection to localhost
# 	--host=$HOST \
# 	--port=$PORT \
# 	--user=$USER \
# 	--password=$PASS \
## Include column names in inserts
# 	--complete-insert \
## Skip commenting, as timestamp changes diff
#  --skip-comments
## Make loading faster by delaying index creation
# 	--disable-keys \
## Use VALUES (row1), (row2),.. for smaller file, faster insert
# 	--extended-insert \
## Don't replicate db and table data
# 	--no-create-db \
# 	--no-create-info \
## Don't buffer rows in case db very large
# 	--quick \
##  Split VALUES (),(),...,(); into newline separated
##  This makes diffs smaller for git.
# 	$DB | sed 's/),(/),\
#   (/g'
## Save db to data.sql
# >data.sql

# Create a dump of the actual data
mysqldump --host=$HOST --port=$PORT --user=$USER --password=$PASS --complete-insert --skip-comments --disable-keys --extended-insert --no-create-db --no-create-info --quick $DB | sed 's/),(/),\
(/g' >$DIR/$ENV-data.sql
