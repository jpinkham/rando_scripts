#!/usr/bin/env python3
# LWConnect login with selenium
# parse resulting page to grab water usage data
# credentials and page element names are stored in local config file

import configparser
import time
import os
from selenium import webdriver
from datetime import datetime


#TODO: Store the data in local SQLite



# read config values
config_file = "/Users/jpinkham/.config/lwconnect.conf"
config = configparser.ConfigParser()
#TODO: add try/except
config.read(config_file)

# Get the current date in format YYYY-MM-DD
datetime_format = datetime.now().strftime("%Y-%m-%d")
file_path = "/Users/jpinkham/Desktop/water_usage.%s.png" % (datetime_format)

# create webdriver object
# Downloaded geckodriver from https://github.com/mozilla/geckodriver/releases
#driver = webdriver.Firefox("/Users/jpinkham/geckodriver")
driver = webdriver.Firefox()
#TODO: add try/except
driver.get("https://lwconnect.org")
username_field = driver.find_element_by_id('username-email')
password_field = driver.find_element_by_id('password')
##print("Logging in with username >",config['default']['username'], "<")

#TODO: add try/except
username_field.send_keys(config['default']['username'])
password_field.send_keys(config['default']['password'])

#TODO: add try/except
login_button = driver.find_element_by_xpath(config['find_elements']['login_button'])
login_button.click()

#TODO: add try/except.  Code will quit here if it can't find this element, leaving browser open
#TODO: parse page to grab gallons of water used
##view_chart_link = driver.find_element_by_link_text('View Usage')
##view_chart_link.click()


# pause for a few seconds before taking screenshot, to give dashboard time to load
time.sleep(15)
driver.save_screenshot(file_path)
##print("Screenshot saved to >%s<" % file_path)

# Grab raw usage number and "as-of" date
usage_number = driver.find_element_by_xpath('//*[@id="layout-wrapper"]/div[2]/div[1]/section[2]/div/div/div[2]/div[3]/div/div[1]/h3').text
usage_date = driver.find_element_by_xpath('//*[@id="layout-wrapper"]/div[2]/div[1]/section[2]/div/div/div[2]/div[3]/div/div[1]/div/span[2]').text

my_usage = "%s|%s" % (usage_number,usage_date)
with open("data.txt", "a") as data_file:
    data_file.write("%s\n" % my_usage)
##print("Stored usage data in data.txt")

#Log out
driver.get('https://lwconnect.org/Users/Account/LogOff')

driver.close()
