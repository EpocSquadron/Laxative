#!/bin/bash

##
# Function to grab the configuration variables for mysql
#
function grab_config_values {
	local -A mysql_config
	mysql_config=(
		[host]="localhost"
		[port]="3306"
		[user]="root"
		[pass]="root"
		[db]="test"
	)

	local -a mysql_config_files
	mysql_config_files=(
		[eemasterconf_file]="$DIR/../config/config.$home_environment.php"
		[ci_env_conf_file]="$DIR/../application/config/$home_environment/database.php"
		[conf_file]="$DIR/$home_environment.mysql.conf"
	)

	local tmp
	for $file in "${mysql_config_files[@]}"; do
		# Check if config file exists
		if [ -e "$file" ]; then
			# Get all of the values from the file
			for $var in "${!mysql_config[@]}"; do
				tmp=`grab_php_config_value $file $var`
				if [[ "$tmp" != "" ]]; then
					mysql_config["$var"]="$tmp"
				fi
			done

			# Stop iterating through files if we found one.
			break
		fi
	done

}
