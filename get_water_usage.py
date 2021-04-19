#!/usr/bin/env python3
# LWConnect login with selenium
# parse resulting page to grab water usage data
# credentials and page element names are stored in local config file

print("Starting...")
import configparser
import time
# TODO use this to help determine paths for output. i think. #from pathlib import Path
import os
import sys
print("python path when running this script: %s" % sys.path)
from selenium import webdriver
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


config = configparser.ConfigParser()
print(f"{datetime.datetime.now()} Reading config file >{config_file}<")
#TODO: add try/except
config.read(config_file)
#print(f"{datetime.datetime.now()} Config file read. List of sections:")
#pp.pprint(config.sections())

# Get the current date in format YYYY-MM-DD
datetime_format = datetime.datetime.now().strftime("%Y-%m-%d")
screenshot_file_path = "%s/%s.%s.png" %\
        (os.environ['HOME'], config['file_locations']['usage_screenshot'], datetime_format)

print(f"{datetime.datetime.now()} screenshot file path = {screenshot_file_path}")

# create webdriver object
# Downloaded geckodriver from https://github.com/mozilla/geckodriver/releases
#driver = webdriver.Firefox("/Users/jpinkham/geckodriver")

print(f"{datetime.datetime.now()} Spawning headless browser")
firefox_options = webdriver.FirefoxOptions()
firefox_options.headless = True
driver = webdriver.Firefox(options=firefox_options)

#TODO: add try/except
driver.get("https://lwconnect.org")
print(f"{datetime.datetime.now()} Loaded LWConnect login page")
username_field = driver.find_element_by_id('username-email')
password_field = driver.find_element_by_id('password')
#print(datetime.datetime.now())
print(f"{datetime.datetime.now()} Logging in with username {config['default']['username']}")

#TODO: add try/except
username_field.send_keys(config['default']['username'])
password_field.send_keys(config['default']['password'])

#TODO: add try/except
print(f"{datetime.datetime.now()} Locating login button")
login_button = driver.find_element_by_xpath(config['find_elements']['login_button'])
login_button.click()
print(f"{datetime.datetime.now()} Clicked!")

#TODO: add try/except.  Code will quit here if it can't find this element, leaving browser open
#TODO: parse page to grab gallons of water used
##view_chart_link = driver.find_element_by_link_text('View Usage')
##view_chart_link.click()


# pause for a few seconds before taking screenshot, to give dashboard time to load
print(f"{datetime.datetime.now()} Sleeping for 15 sec while we wait for dashboard to load...")
time.sleep(15)
driver.save_screenshot(screenshot_file_path)
print(f"{datetime.datetime.now()} Screenshot successfully  saved to {screenshot_file_path}")

# Grab raw usage number and "as-of" date
usage_number = driver.find_element_by_xpath('//*[@id="layout-wrapper"]/div[2]/div[1]/section[2]/div/div/div[2]/div[3]/div/div[1]/h3').text
usage_date = driver.find_element_by_xpath('//*[@id="layout-wrapper"]/div[2]/div[1]/section[2]/div/div/div[2]/div[3]/div/div[1]/div/span[2]').text

usage_data_file = "%s/%s" % (os.environ['HOME'], config['file_locations']['usage_data'])
#TODO check file existence
#if !os.path.isfile(usage_data_file):
#    print(f"Error! Usage data file {usage_data_file} cannot be found. Assuming first run.")
#Path(usage_data_file.touch())
# this will auto-create an empty file if the file does not already exist, so that the script
#  won't break if the data file isn't there
os.system("touch %s" % usage_data_file)


#Log out
print(f"{datetime.datetime.now()} Logging out.")
driver.get('https://lwconnect.org/Users/Account/LogOff')

driver.close()
print(f"{datetime.datetime.now()} Closing browser.")

# don't want a bunch of zombie firefox instances hanging around if anything goes
# wrong with saving the data, so wait to perform these actions until selenium work is complete


print(f"{datetime.datetime.now()} Storing data in {usage_data_file}")
my_usage = "%s|%s" % (usage_number, usage_date)
with open(usage_data_file, 'a') as data_file:
    data_file.write("%s\n" % my_usage)


# Determine the difference since last time
prev_water_usage_file = "%s/%s" % (os.environ['HOME'], config['file_locations']['prev_usage_data'])
with open(prev_water_usage_file) as x:
    prev_water_usage_data = x.read()


# i'm sure there's a better way, but this is just an experiment
usage_number_int = usage_number.split()[0]  # this contains the word "Gallons", so we need to lop that off

print(f"{datetime.datetime.now()} LAST VALUE {prev_water_usage_data}")
print(f"{datetime.datetime.now()} CURRENT VALUE {usage_number}")

usage_diff = int(usage_number_int) - int(prev_water_usage_data)

print(f"{datetime.datetime.now()} Gallons used since last reading {usage_diff}")

# save usage_number_int to prev_usage_data file, to use for next time

# TODO Upload to adafruit IO
# First check if usage_diff is a non-zero number

print(f"{datetime.datetime.now()} Success!")
