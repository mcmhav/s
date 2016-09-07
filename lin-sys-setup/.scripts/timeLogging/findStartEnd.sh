#!/bin/bash

handleFile(){
    printf "[INFO] ------------------------------------------------------------------------\n"
    printf "[INFO] PROCESSING \n"

    prevDay="";

    expectedHoursPerDay=8;
    totalOnTime=0;
    totalDays=0;
    numOfLines=$(wc -l < "$filename");

    i=0
    while IFS='' read -r line; do
        lineArr=(${line// / })
        lineTS="${lineArr[0]}"
        onOff="${lineArr[3]}"

        lineDate="${lineArr[1]}"

        if [ "$prevDay" != "$lineDate" ]; then
            totalDays=$((totalDays + 1))
        fi

        if [ "$onOff" == "on" ]; then
            totalOnTime=$((totalOnTime - lineTS))
        elif [ "$onOff" == "off" ]; then
            totalOnTime=$((totalOnTime + lineTS))
        fi

        prevDay="$lineDate"

        i=$((i + 1))
        printf "[INFO] %s %% \r" "$((((i)*100)/numOfLines))"
    done < "$filename"

    now=$(date +'%s')
    totalOnTime=$((totalOnTime + now))
    totalTimeInHours=$((totalOnTime/(60*60)))
    hoursDiff=$(((totalTimeInHours)-expectedHoursPerDay*(totalDays)))

    printf "[INFO] ------------------------------------------------------------------------\n"
    printf "[INFO] Total time in hours: %s \n" "$totalTimeInHours"
    printf "[INFO] Total days in count: %s \n" "$totalDays"
    printf "[INFO] Avg. hours per day : %s \n" "$((totalTimeInHours/totalDays))"
    printf "[INFO] Hours from expected: %s \n" "$((hoursDiff))"
}

firstToLast(){
    if [ "$verbose" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] PROCESSING \n"
    fi

    prevDay="";

    expectedHoursPerDay=8;
    totalOnTime=0;
    totalDays=0;
    numOfLines=$(wc -l < "$filename");
    prevTS=0;

    i=0
    while IFS='' read -r line; do
        lineArr=(${line// / })
        lineTS="${lineArr[0]}"
        onOff="${lineArr[3]}"

        lineDate="${lineArr[1]}"

        if [ "$prevDay" != "$lineDate" ]; then
            totalDays=$((totalDays + 1))
            totalOnTime=$((totalOnTime + prevTS))
            totalOnTime=$((totalOnTime - lineTS))
        fi

        prevTS="$lineTS"

        prevDay="$lineDate"

        i=$((i + 1))
        # printf "[INFO] %s %% \r" "$((((i)*100)/numOfLines))"
    done < "$filename"

    now=$(date +'%s')
    totalOnTime=$((totalOnTime + now))
    # totalTimeInHours=$((totalOnTime/(60*60)))
    totalTimeInHours=$(echo "scale=2; $totalOnTime/(60*60)" | bc -l)
    # hoursDiff=$(((totalTimeInHours)-expectedHoursPerDay*(totalDays)))
    hoursDiff=$(echo "scale=2; ($totalTimeInHours)-$expectedHoursPerDay*($totalDays)" | bc -l)

    if [ "$verbose" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] Total time in hours: %s \n" "$totalTimeInHours"
        printf "[INFO] Total days in count: %s \n" "$totalDays"
        printf "[INFO] Avg. hours per day : %s \n" "$((totalTimeInHours/totalDays))"
        printf "[INFO] Hours from expected: %s \n" "$((hoursDiff))"
    else
        printf "%s" "$hoursDiff"
    fi
}

workStats(){
    if [ "$verbose" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] workStats \n"
    fi

    prevDay="";

    expectedHoursPerDay=8;
    totalOnTime=0;
    totalDays=0;
    numOfLines=$(wc -l < "$filename");
    prevTS=0;

    i=0

    today="$(date +'%Y-%m-%d')"
    startTime=""
    startTimeTS=""
    while IFS='' read -r line; do
        lineArr=(${line// / })

        lineTS="${lineArr[0]}"
        lineDate="${lineArr[1]}"
        lineTime="${lineArr[2]}"
        onOff="${lineArr[3]}"

        if [ "$prevDay" != "$lineDate" ]; then
            totalDays=$((totalDays + 1))
            totalOnTime=$((totalOnTime + prevTS))
            totalOnTime=$((totalOnTime - lineTS))
        fi

        if [ "$today" == "$lineDate" ] && [ -z "$startTime" ]; then
            startTime="$lineTime"
            startTimeTS="$lineTS"
        fi

        prevTS="$lineTS"

        prevDay="$lineDate"

        i=$((i + 1))
        # printf "[INFO] %s %% \r" "$((((i)*100)/numOfLines))"
    done < "$filename"

    now=$(date +'%s')
    totalOnTime=$((totalOnTime + now))
    endTimeTS=$(($startTimeTS + (($expectedHoursPerDay + 2) * 60 * 60)))
    endTime=$(date -ud @$endTimeTS +'%H:%M:%S')
    # totalTimeInHours=$((totalOnTime/(60*60)))
    totalTimeInHours=$(echo "scale=2; $totalOnTime/(60*60)" | bc -l)
    # hoursDiff=$(((totalTimeInHours)-expectedHoursPerDay*(totalDays)))
    hoursDiff=$(echo "scale=2; ($totalTimeInHours)-$expectedHoursPerDay*($totalDays)" | bc -l)

    hoursToday=$(echo "scale=2; ($(date +'%s')-$startTimeTS)/(60*60)" | bc -l)
    hoursNeededToday=$(echo "scale=2; x=$expectedHoursPerDay-$hoursToday; if(x<0) print 0; if(x>=0) print x;" | bc -l)
    hoursTillOnDayTimeOff=$(echo "scale=0; $expectedHoursPerDay-(($hoursDiff+$hoursNeededToday)%$expectedHoursPerDay)" | bc -l)
    # daysOff="${awk 'BEGIN {print int(($hoursDiff+$hoursNeededToday)/8)}'}"
    daysOff=$(awk -vHD="$hoursDiff" -vHND="$hoursNeededToday" -vEHPD="$expectedHoursPerDay" 'BEGIN {print int((HD+HND)/EHPD)}')

    if [ "$verbose" == "true" ] || [ "$verboseSum" == "true" ]; then
        printf "[INFO] ------------------------------------------------------------------------\n"
        printf "[INFO] StartTime:\t\t\t\t %s \n" "$startTime"
        printf "[INFO] EndTime:\t\t\t\t %s \n" "$endTime"
        printf "[INFO] HoursAhead:\t\t\t %s \n" "$hoursDiff"
        printf "[INFO] HoursToday:\t\t\t %s \n" "$hoursToday"
        printf "[INFO] HoursMoreToday:\t\t %s \n" "$hoursNeededToday"
        printf "[INFO] HoursExtraTillTimeOff:\t %s \n" "$hoursTillOnDayTimeOff"
        printf "[INFO] DaysOff:\t\t\t\t %s \n" "$daysOff"
    else
        printf "%s \n" "$startTime"
        printf "%s \n" "$endTime"
        printf "%s \n" "$hoursDiff"
        printf "%s \n" "$hoursToday"
        printf "%s \n" "$hoursNeededToday"
        printf "%s \n" "$hoursTillOnDayTimeOff"
        printf "%s \n" "$daysOff"
    fi
}

usage(){
    echo "haha";
}

filename="onoff.log"
verbose="";
verboseSum="";
ftl="";
ws="";

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
        -h | --help )
            usage
            exit
            ;;
        -ftl | --firstToLast )
            ftl="true"
            ;;
        -ws | --workStats )
            ws="true"
            ;;
        * )
            usage
            exit 1
    esac
    shift
done

# if [ -z "$1" ]; then
if [ "$ftl" == "true" ]; then
    firstToLast
elif [ "$ws" == "true" ]; then
    workStats
else
    handleFile
fi
