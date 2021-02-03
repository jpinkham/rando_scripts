#!/usr/bin/env python3
# LWConnect login with selenium
# parse resulting page to grab water usage data

#imports
import configparser
import time
from selenium import webdriver


# read config values
config_file = "/Users/jpinkham/.config/lwconnect.conf"
config = configparser.ConfigParser()
#TODO: add try/except
config.read(config_file)
#print("Logging in with username >", config['default']['username'], "<" )

# create webdriver object
# Downloaded geckodriver from https://github.com/mozilla/geckodriver/releases
#driver = webdriver.Firefox("/Users/jpinkham/geckodriver")
driver = webdriver.Firefox()
#TODO: add try/except
driver.get("https://lwconnect.org")
username_field = driver.find_element_by_id(config['find_elements']['username_field'])
password_field = driver.find_element_by_id(config['find_elements']['password_field'])

#TODO: add try/except
username_field.send_keys(config['default']['username'])
password_field.send_keys(config['default']['password'])

#TODO: add try/except
login_button = driver.find_element_by_xpath(config['find_elements']['login_button'])
login_button.click()

##view_chart_link = driver.find_element_by_link_text('View Usage')
##view_chart_link.click()

#TODO: parse page to grab gallons of water used

# pause for a few seconds before taking screenshot, to give dashboard time to load
time.sleep(10)
#TODO get this working correctly
#datetime_format = '2021-02-03'
driver.save_screenshot('/Users/jpinkham/Desktop/water_usage.2021-02-03.png')

#Log out
driver.get('https://lwconnect.org/Users/Account/LogOff')

driver.close()
