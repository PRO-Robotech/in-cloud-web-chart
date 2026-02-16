{{- define "in-cloud.web.statusText.jobAvailability" -}}
{{- $itemPath := ".items.0" -}}
{{- if hasKey . "itemPath" -}}
{{- $itemPath = .itemPath -}}
{{- end -}}
- type: StatusText
  data:
    id: header-status
    criteriaSuccess: equals
    criteriaError: equals
    strategySuccess: every
    strategyError: every
    successText: Available
    errorText: Unavailable
    fallbackText: Progressing
    valueToCompareSuccess:
      - Complete
    valueToCompareError:
      - Failed
    values:
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.conditions[?(@.type=='Complete' || @.type=='Failed')].type']['-']}"
{{- end -}}
