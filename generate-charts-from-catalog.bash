#!/bin/bash


set -e
#set -x
if [[ "$#" -lt 1 ]];then
  echo "Usage: `basename "$0"` OSB_CATALOG_FILE"
  exit 1
fi
OSB_CATALOG_FILE=$1

echo "generating chart from osb catalog: $OSB_CATALOG_FILE"

SERVICE_NAMES=$(./gomplate -i '{{ $servicecatalog:=(datasource "servicecatalog") }}{{- range $servicecatalog.services }}{{.name}} {{ end }}' -d servicecatalog=${OSB_CATALOG_FILE} )

# See https://stackoverflow.com/a/1655389/1484823 for heredoc syntax (|| true because read returns non zero exit status by default)
read -r -d '' EXTRACT_CATALOG_TEMPLATE <<-'EOF' || true
    {{- $servicecatalog:=(datasource "servicecatalog") }}
    {{- $serviceIndex:=conv.Atoi (getenv "SERVICE_INDEX") }}
    {{- index $servicecatalog.services $serviceIndex | data.ToJSONPretty "  " }}
EOF

export SERVICE_INDEX=0
for SERVICE_NAME in $SERVICE_NAMES; do
  echo "generating chart for SERVICE_NAME=${SERVICE_NAME} and SERVICE_INDEX=${SERVICE_INDEX}"
  DEST_CHART_DIR="./generated-charts/$SERVICE_NAME/"
  mkdir -p ${DEST_CHART_DIR}/templates

  CATALOG_FILE="./generated-charts/catalog-${SERVICE_NAME}.json"
  ./gomplate -i "${EXTRACT_CATALOG_TEMPLATE}" -d servicecatalog=${OSB_CATALOG_FILE} > ${CATALOG_FILE}
  ls -al ${CATALOG_FILE}

  ./generate-readme.bash ${CATALOG_FILE} ${DEST_CHART_DIR}
  ./generate-chart_yml.bash ${CATALOG_FILE} ${DEST_CHART_DIR}
  ./generate-app-readme.bash ${CATALOG_FILE} ${DEST_CHART_DIR}
  ./generate-questions-yml.bash ${CATALOG_FILE} ${DEST_CHART_DIR}
  ./generate-values-yaml.bash ${CATALOG_FILE} ${DEST_CHART_DIR}
  ./generate-helpers-tpl.bash p-mysql ${DEST_CHART_DIR}
  ./generate-notes-txt.bash p-mysql ${DEST_CHART_DIR}
  ./generate-K8S-templates.bash p-mysql ${DEST_CHART_DIR}

  export SERVICE_INDEX=$((SERVICE_INDEX+1))
done;

