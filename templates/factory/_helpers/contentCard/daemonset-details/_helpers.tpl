{{- define "in-cloud.web.contentCard.daemonsetRuntimeFacts" -}}
# Content card with DaemonSet runtime facts (two columns, status split into two columns)
- type: ContentCard
  data:
    id: daemonset-runtime-facts-card
  children:

    - type: antdRow
      data:
        gutter: [24, 12]
        id: daemonset-runtime-grid
      children:
        # LEFT COLUMN — Update strategy
        - type: antdCol
          data:
            id: daemonset-col-strategy
            span: 12
            xs: 24
            xl: 12
          children:
            # Card title with icon
            - type: DefaultDiv
              data:
                id: daemonset-strategy-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: daemonset-strategy-icon
                    iconName: SettingOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24px
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: daemonset-strategy-title-text
                    text: "Rollout Strategy"
                    style:
                      fontSize: 16px
                      lineHeight: 24px

            - type: antdFlex
              data:
                gap: 12
                id: daemonset-strategy-stack
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
                    id: max-surge-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: max-surge-label
                        strong: true
                        text: Max surge
                    - type: parsedText
                      data:
                        id: max-surge-value
                        text: "{reqsJsonPath[0]['.items.0.spec.updateStrategy.rollingUpdate.maxSurge']['Not configured']}"

        # RIGHT COLUMN — Status (split into two columns)
        - type: antdCol
          data:
            id: daemonset-col-status
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: daemonset-status-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: daemonset-status-icon
                    iconName: CheckCircleOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24px
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: daemonset-status-title-text
                    text: "Status"
                    style:
                      fontSize: 16px
                      lineHeight: 24px

            # Two-column grid inside Status
            - type: DefaultDiv
              data:
                id: daemonset-status-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:

                # LEFT STATUS COLUMN
                - type: antdFlex
                  data:
                    gap: 12
                    id: daemonset-status-left
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: current-number-scheduled-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: current-number-scheduled-label
                            strong: true
                            text: Current scheduled
                        - type: parsedText
                          data:
                            id: current-number-scheduled-value
                            text: "{reqsJsonPath[0]['.items.0.status.currentNumberScheduled']['Not reported yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: number-ready-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: number-ready-label
                            strong: true
                            text: Ready
                        - type: parsedText
                          data:
                            id: number-ready-value
                            text: "{reqsJsonPath[0]['.items.0.status.numberReady']['Not reported yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: number-available-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: number-available-label
                            strong: true
                            text: Available
                        - type: parsedText
                          data:
                            id: number-available-value
                            text: "{reqsJsonPath[0]['.items.0.status.numberAvailable']['Not reported yet']}"

                # RIGHT STATUS COLUMN
                - type: antdFlex
                  data:
                    gap: 12
                    id: daemonset-status-right
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: desired-number-scheduled-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: desired-number-scheduled-label
                            strong: true
                            text: Desired scheduled
                        - type: parsedText
                          data:
                            id: desired-number-scheduled-value
                            text: "{reqsJsonPath[0]['.items.0.status.desiredNumberScheduled']['Not reported yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: updated-number-scheduled-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: updated-number-scheduled-label
                            strong: true
                            text: Updated scheduled
                        - type: parsedText
                          data:
                            id: updated-number-scheduled-value
                            text: "{reqsJsonPath[0]['.items.0.status.updatedNumberScheduled']['Not reported yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: number-misscheduled-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: number-misscheduled-label
                            strong: true
                            text: Misscheduled
                        - type: parsedText
                          data:
                            id: number-misscheduled-value
                            text: "{reqsJsonPath[0]['.items.0.status.numberMisscheduled']['Not reported yet']}"

{{- end -}}
