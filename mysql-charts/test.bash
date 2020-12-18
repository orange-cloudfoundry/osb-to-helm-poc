#!/bin/bash

#TODO: install helm automatically
#TODO: install helm hcunit_plugin automatically, see https://github.com/xchapter7x/hcunit/issues/27#issuecomment-748142886
cd p-mysql
/home/guillaume/.local/share/helm/plugins/hcunit_plugin/hcunit_unix eval -t templates/ -c values.yaml -p policy
