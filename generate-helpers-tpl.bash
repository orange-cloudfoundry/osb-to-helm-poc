#!/bin/bash

if [[ "$#" -ne 2 ]];then
  echo "Usage: `basename "$0"` SERVICE_NAME DEST_CHART_DIR"
  exit 1
fi
SERVICE_NAME=$1
DEST_CHART_DIR=$2
echo "generatting _helpers.tpl with chart name=$SERVICE_NAME into DEST_CHART_DIR=${DEST_CHART_DIR}"
set -e

#Note: template extracted from https://github.com/helm/helm/blob/f228a7c36c2b1c33f43a6660e01038cd8e010996/pkg/chartutil/create.go#L403-L482
#Make sure to not modify the formatting when doing copy/paste using the IDE (e.g. intellij may automatically reformat on paste)
sed "s/<CHARTNAME>/${SERVICE_NAME}/g" < _helpers.tpl.tpl  > ${DEST_CHART_DIR}/templates/_helpers.tpl



