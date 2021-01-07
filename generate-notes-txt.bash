#!/bin/bash
set -e

CHART_NAME=$1
DEST_CHART_DIR=$2
echo "generating NOTES.txt with chart name=$CHART_NAME into DEST_CHART_DIR=${DEST_CHART_DIR}"
set -e

sed "s/p-mysql/${CHART_NAME}/g" < NOTES.txt.tpl  > ${DEST_CHART_DIR}/templates/NOTES.txt



