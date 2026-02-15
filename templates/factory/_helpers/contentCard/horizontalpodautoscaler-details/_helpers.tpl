{{- define "in-cloud.web.contentCard.horizontalpodautoscalerRuntimeFacts" -}}
# Content card with HPA runtime facts (two columns)
- type: ContentCard
  data:
    id: horizontalpodautoscaler-runtime-facts-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: horizontalpodautoscaler-info-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: horizontalpodautoscaler-info-icon
            iconName: SettingOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: horizontalpodautoscaler-info-title-text
            text: "Scaling Configuration"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: antdRow
      data:
        gutter: [24, 12]
        id: horizontalpodautoscaler-runtime-grid
      children:
        # LEFT COLUMN — Scale target
        - type: antdCol
          data:
            id: horizontalpodautoscaler-col-left
            span: 12
            xs: 24
            xl: 12
          children:
            - type: antdFlex
              data:
                gap: 12
                id: horizontalpodautoscaler-col-left-stack
                vertical: true
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: scale-target-ref-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: scale-target-ref-label
                        strong: true
                        text: Scale target ref

                    - type: OwnerRefs
                      data:
                        id: refs
                        baseprefix: /openapi-ui
                        cluster: '{2}'
                        #forcedNamespace: '{3}'
                        reqIndex: 0
                        errorText: error getting refs
                        notArrayErrorText: refs on path are not arr
                        emptyArrayErrorText: "-"
                        isNotRefsArrayErrorText: objects in arr are not refs
                        jsonPathToArrayOfRefs: ".items.0.spec.scaleTargetRef"
                        baseFactoryClusterSceopedAPIKey: base-factory-clusterscoped-api
                        baseFactoryClusterSceopedBuiltinKey: base-factory-clusterscoped-builtin
                        baseFactoryNamespacedAPIKey: base-factory-namespaced-api
                        baseFactoryNamespacedBuiltinKey: base-factory-namespaced-builtin
                        baseNamespaceFactoryKey: namespace-details
                        baseNavigationPlural: navigations
                        baseNavigationName: navigation



        # RIGHT COLUMN — Replicas & metrics
        - type: antdCol
          data:
            id: horizontalpodautoscaler-col-right
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: horizontalpodautoscaler-col-right-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:
                - type: antdFlex
                  data:
                    gap: 12
                    id: horizontalpodautoscaler-col-right-stack-a
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: min-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: min-replicas-label
                            strong: true
                            text: Min replicas
                        - type: parsedText
                          data:
                            id: min-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.spec.minReplicas']['1 (default)']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: max-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: max-replicas-label
                            strong: true
                            text: Max replicas
                        - type: parsedText
                          data:
                            id: max-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.spec.maxReplicas']['Not configured']}"

                - type: antdFlex
                  data:
                    gap: 12
                    id: horizontalpodautoscaler-col-right-stack-b
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: current-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: current-replicas-label
                            strong: true
                            text: Current replicas
                        - type: parsedText
                          data:
                            id: current-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.status.currentReplicas']['Not reported yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: desired-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: desired-replicas-label
                            strong: true
                            text: Desired replicas
                        - type: parsedText
                          data:
                            id: desired-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.status.desiredReplicas']['Not reported yet']}"
{{- end -}}
