{{- define "in-cloud.web.contentCard.template.containersList" -}}
# Content card with PodTemplate containers spec
{{ include "in-cloud.web.contentCard.genericContainersTableCard" (dict
    "cardId" "containers-card"
    "title" "Containers"
    "titleRowId" "containers-card-title"
    "iconId" "containers-info-icon"
    "titleTextId" "containers-title-text"
    "tableId" "containers-table"
    "customizationId" "container-spec-containers-list"
    "pathToItems" ".items.0.spec.template.spec.containers"
    "k8sResourceToFetch" (dict
      "apiGroup" "{6}"
      "apiVersion" "{7}"
      "namespace" "{3}"
      "plural" "{8}"
    )
    "nameFieldSelector" "{9}"
  )
}}

{{- end -}}
