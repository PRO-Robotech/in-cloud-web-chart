{{/*
  Custom column: plain text cell; `parsedText` renders `.value` as the displayed string (no extra
  formatter).
*/}}
{{- define "in-cloud.web.columns.factory.text" -}}
customProps:
  disableEventBubbling: true
  items:
    # literal column text
    - type: parsedText
      data:
        id: value-text
        text: {{ .value | quote }}
{{- end -}}