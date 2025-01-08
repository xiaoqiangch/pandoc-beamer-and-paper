#!/bin/sh
. shunit2

testExampleFunction() {
    result=$(exampleFunction "input")
    assertEquals "expectedOutput" "$result"
}

. ./example-script.sh

# Run shUnit2
. shunit2