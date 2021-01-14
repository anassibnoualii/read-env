#!/bin/bash

environment="dev"
# Recreate config file
rm -rf ./env-config.js
touch ./env-config.js

echo "window.env = {" >> ./env-config.js
jq -r ".$environment | .[]" .env  | while read item; do
    key=$(printf '%s\n' "$item" | sed -e 's/=.*//')
    value=$(printf '%s\n' "$item" | sed -e 's/^[^=]*=//')
    value=$(printf '%s\n' "${!key}")
    echo "$key: \"$value\"," >> ./env-config.js
done
echo "}" >> ./env-config.js