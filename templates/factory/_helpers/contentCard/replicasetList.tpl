{{/*
  Wraps genericResourceListCard: ReplicaSets (apps/v1/replicasets); forwards ifNamespaced,
  labelSelectorFull, fieldSelector.
*/}}
{{- define "in-cloud.web.contentCard.replicaSetList" -}}
# Content card with ReplicaSets list linked to current resource
{{ include "in-cloud.web.contentCard.genericResourceListCard" (dict
    "cardId" "replicaset-list-card"
    "tableId" "replicasets-table"
    "customizationId" "factory-/apps/v1/replicasets"
    "apiGroup" "apps"
    "apiVersion" "v1"
    "plural" "replicasets"
    "ifNamespaced" (index . "ifNamespaced")
    "labelSelectorFull" (index . "labelSelectorFull")
    "fieldSelector" (index . "fieldSelector")
  )
}}
{{- end -}}
