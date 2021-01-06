{{ $servicedefinition:=(datasource "servicedefinition") }}
# {{ $servicedefinition.name }}

{{ $servicedefinition.description }}

## Introduction

This chart deploys an instance of the following managed service using service catalog. Optionally choose to also instanciate service binding

## Service description

 {{ $servicedefinition.metadata.longDescription }}

![imageUrl]({{$servicedefinition.metadata.imageUrl}})

  * Provided by: {{ $servicedefinition.metadata.providerDisplayName }}
  * [Additional documentation]({{ $servicedefinition.metadata.documentationUrl }})
  * [Support]({{ $servicedefinition.metadata.supportUrl }})

## Service plans

Name |  Description | Cost | Additional information | Latest version
-- | -- | -- | -- | --
{{- range $servicedefinition.plans }}
{{.name}} | {{.description}} |
{{- range .metadata.costs}}
    {{- .unit }}: {{ range $amountKey, $amountValue := .amount -}}
        {{ $amountValue }} {{ $amountKey -}}
    {{ end -}}
{{end}} |
{{- range .metadata.bullets}}
    {{- . -}}</br>
{{- end}} |
{{- if .maintenance_info -}}
    v{{ .maintenance_info.version}}</br>{{ .maintenance_info.description}}
{{- end}}
{{- end}}