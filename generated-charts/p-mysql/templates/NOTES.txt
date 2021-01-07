{{ $fullName:=include "p-mysql.fullname" . -}}
{{ $serviceInstance:= ( lookup "servicecatalog.k8s.io/v1beta1" "ServiceInstance" .Release.Namespace  $fullName) -}}

{{- if $serviceInstance }}
You may access the managed service dashboard through:
{{ $serviceInstance.status.dashboardURL }}

ps: you're seeing this because NOTES.txt template was refreshed during last chart update.
{{ else }}
Dashboard url may be accessed through the following command:
   kubectl get ServiceInstance -n {{.Release.Namespace}} {{$fullName}} -o jsonpath='{.status.dashboardURL}'

You may also try to update this helm chart to have this NOTES.txt template refreshed with resource looked up
{{ end }}


