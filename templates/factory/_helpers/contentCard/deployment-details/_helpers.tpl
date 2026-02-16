{{- define "in-cloud.web.contentCard.deploymentRuntimeFacts" -}}
# Content card with Deployment runtime facts (two columns)
- type: ContentCard
  data:
    id: deployment-runtime-facts-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: deployment-info-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: deployment-info-icon
            iconName: SettingOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: deployment-info-title-text
            text: "Rollout"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: antdRow
      data:
        gutter: [24, 12]
        id: deployment-runtime-grid
      children:
        # LEFT COLUMN
        - type: antdCol
          data:
            id: deployment-col-left
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: deployment-col-left-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:
                - type: antdFlex
                  data:
                    gap: 12
                    id: deployment-col-left-stack-a
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
                            text: Update strategy
                        - type: parsedText
                          data:
                            id: update-strategy-value
                            text: "{reqsJsonPath[0]['.items.0.spec.strategy.type']['RollingUpdate (default)']}"

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
                            text: "{reqsJsonPath[0]['.items.0.spec.strategy.rollingUpdate.maxUnavailable']['Default by strategy']}"

                - type: antdFlex
                  data:
                    gap: 12
                    id: deployment-col-left-stack-b
                    vertical: true
                  children:
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
                            text: "{reqsJsonPath[0]['.items.0.spec.replicas']['1 (default)']}"

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
                            text: "{reqsJsonPath[0]['.items.0.spec.strategy.rollingUpdate.maxSurge']['Default by strategy']}"

        # RIGHT COLUMN
        - type: antdCol
          data:
            id: deployment-col-right
            span: 12
            xs: 24
            xl: 12
          children:
            - type: antdFlex
              data:
                gap: 12
                id: deployment-col-right-stack
                vertical: true
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: progress-deadline-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: progress-deadline-label
                        strong: true
                        text: Progress deadline
                    - type: parsedText
                      data:
                        id: progress-deadline-value
                        text: "{reqsJsonPath[0]['.items.0.spec.progressDeadlineSeconds']['600 (default)']}"

                - type: antdFlex
                  data:
                    gap: 4
                    id: min-ready-seconds-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: min-ready-seconds-label
                        strong: true
                        text: Min ready seconds
                    - type: parsedText
                      data:
                        id: min-ready-seconds-value
                        text: "{reqsJsonPath[0]['.items.0.spec.minReadySeconds']['0 (default)']}"
{{- end -}}
