#!/usr/bin/env bash
# control Squeezebox

curl 'https://mysqueezebox.com/jsonrpc.js' \
--silent \
-X POST \
-H 'X-Requested-With: XMLHttpRequest' \
-H 'Referer: https://mysqueezebox.com/player/playerControl' \
-H 'Accept-Language: en-us' \
-H 'Origin: https://mysqueezebox.com' \
-H 'Content-Type: application/json' \
-H 'Host: mysqueezebox.com' \
--cookie 'sdi_squeezenetwork_session=64909%3Aj1Yc6DrnazjIkEa9b%2BK4q8ZGRVE; Squeezebox-player=00%3A04%3A20%3A07%3Ad3%3A27' \
-d "{\"id\":1,\"method\":\"slim.request\",\"params\":[\"00:04:20:07:d3:27\",[\"$1\"]]}" | jq .

