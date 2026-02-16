{{- define "in-cloud.web.statusText.nodeAvailability" -}}
- type: StatusText
  data:
    id: node-status

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

    # Values extracted from Node conditions with status=True
    values:
      - >-
        {reqsJsonPath[0]['{{ .itemPath }}.status.conditions[?(@.status==''True'')].reason']['-']}
{{- end -}}
