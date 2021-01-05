#!/bin/bash

set -e
# ./gomplate --help
./gomplate -d servicedefinition=./sample-p-mysql-catalog.json --file ./chart.yml.tpl | tee mysql-charts/p-mysql/Chart.yaml
