#!/bin/bash
sed -i 's/"last_boot": ".*"/"last_boot": ""/' /data/config.json 2> /dev/null
python3 -m hassio
