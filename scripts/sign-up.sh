#!/bin/bash

curl --include --request POST http://localhost:3000/sign-up \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "abc@123.com",
      "password": "123",
      "password_confirmation": "123"
    }
  }'

curl --include --request POST http://localhost:3000/sign-up \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "dude@bro.com",
      "password": "cool",
      "password_confirmation": "cool"
    }
  }'
