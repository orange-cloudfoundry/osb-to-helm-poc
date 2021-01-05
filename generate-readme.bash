#!/bin/bash

set -e
# ./gomplate --help
./gomplate -d servicedefinition=./sample-p-mysql-catalog.json --file ./readme.md.tpl | tee mysql-charts/p-mysql/README.md
