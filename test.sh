#!/bin/bash

# Find location of this script so we can save output to correct directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function for grabbing a config value out of an ee-master-confi configuration file.
# Arg1 File to search.
# Arg2 Keyword of config value to search for.
grab_php_config_value() {
	## Filter comments with sed
	## Remove single-line comments (// or # comment)
	#	s/\/\/.*$//;
	#   s/#.*//
	## Insert newlines before /*
	#	s/\/\*/\
	#	&/;
	## Insert newlines after */
	#	s/\*\//&\
	#	/
	## Remove one-line block comments (/* something */)
	#	/\/\*.*\*\//d;
	## Remove multi-line block comments
	##	(/* line 1
	##	  * line 2 */)
	#	/\/\*/,/\*\//d
	## Strip empty lines
	#	/^\ *$/d
	## Extract variable with perl
	## Lookbehind, but dont match for $1'] = '
	#	(?<=$1\'\]\ \=\ \')
	## Match anything that isn't the closing single quote
	#	([^']+)
	## Lookahead for closing single quote
	#	(?=\')
	sed 's/\/\/.*$//;s/#.*//;s/\/\*/\
	&/;s/\*\//&\
	/' "$1" | sed '/\/\*.*\*\//d;/\/\*/,/\*\//d;/^\ *$/d' | perl -lne "print \$1 if /(?<=$2['\"]\]\ \=\ ['\"])([^'\"]+)(?=['\"])/i"
}

##
# Function to grab the configuration variables for mysql
#
# $1 - Environment whose files to look for
#
function grab_config_values {
	local home_environment="$1"; shift

	# Default config values
	local -A mysql_config=(
		[host]="localhost"
		[port]="3306"
		[user]="root"
		[pass]="root"
		[db]="test"
	)

	# Possible config files
	local -A mysql_config_files=(
		[eemasterconf_file]="$DIR/../config/config.$home_environment.php"
		[ci_env_conf_file]="$DIR/../application/config/$home_environment/database.php"
		[conf_file]="$DIR/$home_environment.mysql.conf"
	)

	# Loop through all the possible files
	local tmp=""
	for file in "${mysql_config_files[@]}"; do
		# Check if config file exists
		if [ -e "$file" ]; then
			# Get all of the values from the file
			for var in "${!mysql_config[@]}"; do
				grab_php_config_value $file $var
				tmp=$(grab_php_config_value $file $var)
				echo $tmp

				if [[ "$tmp" != "" ]]; then
					mysql_config["$var"]="$tmp"
				fi
			done

			# Stop iterating through files if we found one.
			break
		fi
	done

	for i in "${mysql_config[@]}"; do
		echo "$i"
	done

}

function main {
	local home_environment=$1; shift

	grab_config_values "$home_environment"
}

main $*
