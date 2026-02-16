{{- define "in-cloud.web.contentCard.roleRules" -}}
# Content card with Role rules table
- type: ContentCard
  data:
    id: role-runtime-facts-card
  children:
    - type: DefaultDiv
      data:
        id: role-info-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: role-info-icon
            iconName: SafetyCertificateOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: role-info-title-text
            text: "Rules"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: EnrichedTable
      data:
        id: role-rules-table
        cluster: "{2}"
        customizationId: factory-k8s-rbac-rules
        baseprefix: /openapi-ui
        pathToItems: ".items.0.rules"
        k8sResourceToFetch:
          namespace: "{3}"
          apiGroup: "{6}"
          apiVersion: "{7}"
          plural: "{8}"
        fieldSelector:
          metadata.name: "{9}"
{{- end -}}
