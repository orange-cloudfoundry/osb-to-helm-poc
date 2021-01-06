{{ $servicedefinition:=(datasource "servicedefinition") -}}
{{ $defaultPlan:= index $servicedefinition.plans 0 -}}
{{ $defaultPlanName:= $defaultPlan.name -}}
categories:
{{- range $servicedefinition.tags }}
  - {{.}}
{{ end -}}
labels:
#  io.rancher.certified: partner
  io.cattle.role: project # options are cluster/project
questions:
  - variable: servicePlanName
    default: "{{ $defaultPlanName }}"
    description: "See README for full details of service plans"
    type: enum
    required: true
    options:
{{- range $servicedefinition.plans }}
      - "{{.name}}"
{{- end }}
    label: "Service plan"
    group: "Service Plan"
    show_if: "true"
