{{- define "in-cloud.web.contentCard.resourceInfoAndMetadataRow" -}}
# Reusable row with resource info (left) and metadata counters (right).
# Expected params:
# - namespaced (required)
# - endpoint / permissionContext (required for default metadata template)
# - metadataTemplate (optional, default: metadataCounters)
# - fieldSelector / k8sResourceToFetch (optional, used by custom metadata templates)
# - withResponsive (optional, default: true)
{{- $metadataTemplate := default "in-cloud.web.contentCard.metadataCounters" .metadataTemplate }}
{{- $withResponsive := true }}
{{- $rowVerticalGutter := default 24 .rowVerticalGutter }}
{{- if hasKey . "withResponsive" }}
{{- $withResponsive = .withResponsive }}
{{- end }}
# AntD grid layout: resource info and metadata counters side by side (responsive columns).
- type: antdRow
  data:
    # Keep vertical gap when columns collapse to stacked layout on smaller widths/zoom.
    gutter: [24, {{ $rowVerticalGutter }}]
  children:
    - type: antdCol
      data:
        span: 12
        {{- if $withResponsive }}
        xs: 24
        xl: 12
        {{- end }}
      children:
        {{ include "in-cloud.web.contentCard.resourceInfo" (dict
            "namespaced" .namespaced
          ) | nindent 8
        }}

    - type: antdCol
      data:
        span: 12
        {{- if $withResponsive }}
        xs: 24
        xl: 12
        {{- end }}
      children:
        {{/*
          endpoint: BFF proxy URL for PATCH on metadata; permissionContext: RBAC;
          fieldSelector/k8sResourceToFetch: optional fetch scope
        */}}
        {{ include $metadataTemplate (dict
            "endpoint" .endpoint
            "permissionContext" .permissionContext
            "fieldSelector" .fieldSelector
            "k8sResourceToFetch" .k8sResourceToFetch
          ) | nindent 8
        }}
{{- end -}}
