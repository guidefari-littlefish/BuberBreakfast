#!/bin/bash

# Define the base URL
BASE_URL="https://localhost:7127"

# Create a new breakfast
echo "Creating a new breakfast..."
CREATE_RESPONSE=$(curl -s -X POST "$BASE_URL/breakfasts" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Vegan Sunshine",
    "description": "Vegan Sunshine",
    "startDateTime": "2022-04-08T08:00:00",
    "endDateTime": "2022-04-08T11:00:00",
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

echo "Create Response:"
echo "$CREATE_RESPONSE" | jq '.'

# Extract the ID from the response (assuming it's returned in the response)
BREAKFAST_ID=$(echo "$CREATE_RESPONSE" | jq -r '.id // empty')

if [ -z "$BREAKFAST_ID" ]; then
  echo "Failed to extract breakfast ID from the response."
  exit 1
fi

# Get the created breakfast
echo -e "\nFetching the created breakfast..."
GET_RESPONSE=$(curl -s -X GET "$BASE_URL/Breakfasts/$BREAKFAST_ID")

echo "Get Response:"
echo "$GET_RESPONSE" | jq '.'