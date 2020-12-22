#!/bin/bash

set -e

# Display the rendered helm chart
# $1: path to helm chart directory
# $2: policy
# $3: values yaml files (array)

function renderHelmChart () {
  local pathToChart="$1"; shift
  local policy="$1"; shift
  local values=( $@ )


  # Note: this works when helm/kubectl is properly configured with a remote server
  # otherwise fails with:
  # Error: Kubernetes cluster unreachable: the server has asked for the client to provide credentials
  # helm.go:81: [debug] the server has asked for the client to provide credentials
  # Kubernetes cluster unreachable
  echo "From an environment with access to a kube server, you may render the failed chart with command:"
  #See https://github.com/koalaman/shellcheck/wiki/SC2145 about ${values[*]} instead of ${values[@]}
  local values_arg
  values_arg=$(printf ' --values %s' "${values[@]}")
  echo "helm install my-render-test $pathToChart ${values_arg} --dry-run --debug "

  # Native hcunit_unix current rendering fails because it lacks supports for template helpers
  # See https://github.com/xchapter7x/hcunit/issues/28
  # local values_absolute_path=$(printf "${PWD}/%s " "${values[@]}")
  # echo "helm unit render -t  $pathToChart/templates/ -c ${values_absolute_path}"
  # local helm_plugins=$(helm env| grep PLUGIN | cut -d'"' -f2)
  # set -x
  # ${helm_plugins}/hcunit_plugin/hcunit_unix render -t  $pathToChart/templates/*.yaml $pathToChart/templates/*.tpl -c  ${values_absolute_path}
}

# Display test failure diagnostics
# $1: path to helm chart directory
# $2: policy
# $3: values yaml files (array)
function displayTestFailures () {
  local pathToChart="$1"; shift
  local policy="$1"; shift
  local values=( $@ )
  local flattened_values="${values[*]}"
  printf "\nReproduce locally with cmd:\n cd $PWD; helm unit eval -t templates/ -c values.yaml ${flattened_values} -p ${policy}\n"

  renderHelmChart "$pathToChart" "$policy" "${values[@]}"

  exit 1
}

cd p-mysql || exit
TEST_SUITES=$(find ./unit-tests -mindepth 1 -maxdepth 1 -type d )
# shellcheck disable=SC2128
for TEST_SUITE in ${TEST_SUITES}; do
  VALUES=( ${TEST_SUITE}/user-inputs/* )
  VALUES_ARG=""

  #VALUES is a bash array. ${VALUES[@]} to iterate over it, cf https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash
  # shellcheck disable=SC2068
  for VALUE_FILE in ${VALUES[@]}; do
    VALUES_ARG="${VALUES_ARG} -c ${VALUE_FILE}"
  done

  POLICIES=( ${TEST_SUITE}/policy/*.rego )
  printf "\n----------------\nTest suite %s with user inputs:" "$TEST_SUITE"
  # VALUES is a bash array. To print it with printf, the format applies to each element of the array
  # See https://stackoverflow.com/questions/26304266/bash-printf-array-with-field-separator-and-newline-on-last-entry
  printf " %s " "${VALUES[@]}"
  printf "\n"
  # shellcheck disable=SC2068
  for POLICY in ${POLICIES[@]}; do
    if [[ $POLICY =~ should_fail_to_render ]]; then
      printf "\nChecking expected rendering failure in $POLICY\n"
      helm unit eval --debug -t templates/ -c values.yaml ${VALUES_ARG} -p ${POLICY} --namespace default && displayTestFailures $PWD $POLICY "${VALUES[@]}"
      printf "Ok rendering was rejected as expected\n"
    else
#     set -x
      printf "\nChecking test $POLICY\n"
      helm unit eval --debug -t templates/ -c values.yaml ${VALUES_ARG} -p ${POLICY} --namespace default || displayTestFailures $PWD $POLICY "${VALUES[@]}"
#     set +x
    fi
  done;
done
