#!/bin/bash

export NVM_DIR="$HOME/.nvm"

node_versions=("$NVM_DIR"/versions/node/*)
defaultVersion=$(<"$NVM_DIR/alias/default")

# Remove all old entries in the path variable
PATH=`echo $PATH | sed -e 's#\/home\/gitpod\/.nvm\/versions\/node\/v[0-9.]*\/bin[:]*##g'`

# Check if we have a default version set
if [ ! -z "$defaultVersion" ]; then
	# Make sure the default version starts with v, otherwise it will not work
	if [[ ! "$defaultVersion" == "v"* ]]; then
		defaultVersion="v$defaultVersion"
	fi

    PATH="$PATH:$NVM_DIR/versions/node/$defaultVersion/bin"
# otherwise use the first version that has been installed
elif (("${#node_versions[@]}" > 0)); then
    PATH="$PATH:${node_versions[$((${#node_versions[@]} - 1))]}/bin"
fi

if [ -s "$NVM_DIR/nvm.sh" ]; then
	# load the real nvm on first use
	nvm() {
		# shellcheck disable=SC1090,SC1091
		source "$NVM_DIR"/nvm.sh
		nvm "$@"
	}
fi

if [ -s "$NVM_DIR/bash_completion" ]; then
	# shellcheck disable=SC1090,SC1091
	source "$NVM_DIR"/bash_completion
fi