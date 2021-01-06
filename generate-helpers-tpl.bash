#!/bin/bash

CHART_NAME=$1

echo "generatting _helpers.tpl with chart name=$CHART_NAME"
set -e

#Note: template extracted from https://github.com/helm/helm/blob/f228a7c36c2b1c33f43a6660e01038cd8e010996/pkg/chartutil/create.go#L403-L482
#Make sure to not modify the formatting when doing copy/paste using the IDE (e.g. intellij may automatically reformat on paste)
sed "s/<CHARTNAME>/${CHART_NAME}/g" < _helpers.tpl.tpl  | tee mysql-charts/p-mysql/templates/_helpers.tpl



