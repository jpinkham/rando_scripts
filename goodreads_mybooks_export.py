#!/usr/bin/env python3

# Goodreads.com - export current bookshelves

import configparser
import traceback
import time
import json
import os
import datetime
import pprint
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

#TODO move most items from config file to top of this file


print("Starting...")
print(f"{datetime.datetime.now()} Modules loaded.")

pp = pprint.PrettyPrinter(indent=4)

#TODO: Store the data in local SQLite

# read config values
config_file = "%s/.config/goodreads.conf" % os.environ['HOME']

#TODO:  Test if file exists

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
    export_file_path = f"${os.environ['HOME']}/${config['file_locations']['export_file']}.${datetime_format}.csv"
print(f"{datetime.datetime.now()} file to be stored at = {export_file_path}")

try:
    firefox_options = webdriver.FirefoxOptions()
    firefox_options.headless = config['firefox_options']['headless']
    firefox_options.add_argument("--start-maximized")
    print(f"{datetime.datetime.now()} Spawning browser using options: {firefox_options}")

    driver = webdriver.Firefox(options=firefox_options)
    print(f"{datetime.datetime.now()} Webdriver object creation successful")
except:
    print(f"{datetime.datetime.now()} Problem with webdriver while spawning browser. Script FAILED. Stacktrace:")
    print(traceback.format_exc())
    quit()

try:
    driver.get("https://www.goodreads.com")
    print(f"{datetime.datetime.now()} Loading Goodreads home page")

    print(f"{datetime.datetime.now()} Locating login link: {config['find_elements']['login_button']})")
    login_link = WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['login_link'])))
    login_link.click()
    print(f"{datetime.datetime.now()} Clicked!")

    #print(f"    Looking for username field >{config['find_elements']['username_field']}<. Waiting max of 60 seconds")
    #source for the next line: https://selenium-python.readthedocs.io/waits.html
    username_field = WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['username_field'])))
    #print("     Found username field!")
    print(f"{datetime.datetime.now()} Logging in with username {config['default']['username']}")
    #time.sleep(5)
    username_field.send_keys(config['default']['username'])
    #print('     Filled in username field')

    #print(f"    Looking for password field >{config['find_elements']['password_field']}<. Pausing 5 sec first")
    #time.sleep(5)
    password_field = WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['password_field'])))
    #print('     Found password field!')
    #pp.pprint(password_field)
    password_field.send_keys(config['default']['password'])
    #print('     Filled in password field. Moving to login button element')
    #print(f"{datetime.datetime.now()} Locating login button: {config['find_elements']['login_button']})")
    login_button = WebDriverWait(driver, 60).until(EC.presence_of_element_located((By.XPATH, config['find_elements']['login_button'])))
    login_button.click()
    print(f"{datetime.datetime.now()} Clicked login button/link!")
except:
    print(f"{datetime.datetime.now()} ERROR! Couldn't find all the login page elements. Stacktrace:")
    print(traceback.format_exc())
    print("Closing the browser.")
    driver.quit()
    print(f"{datetime.datetime.now()} Script FAILED. Exiting")
    quit()

# Assuming we've now logged in successfully, let's get our books exported!

try:
    # Navigate to export area
    driver.find_element(By.LINK_TEXT, "My Books").click()
    driver.find_element(By.LINK_TEXT, "Import and export").click()
    # Click export button
    driver.find_element(By.CSS_SELECTOR, ".js-LibraryExport").click()
    print(f"{datetime.datetime.now()} Clicked export link. Waiting for file to be generated...")

    # Wait for csv link to appear, then click it
    WebDriverWait(driver, 3000000).until(EC.presence_of_element_located((By.CSS_SELECTOR, "#exportFile > a")))
    elements = driver.find_elements(By.CSS_SELECTOR, "#exportFile > a")
    assert len(elements) > 0
    driver.find_element(By.CSS_SELECTOR, "#exportFile > a").click()
    print(f"{datetime.datetime.now()} Clicked link for export file")
    time.sleep(5)
    print(f"{datetime.datetime.now()} Slept for 5 seconds")



except:
    print(f"{datetime.datetime.now()} ERROR! Problem with exporting books. Stacktrace:")
    print(traceback.format_exc())
    print("Closing the browser.")
    driver.quit()
    print(f"{datetime.datetime.now()} Script FAILED. Exiting")
    quit()

print(f"{datetime.datetime.now()} I think the export download succeeded")
print("Closing the browser.")
driver.quit()
print(f"{datetime.datetime.now()} Exiting")
quit()
