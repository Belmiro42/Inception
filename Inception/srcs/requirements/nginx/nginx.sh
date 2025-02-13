#!/bin/bash

echo "Generating ECC Private Key..."
openssl ecparam -genkey -name prime256v1 -out /etc/ssl/private/ecc_private.key

ls -l /etc/ssl/private/  # Check if the key file exists and has content

nginx -g "daemon off;"
