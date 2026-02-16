{{- define "in-cloud.web.contentCard.aquaReport" -}}
# Content card with configuration/security report table
- type: ContentCard
  data:
    id: config-report-card
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
        # UI customization preset for Trivy Operator reports table
        customizationId: {{ .customizationId | quote }}
        # API endpoint to fetch ClusterInfraAssessmentReports
        fetchUrl: {{ .fetchUrl | quote }}
        # Label selector to bind report to current resource (kind/name)
        {{- if index . "labelSelector" }}
        labelSelector:
          {{- toYaml (index . "labelSelector") | nindent 10 }}
        {{- end }}
        # Path to report checks inside API response
        pathToItems: {{ .pathToItems | quote }}
{{- end -}}
