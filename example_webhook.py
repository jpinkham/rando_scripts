#!/usr/bin/env python3

from flask import Flask, request, Response

app = Flask( __name__ )

@app.route('/webhook', methods=['GET'])
def respond():
    print(request.json);
    return Response(status=200)
