# Shopware 6 workspace template for gitpod.io

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/derroylo/shopware-workspace-sample)

## What is Gitpod?
Gitpod is a cloud development environment: https://www.gitpod.io/

## Documentation
- Gitpod https://www.gitpod.io/docs/introduction/getting-started
- Dockerfile https://github.com/gitpod-io/workspace-images/blob/main/chunks/tool-nginx/Dockerfile
- gitpod.yml https://www.gitpod.io/docs/references/gitpod-yml

## Informations
Change the active version for PHP: https://github.com/oerdnj/deb.sury.org/wiki/Managing-Multiple-Versions
(When you select not the newest version of PHP then you might need to install additional packages like curl, zip etc. as shown in the installation script `.devEnv/gitpod/scripts/install_shopware_demo.sh`

Available Services:
- MySQL (Database)
- Mailhog (Testing of mail delivery)
- Redis (Cache - Key-Value In-Memory Database)
- PhpMyAdmin (Administrationinterface for MySQL)
- PhpCacheAdmin (Administrationinterface for Redis)

Within the docker-compose.yml you can find these services, configure them or also add new ones.

The often used phpinfo()(which shows the current PHP-Version, which modules are installed and how they are configured) can be accessed once you start the workspace and add `/phpinfo` to the webserver url (`https://8000-xxxxx.ws-xx.gitpod.io/`)

The installation of shopware will be done via an install script that can be found under `.devEnv/gitpod/scripts/install_shopware_demo.sh`

## Important notice

During the installation process you will get asked for the database connection. Enter `localhost:3306` as host and leave the port field empty. The user for the database is `root` and the password is `gitpod`