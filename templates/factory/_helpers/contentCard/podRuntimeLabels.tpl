{{- define "in-cloud.web.contentCard.podRuntimeLabels" -}}
# Content card with Pod runtime labels (two columns)
- type: ContentCard
  data:
    id: pod-runtime-labels-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: pod-runtime-labels-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: pod-runtime-labels-icon
            iconName: TagsOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: pod-runtime-labels-title-text
            text: "Selectors"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: antdRow
      data:
        gutter: [24, 12]
        id: pod-runtime-labels-grid
      children:
        # LEFT COLUMN — Node labels (nodeSelector)
        - type: antdCol
          data:
            span: 12
            xs: 24
            xl: 12
            id: pod-runtime-node-labels-col
          children:
            - type: antdFlex
              data:
                id: pod-runtime-node-labels-stack
                vertical: true
                gap: 12
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: node-labels-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: node-labels-label
                        strong: true
                        text: Node selector
                    - type: LabelsToSearchParams
                      data:
                        id: node-labels-to-search-params
                        reqIndex: 0
                        jsonPathToLabels: {{ .nodJsonPathToLabels | default ".items.0.spec.nodeSelector" | quote }}
                        linkPrefix: "/openapi-ui/{2}/search?kinds=~v1~nodes"
                        errorText: "No selector"
                        # maxTextLength: 11
                        textLink: Search
                        renderLabelsAsRows: true

        # RIGHT COLUMN — Pod labels
        - type: antdCol
          data:
            span: 12
            xs: 24
            xl: 12
            id: pod-runtime-pod-labels-col
          children:
            - type: antdFlex
              data:
                id: pod-runtime-pod-labels-stack
                vertical: true
                gap: 12
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: pod-labels-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: pod-labels-label
                        strong: true
                        text: Pod selector
                    - type: LabelsToSearchParams
                      data:
                        id: pod-labels-to-search-params
                        reqIndex: 0
                        jsonPathToLabels: {{ .podJsonPathToLabels | default ".items.0.metadata.labels" | quote }}
                        linkPrefix: "/openapi-ui/{2}/{3}/search?kinds=~v1~pods"
                        errorText: "No labels"
                        # maxTextLength: 11
                        textLink: Search
                        renderLabelsAsRows: false
                        # maxTextLength: ""
{{- end -}}
