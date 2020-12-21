#!/bin/bash

set -e


# Display the rendered helm chart
# $1: path to helm chart directory
# $2: values yaml files (space separated)
function renderHelmChart () {
  local pathToChart="$1"
  local values="$2"

  # TODO: test whether helm/kubectl is properly configured with a remote server
  # otherwise fails with:
  # Error: Kubernetes cluster unreachable: the server has asked for the client to provide credentials
  # helm.go:81: [debug] the server has asked for the client to provide credentials
  # Kubernetes cluster unreachable
  #helm install my-render-test --values $values --dry-run --debug $pathToChart
}

# Display test failure diagnostics
# $1: path to helm chart directory
# $2: values yaml files (space separated)
# $3: policy
function displayTestFailures () {
  local pathToChart="$1"
  local values="$2"
  local policy="$3"
  printf "\nReproduce locally with cmd:\n cd $PWD; helm unit eval -t templates/ -c values.yaml ${values} -p ${policy}\n"

  renderHelmChart "$pathToChart" "$values" "$policy"
}

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
    helm unit eval -t templates/ -c values.yaml ${VALUES_ARG} -p ${POLICY} || displayTestFailures $PWD $VALUES $POLICY
#    set +x
  done;
done
