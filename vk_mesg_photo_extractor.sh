grep -r userapi.com ./messages/* > test
mawk '{match($0,/href=\047[^()]*\047/); s = substr($0,RSTART+6, RLENGTH-7); gsub(/[()]/,"", s); print s}' test > urls
parallel --gnu wget -P ./downloads < urls
for filename in ./downloads/*; do mv "$filename" "$(echo "$filename" | sed -e 's/\?size=.*//')";  done