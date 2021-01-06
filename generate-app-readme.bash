#!/bin/bash

set -e
# ./gomplate --help
./gomplate -d servicedefinition=./sample-p-mysql-catalog.json --file ./app-readme.md.tpl | tee mysql-charts/p-mysql/app-readme.md
