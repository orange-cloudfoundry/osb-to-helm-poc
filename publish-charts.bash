#!/bin/bash


set -e
#set -x
if [[ "$#" -ne 4 ]];then
  echo "Usage: `basename "$0"` CHARTS_DIR JCR_URL JCR_LOGIN JCR_PASSWORD"
  exit 1
fi
CHARTS_DIR="$1"
JCR_URL="$2"
JCR_LOGIN="$3"
JCR_PASSWORD="$4"


function install_prereq_plugin {
  if ! helm plugin list | grep push-artifactory ; then
    helm plugin install https://github.com/belitre/helm-push-artifactory-plugin --version v1.0.3
  else
    helm push-artifactory -h | head -n 2
  fi
}
install_prereq_plugin

CHARTS_DIRS=$(find ${CHARTS_DIR} -type d -maxdepth 1 -mindepth 1 )

for CHART_DIR in ${CHARTS_DIRS}; do
  (
    cd ${CHART_DIR};
    CHART_NAME=$(basename ${CHART_DIR})
    echo "publishing helm chart"
    # TODO: extract the version from chart.yml using gomate ?
    CHART_VERSION=1.0.0

    CHART_TARBALL=../${CHART_NAME}-${CHART_VERSION}.tgz
    tar cvfz ${CHART_TARBALL} .
    ls -al ${CHART_TARBALL}

    helm push-artifactory ${CHART_TARBALL} ${JCR_URL} -u ${JCR_LOGIN} -p ${JCR_PASSWORD}

    rm -f ${CHART_TARBALL}
  )
done
