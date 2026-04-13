{{/*
  Wraps genericContainersTableCard: init container specs from Pod template
  (.spec.template.spec.initContainers); same apiGroup-aware k8sResourceToFetch as template
  containers.
*/}}
{{- define "in-cloud.web.contentCard.template.initContainersList" -}}
# Content card with PodTemplate init containers spec
{{ include "in-cloud.web.contentCard.genericContainersTableCard" (dict
    "cardId" "init-containers-card"
    "title" "Init Containers"
    "titleRowId" "init-containers-card-title"
    "iconId" "init-containers-info-icon"
    "titleTextId" "init-containers-title-text"
    "tableId" "init-containers-table"
    "customizationId" "container-spec-init-containers-list"
    "pathToItems" ".items.0.spec.template.spec.initContainers"
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
