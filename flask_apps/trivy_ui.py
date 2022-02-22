#!/usr/bin/env python3

import configparser
import os
import datetime

from flask import Flask, render_template, redirect, url_for
from flask_bootstrap import Bootstrap
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

from flask import Flask
app = Flask(__name__)

config = configparser.ConfigParser()
config_file = f'{os.environ["HOME"]}/.config/flask_app_keys'
print(f"{datetime.datetime.now()} Reading config file >{config_file}<")
config.read(config_file)
print(f'Config file data: {config.sections()}')

APP_KEY = config["default"]["flask_ui"]
prnt(f'App key: {APP_KEY}')
app.config['SECRET_KEY'] = APP_KEY


print("Started app")
@app.route('/')
def hello():
    return 'Hello World!'
