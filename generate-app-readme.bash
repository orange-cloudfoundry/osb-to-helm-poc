#!/bin/bash

set -e

if [[ "$#" -lt 2 ]];then
  echo "Usage: `basename "$0"` CATALOG_FILE DEST_CHART_DIR"
  exit 1
fi
CATALOG_FILE=$1
DEST_CHART_DIR=$2

echo "generating app-readme.md with CATALOG_FILE=$CATALOG_FILE into DEST_CHART_DIR=${DEST_CHART_DIR}"


# ./gomplate --help
./gomplate -d servicedefinition=${CATALOG_FILE} --file ./app-readme.md.tpl --template readme-fragment=./readme-fragment.md.tpl >  ${DEST_CHART_DIR}/app-readme.md
