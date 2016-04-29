#!/bin/bash
TOKEN='BAhJIiUxN2IxYTY5Njk4NTU1YTlkZmVkNTU2NTdhZWJlMTlkZgY6BkVG--6e5311679396aa3d08c835c469a17252bee12a60' 
curl --include --request DELETE http://localhost:3000/sign-out/$ID \
  --header "Authorization: Token token=$TOKEN"
