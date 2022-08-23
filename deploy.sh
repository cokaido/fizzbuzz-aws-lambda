#!/bin/sh
#

# ENV=$1
# APP_NAME=$2#
 ENV=training
 APP_NAME=fizzbuzz

./deploy-terraform.sh $ENV $APP_NAME
