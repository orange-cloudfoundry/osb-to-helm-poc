#!/bin/bash
set -e

SERVICE_DEFINITION_FILE=$1
DEST_CHART_DIR=$2

echo "generating values.yml with SERVICE_DEFINITION_FILE=$SERVICE_DEFINITION_FILE into DEST_CHART_DIR=${DEST_CHART_DIR}"

# ./gomplate --help
./gomplate -d servicedefinition=${SERVICE_DEFINITION_FILE} --file ./values.yaml.tpl > ${DEST_CHART_DIR}/values.yaml

