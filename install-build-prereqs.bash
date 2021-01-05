#!/bin/bash

if [[ ! -x ./gomplate ]]; then
  echo "installing generator for helm chart README.md"
  curl -LO https://github.com/hairyhenderson/gomplate/releases/download/v3.8.0/gomplate_linux-amd64
  chmod +x gomplate_linux-amd64
  mv gomplate_linux-amd64 gomplate
  ./gomplate --help
else
  echo "generator for helm chart README.md already installed"
  ./gomplate --help
fi
