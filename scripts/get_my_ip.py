#!/usr/bin/env python3

import json
import urllib.request

def get_ip():
    with urllib.request.urlopen("https://api.ipify.org") as response:
        ip = response.read().decode("utf-8")
        return {"ip": f"{ip}/32"}

if __name__ == "__main__":
    print(json.dumps(get_ip()))


#make sure this file has the proper permissions to execute: "chmod +x scripts/get_my_ip.py"