#!/usr/bin/env bash
# Pause Squeezebox

# curl 'https://mysqueezebox.com/jsonrpc.js' \
# -X POST \
# -H 'Content-Type: application/json' \
# -H 'Origin: https://mysqueezebox.com' \
# -H 'Cache-Control: no-cache' \
# -H 'X-Requested-With: XMLHttpRequest' \
# -H 'Connection: keep-alive' \
# -H 'Pragma: no-cache' \
#  --cookie 'sdi_squeezenetwork_session=64909%3Aj1Yc6DrnazjIkEa9b%2BK4q8ZGRVE; Squeezebox-player=00%3A04%3A20%3A07%3Ad3%3A27' \
# -d '{"id":1,"method":"slim.request","params":["00:04:20:07:d3:27",["pause"]]}'

curl 'https://mysqueezebox.com/jsonrpc.js' \
-X POST \
-H 'X-Requested-With: XMLHttpRequest' \
-H 'Referer: https://mysqueezebox.com/player/playerControl' \
-H 'Accept-Language: en-us' \
-H 'Origin: https://mysqueezebox.com' \
-H 'Content-Type: application/json' \
-H 'Host: mysqueezebox.com' \
--cookie 'sdi_squeezenetwork_session=64909%3Aj1Yc6DrnazjIkEa9b%2BK4q8ZGRVE; Squeezebox-player=00%3A04%3A20%3A07%3Ad3%3A27' \
-d '{"id":1,"method":"slim.request","params":["00:04:20:07:d3:27",["pause"]]}'

