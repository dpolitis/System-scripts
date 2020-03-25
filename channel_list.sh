#!/bin/bash

curl -RO https://raw.githubusercontent.com/free-greek-iptv/greek-iptv/master/android.m3u

sed -i '/#EXTM3U/d' android.m3u
sed -i -e 's/^#.*,/Channel name: /' android.m3u
sed -i -e 's/^http/URL: http/' android.m3u

mv android.m3u channels.txt
