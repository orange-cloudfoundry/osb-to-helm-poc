#!/bin/bash

#TODO: install helm automatically
#TODO: install helm hcunit_plugin automatically, see https://github.com/xchapter7x/hcunit/issues/27#issuecomment-748142886
cd p-mysql || exit
TEST_SUITES=$(find ./unit-tests -mindepth 1 -maxdepth 1 -type d )
# shellcheck disable=SC2128
for TEST_SUITE in $TEST_SUITES; do
  echo "Checking test suite $TEST_SUITE"
  # shellcheck disable=SC2206
  VALUES=( $TEST_SUITE/user-inputs/* )
  VALUES_ARG=""
  for VALUE_FILE in $VALUES; do
    VALUES_ARG="${VALUES_ARG} -c ${VALUE_FILE}"
  done
  helm unit eval -t templates/ -c values.yaml ${VALUES_ARG} -p ${TEST_SUITE}/policy
done
