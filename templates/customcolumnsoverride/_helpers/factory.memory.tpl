{{/*
  Custom column: memory usage. `.value` is the bound bytes string; ConverterBytes renders
  human-readable size with color-coded usage.
*/}}
{{- define "in-cloud.web.columns.factory.memory" -}}
customProps:
  # clicks do not bubble to the row
  disableEventBubbling: true
  items:
    # formatted bytes + usage coloring
    - type: ConverterBytes
      data:
        # bytes from column binding
        bytesValue: {{ .value | quote }}
        notANumberText: "-"
{{- end -}}