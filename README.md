# osb-2-helm-poc

This repo provides automation to offer a OSB (Open Service API) offering as an helm chart. 

This provides a way to leverage off-the-shelf helm chart UIs to deploy an OSB-based marketplace.

## Repository structure

* scripts and templates
* manual-charts-experiments: contains manually crafted helm chart for the p-mysql sample. This includes unit test attemps. See run [./manual-charts-experiments/test.bash](./manual-charts-experiments/test.bash) to run unit tests leveraging the https://github.com/xchapter7x/hcunit unit test framework  
* generated-charts: contains generated chart for sample catalog. This is linted by circle ci build. Also used for non regression (golden master test pattern) when modifying templates.



