#!/bin/bash

halflife(){
    if [ "$verbose" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] current caffeine value \n"
        printf "[INFO] ------------------------------------------------------------------------\n"
    fi

    # 86400 s one day
    HALF_LIFE_CONST="20520"; # 5.7 hours, 342 min, 20520 s
    CAFFEINE_PER_CUP="60"; # mg

    prevCaffeine=0

    numOfLines=$(wc -l < "$filename");
    prevTS=1469535441;

    i=0

    today="$(date +'%Y-%m-%d')"
    while IFS='' read -r line; do
        lineArr=(${line// / })

        lineTS="${lineArr[0]}"
        lineDate="${lineArr[1]}"
        lineTime="${lineArr[2]}"

        diffTS=$(($lineTS-$prevTS))

        prevCaffeine=$(awk -vPC="$prevCaffeine" -vDTS="$diffTS" -vCPC="$CAFFEINE_PER_CUP" -vHL="$HALF_LIFE_CONST" 'BEGIN {print ((PC)*((1/2)**(DTS/HL)) + CPC)}')

        if [ "$verbose" == "true" ]; then
            printf "[INFO] CaffeineLvl at %s %s: %s \n" "$lineDate" "$lineTime" "$prevCaffeine"
        fi


        prevTS="$lineTS"

        i=$((i + 1))
        # printf "[INFO] %s %% \r" "$((((i)*100)/numOfLines))"
    done < "$filename"

    now=$(date +'%s')

    diffTS=$(($now-$prevTS))

    nowCaffeine=$(awk -vPC="$prevCaffeine" -vDTS="$diffTS" -vHL="$HALF_LIFE_CONST" 'BEGIN {print ((PC)*((1/2)**(DTS/HL)))}')

    if [ "$verbose" == "true" ]; then
        printf "[INFO] CaffeineLvl at now: %s \n" "$nowCaffeine"
    fi

    if [ "$verbose" == "true" ] || [ "$verboseSum" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] NowCaffeine: %s \n" "$nowCaffeine"
    else
        printf "%s" "$nowCaffeine"
    fi
}

usage(){
    echo "haha";
}

filename="coffee.log"
verbose="";
verboseSum="";

while [ "$1" != "" ]; do
    case $1 in
        -f | --file )
            shift
            filename=$1
            ;;
        -v | --verbose )
            verbose="true"
            ;;
        -vs | --verboseSum )
            verboseSum="true"
            ;;
        -hf | --halflife )
            halflife
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
