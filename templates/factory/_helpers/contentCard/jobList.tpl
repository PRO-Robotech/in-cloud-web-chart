{{- define "in-cloud.web.contentCard.jobList" -}}
# Content card with Jobs list linked to current resource
{{ include "in-cloud.web.contentCard.genericResourceListCard" (dict
    "cardId" "job-list-card"
    "tableId" "jobs-table"
    "customizationId" "factory-/batch/v1/jobs"
    "apiGroup" "batch"
    "apiVersion" "v1"
    "plural" "jobs"
    "ifNamespaced" (index . "ifNamespaced")
    "labelSelectorFull" (index . "labelSelectorFull")
    "fieldSelector" (index . "fieldSelector")
  )
}}
{{- end -}}
