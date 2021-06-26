#!/usr/bin/env python3
# LWConnect login with selenium
# parse resulting page to grab water usage data
# credentials and page element names are stored in local config file

print("Starting...")
import configparser
import time
import traceback
from pathlib import Path
import os
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException

from datetime import datetime
import datetime
import pprint

print(f"{datetime.datetime.now()} Modules loaded.")

pp = pprint.PrettyPrinter(indent=4)

#TODO: Store the data in local SQLite

# read config values
config_file = "%s/.config/lwconnect.conf" % os.environ['HOME']

#TODO:  Test if file exists
#if !(os.path.isfile(config)):
#    print(f"Error! Config file {config_file} cannot be found. Exiting.")
#    exit

try:
    config = configparser.ConfigParser()
    print(f"{datetime.datetime.now()} Reading config file >{config_file}<")
    #TODO: add try/except
    config.read(config_file)
    print(f"{datetime.datetime.now()} Config file read. List of sections:")
    pp.pprint(config.sections())
except:
    print(f"{datetime.datetime.now()} Problem with reading config file. Script FAILED. Stacktrace:")
    print(traceback.format_exc())
    print("         Exiting")
    quit()


# Get the current date in format YYYY-MM-DD
datetime_format = datetime.datetime.now().strftime("%Y-%m-%d")
screenshot_file_path = "%s/%s.%s.png" % (os.environ['HOME'], config['file_locations']['usage_screenshot'], datetime_format)
print(f"{datetime.datetime.now()} screenshot file path = {screenshot_file_path}")

try:
    firefox_options = webdriver.FirefoxOptions()
    firefox_options.headless = True
    #config['firefox_options']['headless']
    firefox_options.profile = "%s/%s" % (os.environ['HOME'], config['firefox_options']['profile'])
    firefox_options.add_argument("--start-maximized")

    webdriver_logpath = '/tmp/selenium.get_water_usage.log'

    print(f"{datetime.datetime.now()} Spawning browser using options: {firefox_options}")

    driver = webdriver.Firefox(options=firefox_options)

    #chrome_options = webdriver.ChromeOptions()
    #chrome_options.add_argument(f"--user_agent {config['chrome_options']['user_agent']}")
    #driver = webdriver.Chrome(options=chrome_options)
    print(f"{datetime.datetime.now()} Webdriver object creation successful")
except:
    print(f"{datetime.datetime.now()} Problem with webdriver while spawning browser. Script FAILED. Stacktrace:")
    print(traceback.format_exc())
    quit()


try:
    driver.get("https://lwconnect.org")
    print(f"{datetime.datetime.now()} Loading LWConnect login page")

    #print(f"{datetime.datetime.now()} ALL PAGE ELEMENTS for DIV:>{driver.find_elements(By.TAG_NAME, 'div')}")

    print(f"    Looking for username field >{config['find_elements']['username_field']}<. Waiting max of 60 seconds")
    #source for the next line: https://selenium-python.readthedocs.io/waits.html
    username_field = WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['username_field'])))
    print("     Found username field!")
    print(f"{datetime.datetime.now()} Logging in with username {config['default']['username']}")
    time.sleep(5)
##    username_field.send_keys(config['default']['username'])
    print('     Filled in username field')

    print(f"    Looking for password field >{config['find_elements']['password_field']}<. Pausing 5 sec first")
    time.sleep(5)
    #password_field = driver.find_element(By.XPATH, config['find_elements']['password_field'])
    password_field = WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['password_field'])))
    print('     Found password field!')
    #pp.pprint(password_field)
    password_field.send_keys(config['default']['password'])
    print('     Filled in password field')
    print(f"{datetime.datetime.now()} Locating login button: {config['find_elements']['login_button']})")
    #login_button = driver.find_element(By.XPATH, config['find_elements']['login_button'])
    login_button = WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['login_button'])))
    time.sleep(5)
    login_button.click()
    print(f"{datetime.datetime.now()} Clicked!")
except TimeoutException as timeout:
    #except TimeoutException(message, screen, stacktrace)
    print(f"{datetime.datetime.now()} TIMEOUT while waiting for a login page element. Stacktrace:")
    print(timeout.stacktrace)


except:
    print(f"{datetime.datetime.now()} ERROR! Couldn't find all the login page elements. Stacktrace:")
    print(traceback.format_exc())
    print("Closing the browser.")
    driver.quit()
    print(f"{datetime.datetime.now()} Script FAILED. Exiting")
    quit()
# pause for a few seconds before taking screenshot, to give dashboard time to load
print(f"{datetime.datetime.now()} Sleeping for 15 sec while we wait for dashboard to load...")
time.sleep(15)
driver.save_screenshot(screenshot_file_path)
print(f"{datetime.datetime.now()} Screenshot successfully  saved to {screenshot_file_path}")

usage_data_file = "%s/%s" % (os.environ['HOME'], config['file_locations']['usage_data'])

#TODO check file existence
#if !os.path.isfile(usage_data_file):
#    print(f"Error! Usage data file {usage_data_file} cannot be found. Assuming first run.")
#Path(usage_data_file.touch())
# this will auto-create an empty file if the file does not already exist, so that the script
#  won't break if the data file isn't there
os.system("touch %s" % usage_data_file)
try:
    # Grab raw usage number and "as-of" date
    WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['usage_amount_field'])))
    usage_number = driver.find_element(By.XPATH, config['find_elements']['usage_amount_field']).text
    usage_date = driver.find_element(By.XPATH, config['find_elements']['usage_date_field']).text

    #Log out
    print(f"{datetime.datetime.now()} Logging out.")
    driver.get('https://lwconnect.org/Users/Account/LogOff')
    driver.quit()
    print(f"{datetime.datetime.now()} Storing data in {usage_data_file}")
    my_usage = "%s|%s" % (usage_number, usage_date)
    with open(usage_data_file, 'a') as data_file:
        data_file.write("%s\n" % my_usage)
    print(f"{datetime.datetime.now()} Success!")
except:
    print(f"{datetime.datetime.now()} ERROR! Something went wrong while searching page for usage data. Script FAILED. Stacktrace:")
    print(traceback.format_exc())
    print("        Closing the browser.")

    driver.quit()
    print(f"{datetime.datetime.now()} Script FAILED")
