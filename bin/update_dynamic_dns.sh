#!/bin/bash
NEW_IP=$(curl ipconfig.me -q 2>/dev/null)
DOMAINNAME=$1
SECRET=$2

URL="http://dynamicdns.park-your-domain.com/update?host=@&domain=%s&password=%s&ip=%s"
FURL=$(printf "$URL" "$DOMAINNAME" "$SECRET" "$NEW_IP")
curl $FURL 2>/dev/null
