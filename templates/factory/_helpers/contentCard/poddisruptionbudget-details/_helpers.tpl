{{/* PodDisruptionBudget-specific detail cards: min/max disruption and status counters. */}}
{{- define "in-cloud.web.contentCard.poddisruptionbudgetRuntimeFacts" -}}
# Content card with PodDisruptionBudget runtime facts (two columns)
- type: ContentCard
  data:
    id: poddisruptionbudget-runtime-facts-card
  children:

    - type: antdRow
      data:
        gutter: [24, 12]
        id: poddisruptionbudget-runtime-grid
      children:
        # LEFT COLUMN — Spec
        - type: antdCol
          data:
            id: poddisruptionbudget-col-left
            span: 12
            xs: 24
            xl: 12
          children:
            # Card title with icon
            - type: DefaultDiv
              data:
                id: poddisruptionbudget-spec-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: poddisruptionbudget-spec-icon
                    iconName: SettingOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: poddisruptionbudget-spec-title-text
                    text: "Disruption Policy"
                    style:
                      fontSize: 16px
                      lineHeight: 24px

            - type: antdFlex
              data:
                gap: 12
                id: poddisruptionbudget-col-left-stack
                vertical: true
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: min-available-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: min-available-label
                        strong: true
                        text: Min available
                    - type: parsedText
                      data:
                        id: min-available-value
                        text: "{reqsJsonPath[0]['.items.0.spec.minAvailable']['Not configured']}"

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
                        text: "{reqsJsonPath[0]['.items.0.spec.maxUnavailable']['Not configured']}"

        # RIGHT COLUMN — Status
        - type: antdCol
          data:
            id: poddisruptionbudget-col-right
            span: 12
            xs: 24
            xl: 12
          children:
            # Card title with icon
            - type: DefaultDiv
              data:
                id: poddisruptionbudget-status-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: poddisruptionbudget-status-icon
                    iconName: CheckCircleOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: poddisruptionbudget-status-title-text
                    text: "Status"
                    style:
                      fontSize: 16px
                      lineHeight: 24px

            - type: antdRow
              data:
                gutter: [24, 12]
                id: poddisruptionbudget-status-grid
              children:
                # LEFT STATUS COLUMN
                - type: antdCol
                  data:
                    id: poddisruptionbudget-status-col-left
                    span: 12
                    xs: 24
                    xl: 12
                  children:
                    - type: antdFlex
                      data:
                        gap: 12
                        vertical: true
                      children:
                        - type: antdFlex
                          data:
                            gap: 4
                            id: disruptions-allowed-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: disruptions-allowed-label
                                strong: true
                                text: Disruptions allowed
                            - type: parsedText
                              data:
                                id: disruptions-allowed-value
                                text: "{reqsJsonPath[0]['.items.0.status.disruptionsAllowed']['0']}"

                        - type: antdFlex
                          data:
                            gap: 4
                            id: current-healthy-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: current-healthy-label
                                strong: true
                                text: Current healthy
                            - type: parsedText
                              data:
                                id: current-healthy-value
                                text: "{reqsJsonPath[0]['.items.0.status.currentHealthy']['0']}"

                        - type: VisibilityContainer
                          data:
                            id: condition-status-visibility
                            value: '{reqsJsonPath[0][".items.0.status.conditions"]}'
                          children:
                            - type: antdFlex
                              data:
                                gap: 4
                                id: condition-status-block
                                vertical: true
                              children:
                                - type: antdText
                                  data:
                                    id: condition-status-label
                                    strong: true
                                    text: Condition status
                                - type: parsedText
                                  data:
                                    id: condition-status-value
                                    text: "{reqsJsonPath[0]['.items.0.status.conditions.0.status']['Not reported']}"
                                
                # RIGHT STATUS COLUMN
                - type: antdCol
                  data:
                    id: poddisruptionbudget-status-col-right
                    span: 12
                    xs: 24
                    xl: 12
                  children:
                    - type: antdFlex
                      data:
                        gap: 12
                        vertical: true
                      children:
                        - type: antdFlex
                          data:
                            gap: 4
                            id: desired-healthy-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: desired-healthy-label
                                strong: true
                                text: Desired healthy
                            - type: parsedText
                              data:
                                id: desired-healthy-value
                                text: "{reqsJsonPath[0]['.items.0.status.desiredHealthy']['0']}"

                        - type: antdFlex
                          data:
                            gap: 4
                            id: expected-pods-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: expected-pods-label
                                strong: true
                                text: Expected pods
                            - type: parsedText
                              data:
                                id: expected-pods-value
                                text: "{reqsJsonPath[0]['.items.0.status.expectedPods']['0']}"


{{- end -}}
