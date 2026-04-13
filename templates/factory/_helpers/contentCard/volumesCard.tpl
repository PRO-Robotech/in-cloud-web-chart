{{- define "in-cloud.web.contentCard.volumes" -}}
# Content card with resource volumes
- type: ContentCard
  data:
    id: volumes-card
    title: volumes
  children:
    # =========================
    # Header: icon + title
    # =========================
    - type: DefaultDiv
      data:
        id: volumes-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: volumes-info-icon
            iconName: HddOutlined
            iconProps:
              size: 24
              color: token.colorInfo
              style:
                fontSize: 24
                color: token.colorInfo

        - type: antdText
          data:
            id: volumes-title-text
            text: "Volumes"
            style:
              fontSize: 16px
              lineHeight: 24px

    # =========================
    # Volumes details
    # =========================
    - type: Volumes
      data:
        reqIndex: {{ .reqIndex | default 0 }}
        jsonPathToSpec: {{ .jsonPathToSpec | default ".items.0.spec" }}
        errorText: {{ .errorText | default "No efficient data in spec" | quote }}
        baseprefix: "/openapi-ui"
        cluster: '{2}'
        forcedNamespace: '{3}'

        jsonPathToPodName: .items.0.metadata.name
        baseFactoryClusterSceopedAPIKey: base-factory-clusterscoped-api
        baseFactoryClusterSceopedBuiltinKey: base-factory-clusterscoped-builtin
        baseFactoryNamespacedAPIKey: base-factory-namespaced-api
        baseFactoryNamespacedBuiltinKey: base-factory-namespaced-builtin
        baseNamespaceFactoryKey: namespace-details
        baseNavigationPluralName: navigations
        baseNavigationSpecificName: navigation
        errorText: "No efficient data in spec"
{{- end -}}
