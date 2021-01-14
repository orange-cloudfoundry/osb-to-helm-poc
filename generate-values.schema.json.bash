#!/bin/bash

set -e

if [[ "$#" -lt 2 ]];then
  echo "Usage: `basename "$0"` SERVICE_DEFINITION_FILE DEST_CHART_DIR"
  exit 1
fi
SERVICE_DEFINITION_FILE=$1
DEST_CHART_DIR=$2

echo "generating values.schema.json with SERVICE_DEFINITION_FILE=$SERVICE_DEFINITION_FILE into DEST_CHART_DIR=${DEST_CHART_DIR}"


# ./gomplate --help
./gomplate -d servicedefinition=${SERVICE_DEFINITION_FILE} --file ./values.schema.json.tpl | tee ${DEST_CHART_DIR}/values.schema.json
