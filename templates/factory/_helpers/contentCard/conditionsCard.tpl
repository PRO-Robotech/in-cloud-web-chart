{{- define "in-cloud.web.contentCard.conditions" -}}
# Content card with resource conditions table
- type: ContentCard
  data:
    id: conditions-card
    title: Conditions
  children:

    # =========================
    # Header: icon + title
    # =========================
    - type: DefaultDiv
      data:
        id: conditions-card-title
        # AntD: flex row (icon + title)
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: conditions-info-icon
            iconName: CheckCircleOutlined
            iconProps:
              size: 24
              color: token.colorInfo
              style:
                fontSize: 24
                color: token.colorInfo

        - type: antdText
          data:
            id: conditions-title-text
            text: "Conditions"
            style:
              fontSize: 16px
              lineHeight: 24px

    # =========================
    # Conditions table
    # =========================
    - type: EnrichedTable
      data:
        baseprefix: /openapi-ui
        # Target cluster for table data fetch
        cluster: '{2}'
        # CCO id: table columns/presentation for status conditions
        customizationId: factory-status-conditions
        id: conditions-table
        pathToItems: .items.0.status.conditions
        withoutControls: true

        # K8s resource to fetch conditions from
        k8sResourceToFetch:
          {{ toYaml .k8sResourceToFetch | nindent 14 }}

        # Field selector to bind conditions to a concrete resource
        fieldSelector:
          {{ toYaml .fieldSelector | nindent 14 }}
{{- end -}}

{{- define "in-cloud.web.contentCard.conditionsVisibility" -}}
# Visibility wrapper for conditions card (renders only when conditions exist)
- type: VisibilityContainer
  data:
    id: conditions-visibility-guard
    value: '{reqsJsonPath[0][".items.0.status.conditions"]}'
  children:
    {{ include "in-cloud.web.contentCard.conditions" . | nindent 4 }}
{{- end -}}
