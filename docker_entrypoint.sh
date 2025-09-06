#!/bin/sh
set -e

EXAMPLE_DIRS="config database plugins"

copy_examples() {
    for dir in $EXAMPLE_DIRS; do
        if [ -d "$dir" ]; then
            cp -r "$dir"-example/* /"$dir"
        fi
    done
}

case "$1" in  
    ""|start)
        exec npm start
        ;;
    copy_examples)
        copy_examples
        echo Examples copied.
        ;;
esac