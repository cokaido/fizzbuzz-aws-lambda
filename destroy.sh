#!/bin/sh
# 

 ENV=training
 APP_NAME=fizzbuzz
#  zip -j ./dist/function.zip ./src/index.js

./destroy-terraform.sh $ENV $APP_NAME 
