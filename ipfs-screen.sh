#!/bin/bash

####
#START
#goo.gl API key
google_api_key=AIzaSyAdr9yOCVcvtPJHA4VkX2gqnmcjXHQosWw

# Shorten a URL using the Google URL Shortener service (http://goo.gl).
goo_gl() {
    curl -qsSL -m10 --connect-timeout 10 \
        "https://www.googleapis.com/urlshortener/v1/url?key=$google_api_key" \
        -H 'Content-Type: application/json' \
        -d '{"longUrl": "'$1'"}' \
    | \
    perl -ne 'if(m/^\s*"id":\s*"(.*)",?$/i) { print $1 }'
}
#END
####

mkdir -p ~/.ipfs-screen/
file=$(`which date` +"%Y%m%d_%H%M%S_screenshot.jpg")
clipboard_command="xclip -selection clipboard"

platform=`uname`
if [[ "$platform" == "Darwin" ]]
then
  screencapture -t jpg -i "${HOME}/.ipfs-screen/$file"
  clipboard_command="pbcopy"
else
  gnome-screenshot -a -f "${HOME}/.ipfs-screen/$file"
fi

[ -f "${HOME}/.ipfs-screen/$file" ] || exit 0

#hash=$(cat "${HOME}/.ipfs-screen/$file" | `which ipfs` add --pin=false -w -q | `which tr` -s '[:space:]' ' ')
hash=$(cat "${HOME}/.ipfs-screen/$file" | `which ipfs` add --stdin-name=$file --pin=false -w --progress=false |awk 'NR==2{print $2"/"}'| { read h; echo $h''$file; })
#hash=$(cat "${HOME}/.ipfs-screen/$file" | `which ipfs` add --stdin-name=$file --pin=false -w --progress=false |awk 'NR==1{print $2"/"$3}')
[ ! $hash ] && exit 0

rm "${HOME}/.ipfs-screen/$file"

ipfs_link="https://gateway.ipfs.io/ipfs/$hash"

short_url=$(goo_gl $ipfs_link)
url=$([ $short_url ] && echo $short_url || echo $ipfs_link)

echo "File ${HOME}/.ipfs-screen/$file added... as $hash ($url)" >> ~/.ipfs-screen/ipfs-add.log

echo -n $url | $clipboard_command > /dev/null

echo $url

proxychains4 curl $url &

#play sound 
if [ -t 1 ]
then
    /usr/bin/osascript -e "display notification \"$url\" with title \"Screenshot created\""
    tput bel
else
    afplay "/System/Library/Sounds/Glass.aiff"
fi

exit 0