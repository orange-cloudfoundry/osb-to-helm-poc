#!/bin/bash
set -e

CATALOG_FILE=$1
DEST_CHART_DIR=$2

# ./gomplate --help
./gomplate -d servicedefinition=${CATALOG_FILE} --file ./readme.md.tpl --template readme-fragment=./readme-fragment.md.tpl > ${DEST_CHART_DIR}/README.md
