{{ $servicedefinition:=(datasource "servicedefinition") -}}
{{ $defaultPlan:= index $servicedefinition.plans 0 -}}
{{ $defaultPlanName:= $defaultPlan.name -}}{
  "$schema": "https://json-schema.org/draft-07/schema#",
  "properties": {
    "servicePlanName": {
      "description": "See README for full details.",
      "type": "string",
      "enum":
        {{- /*
          To be able to leverage the data.ToJson function to format the list of plans,
          we first need to construct an intermediate array (slice) and append the plan name to it.
          */ -}}
        {{- $plansSlice:= slice }}
        {{- range $servicedefinition.plans }}
          {{- $plansSlice = $plansSlice | coll.Append .name }}
        {{- end }}
        {{- $plansSlice | data.ToJSON}}
    }
  },
  "required": [
    "servicePlanName"
  ],
  "title": "Values",
  "type": "object"
}