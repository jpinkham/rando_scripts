#!/usr/bin/env bash
# control Squeezebox
SBSESSION=$(cat $HOME/.config/squeezebox.conf)
# player = 00:04:20:07:D3:27
curl 'http://192.168.2.11:9000/jsonrpc.js' \
--silent \
-X POST \
-H 'Content-Type: application/json' \
-H 'Host: mysqueezebox.com' \
--cookie "sdi_squeezenetwork_session=$SBSESSION; Squeezebox-player=00%3A04%3A20%3A07%3Ad3%3A27" \
-d "{\"id\":1,\"method\":\"slim.request\",\"params\":[\"00:04:20:07:d3:27\",[\"$1\"]]}" | jq .

