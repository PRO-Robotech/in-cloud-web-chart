{{- define "in-cloud.web.contentCard.statefulsetRuntimeFacts" -}}
# Content card with StatefulSet runtime facts (two columns)
- type: ContentCard
  data:
    id: statefulset-runtime-facts-card
  children:

    - type: antdRow
      data:
        gutter: [24, 12]
        id: statefulset-runtime-grid
      children:
        # LEFT COLUMN — Update strategy
        - type: antdCol
          data:
            id: statefulset-col-strategy
            span: 12
            xs: 24
            xl: 12
          children:
            # Card title with icon
            - type: DefaultDiv
              data:
                id: statefulset-info-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: statefulset-info-icon
                    iconName: SettingOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: statefulset-info-title-text
                    text: "Rollout Strategy"
                    style:
                      fontSize: 16px
                      lineHeight: 24px

            - type: antdFlex
              data:
                gap: 12
                id: statefulset-col-strategy-stack
                vertical: true
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: update-strategy-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: update-strategy-label
                        strong: true
                        text: Type
                    - type: parsedText
                      data:
                        id: update-strategy-value
                        text: "{reqsJsonPath[0]['.items.0.spec.updateStrategy.type']['RollingUpdate (default)']}"

                - type: antdFlex
                  data:
                    gap: 4
                    id: max-unavailable-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: max-unavailable-label
                        strong: true
                        text: Max unavailable
                    - type: parsedText
                      data:
                        id: max-unavailable-value
                        text: "{reqsJsonPath[0]['.items.0.spec.updateStrategy.rollingUpdate.maxUnavailable']['Not configured']}"

                - type: antdFlex
                  data:
                    gap: 4
                    id: partition-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: partition-label
                        strong: true
                        text: Partition
                    - type: parsedText
                      data:
                        id: partition-value
                        text: "{reqsJsonPath[0]['.items.0.spec.updateStrategy.rollingUpdate.partition']['0 (default)']}"

        # RIGHT COLUMN — Status
        - type: antdCol
          data:
            id: statefulset-col-status
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: statefulset-status-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: statefulset-status-icon
                    iconName: CheckCircleOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: statefulset-status-title-text
                    text: "Status"
                    style:
                      fontSize: 16px
                      lineHeight: 24px

            # Two-column layout
            - type: DefaultDiv
              data:
                id: statefulset-col-left-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:

                # LEFT COLUMN
                - type: antdFlex
                  data:
                    gap: 12
                    id: statefulset-col-left-stack
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
                        id: ready-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: ready-replicas-label
                            strong: true
                            text: Ready replicas
                        - type: parsedText
                          data:
                            id: ready-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.status.readyReplicas']['Not reported yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: available-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: available-replicas-label
                            strong: true
                            text: Available replicas
                        - type: parsedText
                          data:
                            id: available-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.status.availableReplicas']['Not reported yet']}"

                # RIGHT COLUMN
                - type: antdFlex
                  data:
                    gap: 12
                    id: statefulset-col-right-stack
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: replicas-label
                            strong: true
                            text: Replicas
                        - type: parsedText
                          data:
                            id: replicas-value
                            text: "{reqsJsonPath[0]['.items.0.status.replicas']['Not reported yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: updated-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: updated-replicas-label
                            strong: true
                            text: Updated replicas
                        - type: parsedText
                          data:
                            id: updated-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.status.updatedReplicas']['Not reported yet']}"
{{- end -}}
