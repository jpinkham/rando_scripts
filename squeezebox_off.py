#!/usr/bin/env python3
# Power off Squeezebox
# parse resulting page to grab water usage data
# credentials and page element names are stored in local config file

##curl --silent --show-error  'http://192.168.11.14:9000/jsonrpc.js' -H 'User-Agent: STRONGBAD/8675309' --compressed -H 'Cookie: Squeezebox-player=00%3A04%3A20%3A06%3Ac2%3Aec;' --data '{"id":1,"method":"slim.request","params":["00:04:20:06:c2:ec",["power","0"]]}' 

print("Starting...")
import configparser
import os
import time
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from datetime import datetime
import datetime
import pprint

print(f"{datetime.datetime.now()} Modules loaded.")

pp = pprint.PrettyPrinter(indent=4)

# read config values
config_file = "%s/.config/squeezebox.conf" % os.environ['HOME']
config = configparser.ConfigParser()
print(f"{datetime.datetime.now()} Reading config file >{config_file}<")
#TODO: add try/except
config.read(config_file)
print(f"{datetime.datetime.now()} Config file read. List of sections:")
pp.pprint(config.sections())

# Get the current date in format YYYY-MM-DD
datetime_format = datetime.datetime.now().strftime("%Y-%m-%d")


print(f"{datetime.datetime.now()} Spawning headless browser")
firefox_options = webdriver.FirefoxOptions()
firefox_options.headless = True
driver = webdriver.Firefox(options=firefox_options)
print(f"{datetime.datetime.now()} Webdriver object creation successful")

try:
    driver.get("https://mysqueezebox.com")
    print(f"{datetime.datetime.now()} Locating Logitech Squeezebox login link")
    login_link =  driver.find_element(By.CSS,config['find_elements']['goto_login'])
    login_link.click()
    print(f"{datetime.datetime.now()} Clicked!")

    print(f"{datetime.datetime.now()} Loading login page")
    print(f"    Looking for username field >{config['find_elements']['username_field']}")
    username_field = driver.find_element(By.XPATH,config['find_elements']['username_field'])
    print("     Found username field!")
    print(f"    Looking for password field >{config['find_elements']['password_field']}")
    password_field = driver.find_element(By.XPATH,config['find_elements']['password_field'])
    print('     Found password field!')
    #print(datetime.datetime.now())
    print(f"{datetime.datetime.now()} Logging in with username {config['default']['username']}")

    username_field.send_keys(config['default']['username'])
    password_field.send_keys(config['default']['password'])

    print(f"{datetime.datetime.now()} Locating login button: {config['find_elements']['login_button']})")
    login_button = driver.find_element(By.CSS,config['find_elements']['login_button'])
    login_button.click()
    print(f"{datetime.datetime.now()} Clicked!")
except:
    print(f"{datetime.datetime.now()} ERROR! Couldn't find all the login page elements. Closing the browser.")
    driver.quit()
    print(f"{datetime.datetime.now()} Script FAILED. Exiting")
    quit()


