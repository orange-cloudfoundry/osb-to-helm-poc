#!/bin/bash

set -e

CATALOG_FILE=$1
DEST_CHART_DIR=$2

echo "generating questions.yml with CATALOG_FILE=$CATALOG_FILE into DEST_CHART_DIR=${DEST_CHART_DIR}"


# ./gomplate --help
./gomplate -d servicedefinition=${CATALOG_FILE} --file ./questions.yml.tpl > ${DEST_CHART_DIR}/questions.yml
