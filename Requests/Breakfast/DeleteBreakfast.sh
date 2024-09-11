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

response=$(curl -s -X DELETE "https://localhost:7127/breakfasts/$id")

echo "Response:"
echo "$response" | jq '.'

# If jq fails (response is not JSON), print the raw response
if [ $? -ne 0 ]; then
    echo "Raw response:"
    echo "$response"
fi