{{/*
  Returns whether a CustomColumnsOverride entry is enabled from values: pass .config
  (e.g. customWebResources.customcolumnsoverride.<key>). Booleans and { enabled: bool } are supported; default true.
*/}}
{{- define "in-cloud.web.cco.isEnabled" -}}
{{- $config := .config -}}
{{- if kindIs "bool" $config -}}
{{- ternary "true" "false" $config -}}
{{- else if kindIs "map" $config -}}
{{- if hasKey $config "enabled" -}}
{{- ternary "true" "false" (index $config "enabled") -}}
{{- else -}}
true
{{- end -}}
{{- else -}}
true
{{- end -}}
{{- end -}}
