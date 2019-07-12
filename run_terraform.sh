#!/bin/bash

echo "Provisioning infrastructure..."

echo "Finding the public ip address..."
MY_PUBLIC_IP="$(curl -s ipinfo.io/ip)"
echo "... the public ip address is $MY_PUBLIC_IP"

echo "Starting terraform..."
terraform apply -var "my_public_ip=$MY_PUBLIC_IP/32"