#!/usr/bin/env python3

# Credit to https://github.com/willHol/polybar-crypto

import configparser
import sys
import requests
from decimal import Decimal
from os.path import expanduser
import json

config = configparser.ConfigParser()

# File must be opened with utf-8 explicitly
with open(
    expanduser("~/.config/polybar/crypto-config"), "r", encoding="utf-8"
) as f:
    config.read_file(f)

# Everything except the general section
currencies = [x for x in config.sections() if x != "general"]
base_currency = config["general"]["base_currency"]
params = {"convert": base_currency}

font_number = 4
lookup = open(expanduser("~/git/dotfiles/lookup.json"), "r")
icon_color = json.load(lookup)["polybar_hl"]

for currency in currencies:
    try:
        icon = f"%{{T{font_number}}}%{{F{icon_color}}}{config[currency]['icon']}%{{F-}}%{{T-}}"
        json = requests.get(
            f"https://api.coingecko.com/api/v3/coins/{currency}"
        ).json()["market_data"]
        local_price = round(
            Decimal(json["current_price"][f"{base_currency.lower()}"]), 2
        )
        change_24 = float(json["price_change_percentage_24h"])

        display_opt = config["general"]["display"]
        if display_opt == "both" or display_opt == None:
            sys.stdout.write(f"{icon} {local_price}/{change_24:+}%")
        elif display_opt == "percentage":
            sys.stdout.write(f"{icon} {change_24:+}%")
        elif display_opt == "price":
            sys.stdout.write(f"{icon} {local_price}")
        if currency != currencies[-1]:
            sys.stdout.write("  ")
    except requests.exceptions.ConnectionError as e:
        sys.stdout.write("not connected")
        break
