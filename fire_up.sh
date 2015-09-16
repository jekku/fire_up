#!/bin/bash

#start as root

sudo -i

#Halt all forever processing apps

sudo forever stop all

#Fire Up Live Updater

cd /www/live-updater
forever start server.js

#Fire Up Comments Plugin

cd /www/comments-plugin
forever start cluster.js server.js

#Fire Up Backend Server

cd /www/gamerstm-rewrite
NODE_ENV=production sudo forever start cluster.js server.js

#Refresh all JSX and SASS compilations
npm frontend:compass:compile
npm frontend:webpack:compile

#Fire Up Frontend Server
NODE_APP=frontend NODE_ENV=production sudo forever start cluster.js server.js
