{{- define "in-cloud.web.contentCard.containersList" -}}
# Content card with Pod containers status
{{ include "in-cloud.web.contentCard.genericContainersTableCard" (dict
    "cardId" "containers-card"
    "title" "Containers"
    "titleRowId" "containers-card-title"
    "iconId" "containers-info-icon"
    "titleTextId" "containers-title-text"
    "tableId" "containers-table"
    "customizationId" "container-status-containers-list"
    "pathToItems" ".items.0.status.containerStatuses"
    "k8sResourceToFetch" (dict
      "apiVersion" "{6}"
      "namespace" "{3}"
      "plural" "{7}"
    )
    "nameFieldSelector" "{8}"
  )
}}

{{- end -}}
