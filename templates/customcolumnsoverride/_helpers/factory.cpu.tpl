{{/*
  Custom column: CPU usage. `.value` is the bound numeric cores string; ConverterCores renders
  formatted cores with color-coded load.
*/}}
{{- define "in-cloud.web.columns.factory.cpu" -}}
customProps:
  # clicks do not bubble to the row
  disableEventBubbling: true
  items:
    # formatted cores + usage coloring
    - type: ConverterCores
      data:
        # cores from column binding
        coresValue: {{ .value | quote }}
        format: true
        precision: 4
        unit: true
        notANumberText: "-"
{{- end -}}