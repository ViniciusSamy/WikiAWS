#!/bin/bash


# Runs on Ubuntu 22.04

# Install dependencies
apt-get update
apt-get install -y nodejs wget 

# Creating path to wikijs
WIKI_PATH="/opt/wikijs"
mkdir $WIKI_PATH
cd $WIKI_PATH

# Download ans extract the latest version of Wiki.js
wget https://github.com/Requarks/wiki/releases/latest/download/wiki-js.tar.gz
tar xzf wiki-js.tar.gz -C $WIKI_PATH


# Creating linux user for WikiJS and setting permissions
adduser --disabled-password --gecos "" wikijs
chown -R wikijs:wikijs $WIKI_PATH
chmod 700 $WIKI_PATH


# Configuring wiki

cp config.sample.yml config.yml

WIKI_PORT="${wiki_port}"
DB_HOST="${db_host}"
DB_USER="${db_user}"
DB_PASS="${db_pass}"
DB_PORT="${db_port}"
DB_NAME="${db_name}"

sed -i "s/port: 3000/port: $WIKI_PORT/g"  config.yml
sed -i "s/host: localhost/host: $DB_HOST/g" config.yml
sed -i "s/db: wiki/db: $DB_NAME/g" config.yml
sed -i "s/user: wikijs/user: $DB_USER/g" config.yml
sed -i "s/pass: wikijsrocks/pass: $DB_PASS/g" config.yml


#Starting the Wiki
node server