{{ $servicedefinition:=(datasource "servicedefinition") }}
# {{ $servicedefinition.name }}

{{ $servicedefinition.description }}

## TL;DR;

```console
$ helm repo add osb2helmRepo https://sample.domain.org/stable/
$ helm repo update
$ helm install my-service osb2helmRepo/{{ $servicedefinition.name }} -n mynamespace --version=v1.0.0
```

## Introduction

This chart deploys an instance of the following managed service using service catalog. Optionally choose to also instanciate service binding

{{ template "readme-fragment" $servicedefinition }}