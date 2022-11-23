#!/bin/bash

az login --service-principal --username $AZURE_SP_USERNAME --password $AZURE_SP_PASSWORD --tenant $AZURE_TENANT
az aks get-credentials -g $AZURE_RESOURCE_GROUP -n $AZURE_CLUSTER --admin
kubectl port-forward -n builder service/builder 8080:80 & curl --retry 100 --retry-delay 1 --retry-connrefused 'http://localhost:8080/job' --data-raw "https://bitbucket.org/$BITBUCKET_REPO_FULL_NAME $BITBUCKET_BRANCH $BITBUCKET_BUILD_NUMBER $*"
