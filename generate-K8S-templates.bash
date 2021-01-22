#!/bin/bash
set -e
if [[ "$#" -ne 2 ]];then
  echo "Usage: `basename "$0"` SERVICE_NAME DEST_CHART_DIR"
  exit 1
fi
SERVICE_NAME=$1
DEST_CHART_DIR=$2

echo "generating serviceinstance.yaml with SERVICE_NAME=${SERVICE_NAME} into DEST_CHART_DIR=${DEST_CHART_DIR}"

sed "s/p-mysql/${SERVICE_NAME}/g" < serviceinstance.yaml.tpl  > ${DEST_CHART_DIR}/templates/serviceinstance.yaml
