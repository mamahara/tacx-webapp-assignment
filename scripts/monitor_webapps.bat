#/bin/bash
# Monitor an App Service app and healthcheck.
# set -e # exit if error
# Variable block

#login using read only service principal
az login --service-principal -u 2e304757-a16e-4c4f-9c10-250d2bef7384 -p AFF8Q~28rYQ-bhX15M_R2BhBdyzK2dLkUHpt9c60 --tenant 6a6d383e-938c-4fc2-aac6-f53d87444dfa

# get all  webapps created on the subscriptions Plan
az webapp list --query "[].{name: name, hostName: defaultHostName, state: state}"