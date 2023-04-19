#!/usr/bin/env bash

# download and unzip the installer
wget https://releases.shopware.com/sw6/install_v6.4.18.0_e21804c46503240c951ead31057152724aea068e.zip
unzip -o install_v6.4.18.0_e21804c46503240c951ead31057152724aea068e.zip
rm install_v6.4.18.0_e21804c46503240c951ead31057152724aea068e.zip

# Add the trusted proxies to the environment, otherwise shopware will link files like images, css etc. only via http which will not work since the page is called via https
echo "TRUSTED_PROXIES=127.0.0.1,REMOTE_ADDR" > .env