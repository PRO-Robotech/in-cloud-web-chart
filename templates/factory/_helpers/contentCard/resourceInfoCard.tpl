{{- define "in-cloud.web.contentCard.resourceInfo" -}}
# Resource info card: kind, creation time, optional namespace column, OwnerRefs.
- type: ContentCard
  data:
    id: resource-info-card
  children:

    # =========================
    # Header: icon + title
    # =========================
    - type: DefaultDiv
      data:
        id: resource-info-card-title
        # AntD: flex row (icon + title)
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: resource-info-icon
            iconName: InfoCircleOutlined
            iconProps:
              size: 24
              color: token.colorInfo
              style:
                fontSize: 24
                color: token.colorInfo

        - type: parsedText
          data:
            id: resource-info-title-text
            text: "{reqsJsonPath[0]['.items.0.kind']['-']} Info"
            style:
              fontSize: 16px
              lineHeight: 24px

    # =========================
    # Main content grid
    # =========================
    # AntD grid layout
    - type: antdRow
      data:
        gutter: [24, 0]
      children:

        # -------------------------
        # Created
        # -------------------------
        - type: antdCol
          data:
            span: 8
            id: resource-info-col-created
          children:
            - type: antdFlex
              data: { vertical: true, gap: 4 }
              children:
                - type: antdText
                  data:
                    strong: true
                    text: Created
                - type: parsedText
                  data:
                    formatter: timestamp
                    text: "{reqsJsonPath[0]['.items.0.metadata.creationTimestamp']['-']}"

        {{- if .namespaced }}
        {{/* When true, resource is namespaced — show Namespace column */}}

        # -------------------------
        # Namespace
        # -------------------------
        - type: antdCol
          data:
            span: 8
            id: resource-info-col-namespace
          children:
            - type: antdFlex
              data: { vertical: true, gap: 4 }
              children:
                - type: antdText
                  data:
                    id: meta-namespace-label
                    strong: true
                    text: Namespace
                - type: antdFlex
                  data:
                    id: namespace-badge-link-row
                    align: center
                    direction: row
                    gap: 6
                  children:
                    - type: ResourceBadge
                      data:
                        id: namespace-resource-badge
                        value: Namespace
                    - type: antdLink
                      data:
                        id: namespace-link
                        href: /openapi-ui/{2}/factory/namespace-details/v1/namespaces/{reqsJsonPath[0]['.items.0.metadata.namespace']['-']}
                        text: '{reqsJsonPath[0][".items.0.metadata.namespace"]["-"]}'

        {{- end }}

        # -------------------------
        # OwnerRefs
        # -------------------------

        - type: antdCol
          data:
            span: 8
            id: resource-info-col-ownerrefs
          children:
            - type: VisibilityContainer
              data:
                id: ds-init-containers-container
                value: "{reqsJsonPath[0]['.items.0.metadata.ownerReferences']['-']}"
                style:
                  margin: 0
                  padding: 0
              children:
                - type: antdFlex
                  data:
                    id: ref-link-block
                    vertical: true
                    gap: 8
                  children:
                    - type: antdText
                      data:
                        id: meta-ref
                        text: OwnerRef
                        strong: true

                    - type: OwnerRefs
                      data:
                        id: refs
                        baseprefix: /openapi-ui
                        # Target cluster for resolving owner references
                        cluster: '{2}'
                        #forcedNamespace: '{3}'
                        # Request index in factory context for owner ref data
                        reqIndex: 0
                        errorText: error getting refs
                        notArrayErrorText: refs on path are not arr
                        emptyArrayErrorText: "-"
                        isNotRefsArrayErrorText: objects in arr are not refs
                        # JSONPath to ownerReferences array in the fetched resource
                        jsonPathToArrayOfRefs: ".items.0.metadata.ownerReferences"
                        baseFactoryClusterSceopedAPIKey: base-factory-clusterscoped-api
                        baseFactoryClusterSceopedBuiltinKey: base-factory-clusterscoped-builtin
                        baseFactoryNamespacedAPIKey: base-factory-namespaced-api
                        baseFactoryNamespacedBuiltinKey: base-factory-namespaced-builtin
                        baseNamespaceFactoryKey: namespace-details
                        baseNavigationPlural: navigations
                        baseNavigationName: navigation

{{- end -}}
