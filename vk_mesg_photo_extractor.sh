#!/bin/bash

for d in messages/*/ ; do
    echo $d;
    grep 'userapi.com' --text -r --exclude=\*.urls  $d > $d"img.urls";
    grep 'audiomsg' --text -r --exclude=\*.urls  $d > $d"voice.urls";
    grep 'https://vk.com/video' --text -r --exclude=\*.urls $d > $d"video.urls";
    mawk '{match($0,/href=\047[^()]*\047/); s = substr($0,RSTART+6, RLENGTH-7); gsub(/[()]/,"", s); print s}' $d"img.urls" > $d"img_clear.urls"
    mawk '{match($0,/href=\047[^()]*\047/); s = substr($0,RSTART+6, RLENGTH-7); gsub(/[()]/,"", s); print s}' $d"voice.urls" > $d"voice_clear.urls"
    mawk '{match($0,/href=\047[^()]*\047/); s = substr($0,RSTART+6, RLENGTH-7); gsub(/[()]/,"", s); print s}' $d"video.urls" > $d"video_clear.urls"
    done

for d in messages/*/ ; do
    echo $d"img_clear.urls"
    echo $d"voice_clear.urls"
    parallel --gnu wget -P $d"img" < $d"img_clear.urls";
    parallel --gnu wget -P $d"voice" < $d"voice_clear.urls";
    done

for filename in messages/*/img/* ; do 
    mv "$filename" "$(echo "$filename" | sed -e 's/\?size=.*//')";  
    done