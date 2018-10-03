#!/bin/bash

# Some variables

RG_NAME=rg_name
REGION=region
IMAGE_NAME=image_name
DNS_LABEL=dns_label
ACI_NAME=aci_name
PORTS="22 4200"

# Some actions

az group create -n $RG_NAME --location $REGION && \
docker build -t $ACI_NAME . && \
docker tag $ACI_NAME $IMAGE_NAME && \
docker push $IMAGE_NAME && \
az container create \
  -n $ACI_NAME \
  -g $RG_NAME \
  --image $IMAGE_NAME \
  --ip-address public \
  --dns-name-label $DNS_LABEL \
  --ports $PORTS
