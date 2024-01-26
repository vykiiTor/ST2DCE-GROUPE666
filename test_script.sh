#!/bin/bash

# Define the base URL of your Go app
BASE_URL=$(<$(dirname "$0")/url.txt)
echo $BASE_URL

# Variable to track the overall test status
TEST_STATUS=0

# Function to test a specific endpoint
test_endpoint() {
    ENDPOINT=$1
    EXPECTED_STATUS=$2
    EXPECTED_OUTPUT=$3

    URL="$BASE_URL$ENDPOINT"

    # Make a GET request to the endpoint
    RESPONSE=$(curl -s -w "\n%{http_code}" "$URL")

    # Extract the response body
    STATUS_CODE=$(echo "$RESPONSE" | tail -n 1)
    BODY=$(echo "$RESPONSE" | sed '$d')

    # Check if the status code matches the expected status code
    if [ "$STATUS_CODE" -eq "$EXPECTED_STATUS" ]; then
        echo "✅ Test Passed: $ENDPOINT returned $EXPECTED_STATUS"
    else
        echo "❌ Test Failed: $ENDPOINT expected $EXPECTED_STATUS but got $STATUS_CODE"
        TEST_STATUS=1 # Set the overall test status to 1 (failure)
    fi

    # Check if the response body matches the expected output
    if [ "$BODY" == "$EXPECTED_OUTPUT" ]; then
        echo "✅ Test Passed: $ENDPOINT returned the expected output"
    else
        echo "❌ Test Failed: $ENDPOINT expected output '$EXPECTED_OUTPUT' but got '$BODY'"
        TEST_STATUS=1 # Set the overall test status to 1 (failure)
    fi
}

# Test each endpoint
test_endpoint "/" 200 "Welcome to the Web API!"
test_endpoint "/aboutme" 200 "A little bit about HUGOD the conqueror"
test_endpoint "/whoami" 200 '[{"Name":"Team 666","Title":"DevOps and Continous Deployment project with the best team","State":"FR"}]'

# Exit with the overall test status
exit $TEST_STATUS
