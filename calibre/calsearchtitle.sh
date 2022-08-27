#!/usr/bin/env bash 

function usage {
    echo "\nUsage: {$0} [<library name>] [<title search term>]\n";
}

# first argument is the script name itself, hence checking for arguments
if [ "$#" -ne 2 ]; then
    usage()
fi

LIB_NAME=$1
SEARCH_TERM=$2

echo "Searching $LIB_NAME for books with titles containing $SEARCH_TERM..."


for BOOKID in `calibredb search --with-library /usr/share/extra_storage/calibre/$LIB_NAME title:$SEARCH_TERM|sed 's/,/\n/g'`; do calibredb show_metadata --with-library /usr/share/extra_storage/calibre/$LIB_NAME $BOOKID|grep -E 'Title|ISBN'|grep -v sort;echo;done

