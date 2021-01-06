#!/bin/bash


set -e
CHART_NAME=$1

echo "generating serviceinstance.yaml with chart name=$CHART_NAME"

sed "s/p-mysql/${CHART_NAME}/g" < serviceinstance.yaml.tpl  | tee mysql-charts/p-mysql/templates/serviceinstance.yaml
