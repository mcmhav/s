#!/bin/bash

getCount() {
    if [ "$verbose" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] PROCESSING \n"
    fi

    numOfLines=$(wc -l < "$filename");
    todayDate="$(date +'%Y-%m-%d')"

    i=0
    while IFS='' read -r line; do
        lineArr=(${line// / })

        lineDate="${lineArr[1]}"

        if [ "$lineDate" == "$todayDate" ]; then
            i=$((i + 1))
        fi

        if [ "$verbose" == "true" ]; then
            printf "[INFO] %s %% \r" "$((((i)*100)/numOfLines))"
        fi
    done < "$filename"

    if [ "$verbose" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] count today %s \n" "$i"
    fi
    echo "$i"
}

addCoffee() {
    if [ "$verbose" == "true" ]; then
        printf "[INFO] Adding coffee"
    fi
    echo "$(date +'%s %Y-%m-%d %H:%M:%S')" ";" >> "$filename";
}

usage(){
    echo "haha";
}

verbose=""
filename="coffee.log"

while [ "$1" != "" ]; do
    case $1 in
        -g | --getCount )
            getCount
            exit;
            ;;
        -a | --addCoffee )
            addCoffee
            ;;
        -v | --verbose )
            verbose="true"
            ;;
        -h | --help )
            usage
            exit
            ;;
        * )
            usage
            exit 1
    esac
    shift
done
