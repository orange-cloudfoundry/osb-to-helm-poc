#!/bin/bash

set -e

cd p-mysql || exit
TEST_SUITES=$(find ./unit-tests -mindepth 1 -maxdepth 1 -type d )
# shellcheck disable=SC2128
for TEST_SUITE in $TEST_SUITES; do
  # shellcheck disable=SC2206
  VALUES=( $TEST_SUITE/user-inputs/* )
  VALUES_ARG=""
  for VALUE_FILE in $VALUES; do
    VALUES_ARG="${VALUES_ARG} -c ${VALUE_FILE}"
  done
  POLICIES=( $TEST_SUITE/policy/*.rego )
  printf "\n----------------\nTest suite $TEST_SUITE with user inputs: $VALUES\n"
  for POLICY in $POLICIES; do
  printf "\nChecking test $POLICY\n"
#    set -x
    helm unit eval -t templates/ -c values.yaml ${VALUES_ARG} -p ${POLICY}
#    set +x
  done;
done
