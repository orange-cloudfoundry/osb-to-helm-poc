{{ $servicedefinition:=(datasource "servicedefinition") -}}
{{ $defaultPlan:= index $servicedefinition.plans 0 -}}
{{ $defaultPlanName:= $defaultPlan.name -}}
# Default values for p-mysql.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

serviceClassName: "{{ $servicedefinition.name }}"
servicePlanName: "{{ $defaultPlanName }}"
