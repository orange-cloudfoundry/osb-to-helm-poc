#!/bin/bash

# ./gomplate --help
./gomplate -d servicedefinition=./sample-p-mysql-catalog.json --file ./readme.tpl | tee mysql-charts/p-mysql/README.md
