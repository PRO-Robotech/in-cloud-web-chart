{{/*
  StatusText for Node row: Ready vs pressure/unavailable reasons from conditions with status=True.
*/}}
{{- define "in-cloud.web.statusText.nodeAvailability" -}}
- type: StatusText
  data:
    id: node-status

    # criteria* / valueToCompare* / strategy*: rules that classify node condition reasons into
    # Available, Unavailable, or fallback.
    # Match strategy for success conditions
    criteriaSuccess: equals
    strategySuccess: every
    successText: Available
    valueToCompareSuccess: KubeletReady

    # Match strategy for error conditions
    criteriaError: equals
    strategyError: every
    errorText: Unavailable
    valueToCompareError:
      - KernelDeadlock
      - ReadonlyFilesystem
      - NetworkUnavailable
      - MemoryPressure
      - DiskPressure
      - PIDPressure

    # Fallback text when neither success nor error matched
    fallbackText: Progressing

    # values: JSONPath expressions feeding the matcher (here: `reason` from conditions where status
    # is True).
    values:
      - >-
        {reqsJsonPath[0]['{{ .itemPath }}.status.conditions[?(@.status==''True'')].reason']['-']}
{{- end -}}
