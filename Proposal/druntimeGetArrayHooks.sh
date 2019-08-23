#!/bin/bash

# How to use:
# > cd druntime
# > /path/to/druntimeGetArrayHooks.sh
# Done!


# Gets all array hooks and what file they are in
egrep -o -R "_d_.*array.*\(.*[^;]$" | grep -v "assocarray" | grep "TypeInfo"


# Get the list of symbols
egrep -o -R "_d_.*array.*\(.*[^;]$" | grep -v "assocarray"  | grep "TypeInfo" | cut -d':' -f2 | egrep -o "_d_[^(]*" | sort -u > /tmp/symbols.txt

# Get all the files the hooks are in and get the line of code each function have.
egrep -o -R "_d_.*array.*\(.*[^;]$" | grep -v "assocarray"  | grep "TypeInfo" | cut -d':' -f1 | sort -u | xargs ../calcSymbols.d > /tmp/files.txt


# Generate only get the function we care about
grep "Module\|"$(cat /tmp/symbols.txt| xargs echo | sed "s/ /\\\|/g") /tmp/files.txt

rm /tmp/{files,symbols}.txt
