#!/bin/bash

echo "Validating if we have a correct OpenAPI"
inso lint spec petstore-with-keyauth.yaml

echo "Executing all tests"
echo "NOTE: you must have cloned the Insomnia repo at this stage"
inso run test "Example test suite" --env "Petstore live at petstore.swagger.io"

echo "Generating Kong decK YAML from OpenAPI"
inso generate config ./petstore-with-keyauth.yaml -o petstore-deck-import.yaml

echo "Importing the generated YAML into Kong"
deck sync -s petstore-deck-import.yaml --select-tag inso-generated
