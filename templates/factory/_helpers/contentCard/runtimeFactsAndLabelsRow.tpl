{{- define "in-cloud.web.contentCard.runtimeFactsAndLabelsRow" -}}
# Reusable row with runtime facts (left) and selectors/labels (right).
# Expected params:
# - runtimeTemplate (required)
# - runtimeContext (optional)
# - labelsTemplate (optional, default: podRuntimeLabels)
# - labelsContext (optional)
# - runtimeSpan / labelsSpan (optional, default: 8 / 6)
# - withResponsive (optional, default: true)
{{- $runtimeTemplate := required "runtimeFactsAndLabelsRow: runtimeTemplate is required" .runtimeTemplate }}
{{- $labelsTemplate := default "in-cloud.web.contentCard.podRuntimeLabels" .labelsTemplate }}
{{- $runtimeSpan := int (default 8 .runtimeSpan) }}
{{- $labelsSpan := int (default 6 .labelsSpan) }}
{{- $runtimeContext := default (dict) .runtimeContext }}
{{- $labelsContext := default (dict) .labelsContext }}
{{- $withResponsive := true }}
{{- if hasKey . "withResponsive" }}
{{- $withResponsive = .withResponsive }}
{{- end }}
# AntD grid layout: runtime facts column + selectors/labels column.
- type: antdRow
  data:
    gutter: [24, 0]
  children:
    - type: antdCol
      data:
        span: {{ $runtimeSpan }}
        {{- if $withResponsive }}
        xs: 24
        xl: {{ $runtimeSpan }}
        {{- end }}
      children:
        {{ include $runtimeTemplate $runtimeContext | nindent 8 }}

    - type: antdCol
      data:
        span: {{ $labelsSpan }}
        {{- if $withResponsive }}
        xs: 24
        xl: {{ $labelsSpan }}
        {{- end }}
      children:
        {{ include $labelsTemplate $labelsContext | nindent 8 }}
{{- end -}}
