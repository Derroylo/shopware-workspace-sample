#!/usr/bin/env bash

# Infos for GitpodTool
#
# gptBranch: shopware
# gptBranchDescription: Commands for shopware
# gptCommand: update_domain
# gptDescription: Updates the domain of the sales channel to the actual domain of gitpod as these might change after a restart
# The following shopware command will not work as it detects the access via http which is a problem specific with gitpod and how it forwards ports
#./bin/console sales-channel:update:domain $(gp url 8080 | awk -F[/:] '{print $4}')

export APP_URL=$(gp url 8080);
echo "UPDATE shopware.sales_channel_domain SET url = '$APP_URL' WHERE url LIKE 'http%';" | mysql -uroot -pgitpod --protocol tcp;