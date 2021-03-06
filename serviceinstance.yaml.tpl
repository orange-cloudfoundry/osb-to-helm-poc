apiVersion: servicecatalog.k8s.io/v1beta1
kind: ServiceInstance
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ include "p-mysql.fullname" . }}
  labels:
    {{- include "p-mysql.labels" . | nindent 4 }}
spec:

  #Let svcat reference service class and service plans from external names (i.e. OSB names)
  #See https://github.com/kubernetes-sigs/service-catalog/blob/a204c0d26c60b42121aa608c39a179680e499d2a/contrib/examples/walkthrough/mini-instance.yaml#L1-L11
  clusterServiceClassExternalName: "p-mysql"
  clusterServicePlanExternalName: {{ .Values.servicePlanName }}


  # TODO: use lookup function to lookup ClusterServiceClass by service offering name and validate it
  # https://helm.sh/docs/chart_template_guide/functions_and_pipelines/#using-the-lookup-function


  # get all service classes
  # kubectl get serviceclasses.servicecatalog.k8s.io -n catalog
{{/*  ( lookup "v1" "Pod" "mynamespace" ""   )*/}}

{{/*  {{ range $index, $service := (lookup "v1" "Service" "mynamespace" "").items }}*/}}
{{/*  */}}{{/* do something with each service */}}
{{/*  {{ end }}*/}}

  # Q: can helm produce logs ?
{{/*  {{- $allServiceClasses := (lookup "v1" "Pod" "mynamespace" "") -}}*/}}

  parameters:
    # This is designed as a poor man tracing facility inside helm chart template without size restrictions
    debuggingField:
      akey: "a value"

      mockedServiceClasses:
        # dash asks white space to be chomped
        # See https://helm.sh/docs/chart_template_guide/control_structures/
        # See map to yaml formatting at https://stackoverflow.com/a/58986455/1484823
        # Note: indenting 6 in order to align from mockedServiceClasses above
        {{ .Values.mockedServiceClasses | toYaml | nindent 8 }}


{{/*  externalServiceClassName: {{ .Values.servicePlanName }}*/}}


{{/*  clusterServiceClassName: 22450290-aa7f-4349-9100-92803ce9b3b3*/}}
  # TODO: use lookup function to lookup ClusterServicePlan  by service plan name
{{/*  clusterServicePlanName: e1642275-3038-40de-99c1-e4aeb2dcb619*/}}




