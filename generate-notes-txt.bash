#!/bin/bash
set -e

if [[ "$#" -ne 2 ]];then
  echo "Usage: `basename "$0"` SERVICE_NAME DEST_CHART_DIR"
  exit 1
fi
SERVICE_NAME=$1
DEST_CHART_DIR=$2
echo "generating NOTES.txt with chart name=$SERVICE_NAME into DEST_CHART_DIR=${DEST_CHART_DIR}"
set -e

sed "s/p-mysql/${SERVICE_NAME}/g" < NOTES.txt.tpl  > ${DEST_CHART_DIR}/templates/NOTES.txt



