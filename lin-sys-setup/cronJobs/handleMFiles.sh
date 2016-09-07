#!/bin/bash

mFiles="\.mp3$|\.flac$"
ignore="/home/m/Videos/M$|/home/m/Videos/A$|/home/m/Videos/L$"
musicLocation="$HOME/Videos/M"
pdfLocation="$HOME/master/M-Master/A"
rmFiles="\.html$|\.txt$|\.nfo$|\.jpg$|\.pdf$|\.png$|\.srt$|\.log$|\.md5$|\.cue$|\.m3u$|\.sfv$|\.smi$|\.jpeg$|\.bmp$"
article_type="\.pdf$"

check_if_should_remove_and_remove(){
    file="$1"
    if [[ "$file" =~ $rmFiles ]]; then
        rm -f "$file"
        echo "Removed: $file"
    fi
}

look_for_music(){
    moveFrom="$1"
    moveTo="$2"
    for file in "$moveFrom/"*; do
        if [[ "$file" =~ "\*$" ]]; then
            return
        fi
        echo "'$file'"
        if [ -d "$file" ]; then
            if [ "$moveFrom" != "$HOME/Downloads" ] && [[ ! "$file" =~ $ignore ]]; then
                if [[ "$file" =~ "Sample" ]]; then
                    rm -f "$file"
                else
                    look_for_music "$file" "$moveTo"
                fi
            fi
            fileCount=$(ls -1 -A "$moveFrom" | wc -l)
            if [ $fileCount = "0" ]; then
                rm -r "$moveFrom"
                return
            fi
        else
            if [[ "$file" =~ $mFiles ]]; then
                mv "$file" "$moveTo"
                echo "Moved: $file"
            fi
            if [ "$moveFrom" != "$HOME/Downloads" ] && [[ ! "$file" =~ $ignore ]]; then
                check_if_should_remove_and_remove "$file"
            fi
        fi
    done;
}

look_for_pdf(){
    moveFrom="$1"
    moveTo="$2"
    for file in "$moveFrom/"*; do
        if [ -d "$file" ]; then
            echo "d"
        else
            if [[ "$file" =~ $article_type ]]; then
                mv "$file" "$moveTo"
            fi
        fi
    done;
}

if [ "$1" = "a" ]; then
    look_for_pdf "$HOME/Downloads" "$pdfLocation"
    exit
fi

if [ "$1" = "d" ]; then
    look_for_music "$HOME/Downloads" "$musicLocation/5"
    exit
fi

if [ "$1" = "" ]; then
    look_for_music "$HOME/Videos" "$musicLocation"
    echo "Done!"
    exit
fi
