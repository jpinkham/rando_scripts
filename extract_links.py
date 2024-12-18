import requests
import os

api_key = os.environ["JSONLINK_API_KEY"]
url = $1

params = {'url': url, 'api_key': api_key}
response = requests.get('https://jsonlink.io/api/extract', params=params)

if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print(f'Error: {response.status_code} - {response.text}')
    