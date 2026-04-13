{{/*
  Wraps genericContainersTableCard: table of .status.initContainerStatuses; same k8sResourceToFetch
  wiring as containers list.
*/}}
{{- define "in-cloud.web.contentCard.initContainersList" -}}
# Content card with Pod init containers status
{{ include "in-cloud.web.contentCard.genericContainersTableCard" (dict
    "cardId" "init-containers-card"
    "title" "Init Containers"
    "titleRowId" "init-containers-card-title"
    "iconId" "init-containers-info-icon"
    "titleTextId" "init-containers-title-text"
    "tableId" "init-containers-table"
    "customizationId" "container-status-init-containers-list"
    "pathToItems" ".items.0.status.initContainerStatuses"
    "k8sResourceToFetch" (dict
      "apiVersion" "{6}"
      "namespace" "{3}"
      "plural" "{7}"
    )
    "nameFieldSelector" "{8}"
  )
}}

{{- end -}}
