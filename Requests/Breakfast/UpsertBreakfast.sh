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

BASE_URL="https://localhost:7127"

echo "Updating breakfast with ID: $id"
response=$(curl -s -X PUT "$BASE_URL/breakfasts/$id" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Vegan Sunshine updated",
    "description": "Mic check one two one two",
    "startDateTime": "2024-05-20T08:00:00",
    "endDateTime": "2024-05-20T11:00:00",
    "savory": [
        "Oatmeal",
        "Avocado Toast",
        "Omelette",
        "Salad"
    ],
    "Sweet": [
        "Cookie"
    ]
}')

echo "Response:"
echo "$response" | jq '.' || echo "$response"