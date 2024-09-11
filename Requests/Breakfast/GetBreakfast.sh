#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please provide an ID as an argument."
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install it to format the JSON response."
    exit 1
fi

id=$1

# Updated curl command
response=$(curl -s -L -k -X GET "https://localhost:7127/breakfasts/$id" \
  -H "Accept: application/json")

echo "Response:"
echo "$response" | jq '.' 2>/dev/null

# If jq fails (response is not JSON), print the raw response
if [ $? -ne 0 ]; then
    echo "Raw response:"
    echo "$response"
fi