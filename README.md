# Shopware 6 workspace template for gitpod.io

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/derroylo/shopware-workspace-sample)

## What is this?
This is an example workspace for [Gitpod](https://www.gitpod.io/) with the eCommerce System [Shopware](https://www.shopware.com) which aims to provide a fully usable workspace for development instead of just a simple sample.

## Getting started
Use the Button "Open in Gitpod" above to start a new workspace based on this repo. The first start will take some time (around 10 to 15 minutes) as he needs to build the Dockerfile, start the services and install Shopware with some demo data. Afterwards you will see your IDE Instance and the Frontend of the Store should open in your Browser. To access the backend just append `/admin` to the url and login with the user `admin` and the password `shopware`.

## Available services
Some additional services are already added via docker-compose.yml but you can add more any time.
- [MySQL](https://www.mysql.com) - Database
- [Mailpit](https://github.com/axllent/mailpit) - email testing tool for developers
- [Redis](https://redis.com) - In-Memory Database used mostly for caching
- [PhpMyAdmin](https://www.phpmyadmin.net/) - Webinterface for MySQL
- [Adminer](https://www.adminer.org) - Webinterface for MySQL
- [PhpCacheAdmin](https://github.com/RobiNN1/phpCacheAdmin) - Webinterface for different caching systems like redis, memcached etc.

**Note:** Not all services are active per default, you can select active services via `gpt services select`

## Installed Tools
- [GPT](https://github.com/Derroylo/gitpod-tool) - An extendable Tool for web development with gitpod
- [NVM](https://github.com/nvm-sh/nvm) - Select the active nodejs version

## Documentation
- [Shopware](https://docs.shopware.com/en)
- [Shopware developer](https://developer.shopware.com)
- [Gitpod](https://www.gitpod.io/docs/introduction/getting-started)
- [Base of the Dockerfile](https://github.com/gitpod-io/workspace-images/blob/main/chunks/tool-nginx/Dockerfile)
- [gitpod.yml](https://www.gitpod.io/docs/references/gitpod-yml)
- [GPT](https://github.com/Derroylo/gitpod-tool) [GPT Documentation](https://derroylo.github.io)

## Informations
- During setup there might be some deprecation message shown. This is normal and can be ignored
- Add `/phpinfo` to the url of the frontend (`https://8000-xxxxx.ws-xx.gitpod.io/`) to show the current used php version, active modules and settings
- Add `/xdebuginfo` to the url of the frontend (`https://8000-xxxxx.ws-xx.gitpod.io/`) to show the current xdebug settings
- Add `/adminer` to the url of the frontend (`https://8000-xxxxx.ws-xx.gitpod.io/`) to open Adminer, an alternative to phpmyadmin
- The installation routine of shopware can be found under `.devEnv/gitpod/scripts/shopware/install_demo.sh`
- To update the domain, which can change after workspace restart, run `gpt shopware update_domain` to set the new domain for the sales channels

## Changelog

### 14.10.2023
- Added adminer as alternative to phpmyadmin
- Added xdebug info shortcut
- Updated .gpt.yml for GPT 0.4.x
- Corrected some problems with choosing nodejs version
- phpmyadmin and phpcacheadmin wouldn´t start sometimes correctly