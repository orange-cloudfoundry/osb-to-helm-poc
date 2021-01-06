#!/bin/bash

CHART_NAME=$1

echo "generating NOTES.txt with chart name=$CHART_NAME"
set -e

sed "s/p-mysql/${CHART_NAME}/g" < NOTES.txt.tpl  | tee mysql-charts/p-mysql/templates/NOTES.txt



