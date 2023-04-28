#!/usr/bin/env bash

# Infos for GitpodTool
#
# gptBranch: shopware
# gptBranchDescription: Commands for shopware
# gptCommand: update_domain
# gptDescription: Updates the domain of the sales channel to the actual domain of gitpod as these might change after a restart
./bin/console sales-channel:update:domain $(gp url 8080 | awk -F[/:] '{print $4}')