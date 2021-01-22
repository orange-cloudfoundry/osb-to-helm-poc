{{ $servicedefinition:=(datasource "servicedefinition") -}}
{{ $defaultPlan:= index $servicedefinition.plans 0 -}}
{{ $defaultPlanName:= $defaultPlan.name -}}
# Default values for {{ $servicedefinition.name }}.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

servicePlanName: "{{ $defaultPlanName }}"
