{{- define "in-cloud.web.contentCard.metadataCounters" -}}
# Content card with metadata counters (labels and annotations)
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
# Content card with Node metadata counters (labels, annotations, taints, images)
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
        {{ include "in-cloud.web.aggregatedCounterCard.images" (dict
          "fieldSelector" .fieldSelector
          "k8sResourceToFetch" .k8sResourceToFetch
          "permissionContext" .permissionContext
        ) | nindent 8 }}
{{- end -}}
