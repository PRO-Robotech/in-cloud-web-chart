{{- define "in-cloud.web.columns.factory.text" -}}
customProps:
  disableEventBubbling: true
  items:
    - type: parsedText
      data:
        id: value-text
        text: {{ .value | quote }}
{{- end -}}