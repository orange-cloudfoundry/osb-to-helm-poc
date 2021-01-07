#!/bin/bash
set -e
CHART_NAME=$1
DEST_CHART_DIR=$2

echo "generating serviceinstance.yaml with chart name=$CHART_NAME into DEST_CHART_DIR=${DEST_CHART_DIR}"

sed "s/p-mysql/${CHART_NAME}/g" < serviceinstance.yaml.tpl  > ${DEST_CHART_DIR}/templates/serviceinstance.yaml
