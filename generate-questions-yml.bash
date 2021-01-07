#!/bin/bash

set -e

CATALOG_FILE=$1
DEST_CHART_DIR=$2

# ./gomplate --help
./gomplate -d servicedefinition=${CATALOG_FILE} --file ./questions.yml.tpl > ${DEST_CHART_DIR}/questions.yml
