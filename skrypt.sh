#!/bin/bash

show_help() {
    echo "Usage: skrypt.sh [OPTION]"
    echo "Options:"
    echo "  --date             Display today's date"
    echo "  --logs [N]         Create N log files"
    echo "  --help             Display this help message"
}

display_date() {
    date
}

create_logs() {
    local count=$1
    for ((i=1; i<=$count; i++)); do
        echo "Log $i" > "log$i.txt"
        echo "Created by: $0" >> "log$i.txt"
        echo "Creation date: $(date)" >> "log$i.txt"
    done
}

create_gitignore() {
    echo "*log*" > .gitignore
}

case $1 in
    --date)
        display_date
        ;;
    --logs)
        if [ -z "$2" ]; then
            create_logs 100
        else
            create_logs $2
        fi
        ;;
    --help)
        show_help
        ;;
    *)
        echo "Unknown option: $1"
        show_help
        exit 1
        ;;
esac

create_gitignore

git add .
git commit -m "Add script changes"
git push

git checkout master
git merge $branch_name

git tag v1.0
