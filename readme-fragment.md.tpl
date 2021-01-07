## Service description

{{if has . "metadata" -}}
{{- if has .metadata "longDescription" -}}
    {{ .metadata.longDescription }}
{{- end}}

{{if has .metadata "imageUrl" -}}
    ![imageUrl]({{.metadata.imageUrl}})
{{- end}}

{{if has .metadata "providerDisplayName" -}}
    * Provided by: {{ .metadata.providerDisplayName -}}
{{end}}
{{if has .metadata "documentationUrl" -}}
    * [Additional documentation]({{ .metadata.documentationUrl }})
{{- end}}
{{if has .metadata "supportUrl" -}}
    * [Support]({{ .metadata.supportUrl }})
{{- end}}
{{- end}}

## Service plans

Name |  Description | Cost | Additional information | Latest version
-- | -- | -- | -- | --
{{- range .plans }}
{{.name}} | {{.description}} |
{{- if coll.Has . "metadata" -}}
    {{- if coll.Has .metadata "costs" -}}
        {{- if (test.IsKind "slice" .metadata.costs)  -}}
            {{- range .metadata.costs}}
                {{- .unit }}: {{ range $amountKey, $amountValue := .amount -}}
                    {{ $amountValue }} {{ $amountKey -}}
                {{ end -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
{{end}} |
{{- if coll.Has . "metadata" -}}
    {{- if coll.Has .metadata "bullets" -}}
        {{- range .metadata.bullets}}
            {{- . -}}</br>
        {{- end}}
    {{- end}}
{{- end}} |
{{- if .maintenance_info -}}
    v{{ .maintenance_info.version}}</br>{{ .maintenance_info.description}}
{{- end}}
{{- end}}