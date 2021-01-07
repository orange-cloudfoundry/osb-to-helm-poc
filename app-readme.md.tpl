{{- $servicedefinition:=(datasource "servicedefinition") }}
# {{ $servicedefinition.name }}

{{ $servicedefinition.description }}

## Introduction

This chart deploys an instance of the following managed service using service catalog. Optionally choose to also instanciate service binding

{{ template "readme-fragment" $servicedefinition }}