#!/bin/bash

#Test times

if [ -z $1 ]; then
	echo "Parameter does not exist"
	echo "Please select a MySQL database"
else
    mysql -u oneadmin -poneadmin -e 'SELECT COUNT(*) FROM vm_pool' -D $1
    echo "SELECT body FROM vm_pool WHERE (state <> 6) ORDER BY oid"
    time mysql -u oneadmin -poneadmin -e 'SELECT body FROM vm_pool WHERE (state <> 6) ORDER BY oid' -D $1 > /tmp/output
fi
