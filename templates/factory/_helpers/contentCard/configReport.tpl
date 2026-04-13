{{- define "in-cloud.web.contentCard.aquaReport" -}}
# Aqua (config audit) report table: security/configuration checks for the current resource via
# openapi-ui.
- type: ContentCard
  data:
    id: config-report-card
    # AntD: card spacing
    style:
      marginBottom: 24px
  children:
    # =========================
    # Report table
    # =========================
    - type: EnrichedTable
      data:
        id: ds-pods-table
        # Base prefix for navigation and links (passed from template context)
        baseprefix: "/openapi-ui"
        # Target cluster identifier
        cluster: "{2}"
        # CCO id: table columns/presentation for Aqua/config audit reports
        customizationId: {{ .customizationId | quote }}
        # URL the UI calls to load report payload (BFF/proxy or direct API)
        fetchUrl: {{ .fetchUrl | quote }}
        # Label selector to bind report rows to the current resource
        {{- if index . "labelSelector" }}
        labelSelector:
          {{- toYaml (index . "labelSelector") | nindent 10 }}
        {{- end }}
        # Path to report checks inside API response
        pathToItems: {{ .pathToItems | quote }}
{{- end -}}
