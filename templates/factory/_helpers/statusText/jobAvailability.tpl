{{/* StatusText for Job row: Complete vs Failed vs in-progress from Job condition types. */}}
{{- define "in-cloud.web.statusText.jobAvailability" -}}
{{- $itemPath := ".items.0" -}}
{{- if hasKey . "itemPath" -}}
{{- $itemPath = .itemPath -}}
{{- end -}}
- type: StatusText
  data:
    id: header-status
    # criteria* / valueToCompare* / strategy*: rules comparing collected condition type strings to
    # success/error lists.
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
    # values: JSONPath expressions whose results are matched against the criteria above
    # (Complete/Failed condition types).
    values:
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.conditions[?(@.type=='Complete' || @.type=='Failed')].type']['-']}"
{{- end -}}
