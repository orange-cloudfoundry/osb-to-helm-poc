#!/bin/bash
set -e

CATALOG_FILE=$1
DEST_CHART_DIR=$2

echo "generating README.md with CATALOG_FILE=$CATALOG_FILE into DEST_CHART_DIR=${DEST_CHART_DIR}"

# ./gomplate --help
./gomplate -d servicedefinition=${CATALOG_FILE} --file ./readme.md.tpl --template readme-fragment=./readme-fragment.md.tpl > ${DEST_CHART_DIR}/README.md
