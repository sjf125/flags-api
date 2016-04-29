#!/bin/bash
TOKEN='BAhJIiUzNzk0YzRjNjA0Yzk5YTNlN2YzZTMwZDFjYTYyYWIwMgY6BkVG--5f1f41d38a44d39257be9d01c756b38826529e31'
curl --include --request GET http://localhost:3000/comments \
  --header "Authorization: Token token=$TOKEN"
