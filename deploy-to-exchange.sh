#!/bin/bash

# This script requires the following:
# Anypoint Platform Organization ID

# Command should be called as follows:
# ./deploy-logger-only.sh some-org-id-value
# 4d719216-50db-44e2-843e-57abe6c12f9d
# run with maven 3.8.4 not 3.9.6
# use special settings.xml from this directory
# and
if [ "$#" -ne 1 ]
then
  echo "[ERROR] You need to provide your OrgId"
  exit 1
fi
echo "Deploying JSON Logger to Exchange"
echo "> OrgId: $1"

# Replacing ORG_ID_TOKEN inside pom.xml with OrgId value provided from command line
echo "Replacing OrgId token..."

echo sed -i.bkp "s/ORG_ID_TOKEN/$1/g" json-logger/pom.xml
sed -i.bkp "s/ORG_ID_TOKEN/$1/g" json-logger/pom.xml
# Deploying to Exchange
echo "Deploying to Exchange..."

echo mvn -X  -f json-logger/pom.xml clean   deploy -Dconnected_app_token=8fac6c3c-7777-4c9c-b18e-b1520ca2a4b0 -X
mvn   -f json-logger/pom.xml clean install   deploy -Dconnected_app_token=8fac6c3c-7777-4c9c-b18e-b1520ca2a4b0


if [ $? != 0 ]
then
  echo "[ERROR] Failed deploying json-logger to Exchange"
  exit 1
fi
