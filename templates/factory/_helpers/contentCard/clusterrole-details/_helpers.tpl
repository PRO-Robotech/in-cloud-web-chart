{{/* ClusterRole-specific detail card: RBAC rules table (cluster-scoped). */}}
{{- define "in-cloud.web.contentCard.clusterroleRules" -}}
# Content card with ClusterRole rules table
- type: ContentCard
  data:
    id: clusterrole-runtime-facts-card
  children:
    - type: DefaultDiv
      data:
        id: clusterrole-info-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: clusterrole-info-icon
            iconName: SafetyCertificateOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: clusterrole-info-title-text
            text: "Rules"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: EnrichedTable
      data:
        id: clusterrole-rules-table
        cluster: "{2}"
        {{/* UI table column/layout override id */}}
        customizationId: factory-k8s-rbac-rules
        baseprefix: /openapi-ui
        pathToItems: ".items.0.rules"
        {{/* K8s list API for this ClusterRole */}}
        k8sResourceToFetch: 
          apiGroup: "{5}"
          apiVersion: "{6}"
          plural: "{7}"
        {{/* server-side filter to the current ClusterRole */}}
        fieldSelector:
          metadata.name: "{8}"
{{- end -}}
