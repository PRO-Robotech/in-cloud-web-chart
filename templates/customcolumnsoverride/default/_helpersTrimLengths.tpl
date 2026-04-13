{{/* CCO max cell text length before truncation: key = column id, value = max character count. */}}
{{- define "incloud-web-resources.cco.columns-trim-lengths.name" -}}
- key: Name
  value: 64
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.namespace" -}}
- key: Namespace
  value: 64
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.labels" -}}
- key: Labels
  value: 1
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.pod-selector" -}}
- key: Pod Selector
  value: 5
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.container-image" -}}
- key: Image
  value: 63
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.node-image-id" -}}
- key: ImageID
  value: 128
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.node-image-size" -}}
- key: Size
  value: 63
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.status-message" -}}
- key: Message
  value: 64
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.rbac-resources" -}}
- key: Resources
  value: 3
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.rbac-resources-name" -}}
- key: Resource Names
  value: 3
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.rbac-verbs" -}}
- key: Verbs
  value: 5
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.rbac-role-ref" -}}
- key: Role ref
  value: 64
{{- end -}}

{{- define "incloud-web-resources.cco.columns-trim-lengths.sa-secrets" -}}
- key: Secrets
  value: 1
{{- end -}}
