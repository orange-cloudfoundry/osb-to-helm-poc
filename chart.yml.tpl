{{ $servicedefinition:=(datasource "servicedefinition") -}}
apiVersion: v2
name: {{ $servicedefinition.name }}
description: "{{ $servicedefinition.description }}"

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
# Versions are expected to follow Semantic Versioning (https://semver.org/)

# This is the version
version: 1.0.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application. Versions are not expected to
# follow Semantic Versioning. They should reflect the version the application is using.
# The app version is paas-templates, while the build info is the service definition guid
appVersion: 49.0.1-{{ $servicedefinition.id }}


keywords:
{{- range $servicedefinition.tags }}
- {{.}}
{{ end}}
{{ if coll.Has $servicedefinition.metadata "documentationUrl" -}}
home: {{ $servicedefinition.metadata.documentationUrl }}
{{ end}}

#sources:
#  - A list of URLs to source code for this project (optional)
#dependencies: # A list of the chart requirements (optional)
#  - name: The name of the chart (nginx)
#    version: The version of the chart ("1.2.3")
#    repository: The repository URL ("https://example.com/charts") or alias ("@repo-name")
#    condition: (optional) A yaml path that resolves to a boolean, used for enabling/disabling charts (e.g. subchart1.enabled )
#    tags: # (optional)
#      - Tags can be used to group charts for enabling/disabling together
#    enabled: (optional) Enabled bool determines if chart should be loaded
#    import-values: # (optional)
#      - ImportValues holds the mapping of source values to parent key to be imported. Each item can be a string or pair of child/parent sublist items.
#    alias: (optional) Alias to be used for the chart. Useful when you have to add the same chart multiple times
maintainers: # (optional)
#  - name: The maintainers name (required for each maintainer)
#    email: The maintainers email (optional for each maintainer)
#    url: A URL for the maintainer (optional for each maintainer)
{{ if coll.Has $servicedefinition.metadata "providerDisplayName" }}
  - name: "{{ $servicedefinition.metadata.providerDisplayName }}"
  {{- if coll.Has $servicedefinition.metadata "supportUrl" }}
    url: {{ $servicedefinition.metadata.supportUrl }}
  {{- end}}
{{- end}}
#    email: The maintainers email (optional for each maintainer)
{{ if coll.Has $servicedefinition.metadata "imageUrl" -}}
icon: {{ $servicedefinition.metadata.imageUrl }}
{{- end}}
#deprecated: Whether this chart is deprecated (optional, boolean)
annotations:
# See https://helm.readthedocs.io/en/latest/using_labels/
{{- if coll.Has $servicedefinition.metadata "providerDisplayName" }}
  provider: "{{ $servicedefinition.metadata.providerDisplayName }}"
{{- end}}