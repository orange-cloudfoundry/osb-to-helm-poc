#!/bin/bash

set -e
# ./gomplate --help
./gomplate -d servicedefinition=./sample-p-mysql-catalog.json --file ./questions.yml.tpl | tee mysql-charts/p-mysql/questions.yml
