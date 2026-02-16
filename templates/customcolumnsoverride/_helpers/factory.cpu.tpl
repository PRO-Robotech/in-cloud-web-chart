{{- define "in-cloud.web.columns.factory.cpu" -}}
customProps:
  disableEventBubbling: true
  items:
    - type: ConverterCores
      data:
        coresValue: {{ .value | quote }}
        format: true
        precision: 4
        unit: true
        notANumberText: "-"
{{- end -}}