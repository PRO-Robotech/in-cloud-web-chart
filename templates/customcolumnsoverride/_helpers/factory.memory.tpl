{{- define "in-cloud.web.columns.factory.memory" -}}
customProps:
  disableEventBubbling: true
  items:
    - type: ConverterBytes
      data:
        bytesValue: {{ .value | quote }}
        notANumberText: "-"
{{- end -}}