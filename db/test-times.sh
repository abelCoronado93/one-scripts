#!/bin/bash

# Test times
# SQLite config ~/.sqliterc:
#   .output /tmp/a
echo "SELECT * FROM vm_pool"
time sqlite3 $1 'SELECT * FROM vm_pool;'
echo ""

echo "SELECT body FROM vm_pool WHERE (state <> 6) ORDER BY oid"
time sqlite3 $1 'SELECT body FROM vm_pool WHERE (state <> 6) ORDER BY oid;'

