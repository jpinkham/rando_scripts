from flask import Flask
app = Flask(__name__)

print("Started app")
@app.route('/')
def hello():
    return 'Hello World!'
