{{- define "in-cloud.web.contentCard.metadataCounters" -}}
# Metadata counters: label/annotation counts with edit affordances (endpoint + permissionContext).
- type: ContentCard
  data:
    id: metadata-card
    title: Metadata
  style:
    marginBottom: 24px
  children:
    - type: DefaultDiv
      data:
        id: cards-container
        style:
          display: grid
          gridTemplateColumns: repeat(auto-fit, minmax(220px, 1fr))
          columnGap: 16
          rowGap: 10
          marginBottom: 16px
      children:
        {{/* endpoint: BFF proxy URL for PATCH on metadata; permissionContext: RBAC for edit */}}
        {{ include "in-cloud.web.aggregatedCounterCard.labels" (dict
          "endpoint" .endpoint
          "permissionContext" .permissionContext
        ) | nindent 8 }}
        {{ include "in-cloud.web.aggregatedCounterCard.annotations" (dict
          "endpoint" .endpoint
          "permissionContext" .permissionContext
        ) | nindent 8 }}
{{- end -}}

{{- define "in-cloud.web.contentCard.nodeMetadataCounters" -}}
# Node metadata counters: labels, annotations, taints, images (same endpoint/permission pattern).
- type: ContentCard
  data:
    id: metadata-card
    title: Metadata
  style:
    marginBottom: 24px
  children:
    - type: DefaultDiv
      data:
        id: cards-container
        style:
          display: grid
          gridTemplateColumns: repeat(auto-fit, minmax(220px, 1fr))
          columnGap: 16
          rowGap: 10
          marginBottom: 16px
      children:
        {{/* endpoint: BFF proxy URL for PATCH; permissionContext: RBAC for edit */}}
        {{ include "in-cloud.web.aggregatedCounterCard.labels" (dict
          "endpoint" .endpoint
          "permissionContext" .permissionContext
        ) | nindent 8 }}
        {{ include "in-cloud.web.aggregatedCounterCard.annotations" (dict
          "endpoint" .endpoint
          "permissionContext" .permissionContext
        ) | nindent 8 }}
        {{ include "in-cloud.web.aggregatedCounterCard.taints" (dict
          "endpoint" .endpoint
          "permissionContext" .permissionContext
        ) | nindent 8 }}
        {{/*
          fieldSelector / k8sResourceToFetch: resolve Node object for image list; permissionContext:
          RBAC
        */}}
        {{ include "in-cloud.web.aggregatedCounterCard.images" (dict
          "fieldSelector" .fieldSelector
          "k8sResourceToFetch" .k8sResourceToFetch
          "permissionContext" .permissionContext
        ) | nindent 8 }}
{{- end -}}
