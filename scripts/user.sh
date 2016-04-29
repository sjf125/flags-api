#!/bin/bash
TOKEN='BAhJIiU0NDc5ZmYwNjE2ZWYzZWM0ODc4MWIyNzU2Zjc4MWI5NQY6BkVG1a5c0871ae7ad716d3e56c266f70c2bee617f72c'
ID='2'
curl --include --request GET http://localhost:3000/users/$ID \
  --header "Authorization: Token token=$TOKEN"
