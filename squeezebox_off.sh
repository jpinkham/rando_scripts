#!/bin/bash
curl --silent --show-error  'http://192.168.11.14:9000/jsonrpc.js' -H 'User-Agent: STRONGBAD/8675309' --compressed -H 'Cookie: Squeezebox-player=00%3A04%3A20%3A06%3Ac2%3Aec;' --data '{"id":1,"method":"slim.request","params":["00:04:20:06:c2:ec",["power","0"]]}' 
