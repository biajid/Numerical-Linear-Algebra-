# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import requests


def get_weather(city):
    api_key = "YOUR_API_KEY"
    url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric"

    r = requests.get(url, timeout=10)
    data = r.json()

    print(data)  # debug
    return data


get_weather("New York")
