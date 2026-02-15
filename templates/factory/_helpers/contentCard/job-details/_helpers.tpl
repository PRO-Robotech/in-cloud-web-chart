{{- define "in-cloud.web.contentCard.jobRuntimeFacts" -}}
# Content card with Job runtime facts (two columns)
- type: ContentCard
  data:
    id: job-runtime-facts-card
  children:

    - type: antdRow
      data:
        gutter: [24, 12]
        id: job-runtime-grid
      children:


        # LEFT COLUMN — Job details
        - type: antdCol
          data:
            id: job-col-left
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: job-details-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: job-details-icon
                    iconName: SettingOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: job-details-title-text
                    text: "Job Spec"
                    style:
                      fontSize: 16px
                      lineHeight: 24px
            - type: DefaultDiv
              data:
                id: job-col-left-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:
                - type: antdFlex
                  data:
                    gap: 12
                    id: job-col-left-stack-a
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: completion-mode-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: completion-mode-label
                            strong: true
                            text: "Completion mode"
                        - type: parsedText
                          data:
                            id: completion-mode-value
                            text: "{reqsJsonPath[0]['.items.0.spec.completionMode']['NonIndexed (default)']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: completions-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: completions-label
                            strong: true
                            text: "Desired completions"
                        - type: parsedText
                          data:
                            id: completions-value
                            text: "{reqsJsonPath[0]['.items.0.spec.completions']['1 (default)']}"

                - type: antdFlex
                  data:
                    gap: 12
                    id: job-col-left-stack-b
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: backoff-limit-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: backoff-limit-label
                            strong: true
                            text: "Backoff limit"
                        - type: parsedText
                          data:
                            id: backoff-limit-value
                            text: "{reqsJsonPath[0]['.items.0.spec.backoffLimit']['6 (default)']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: suspend-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: suspend-label
                            strong: true
                            text: Suspend
                        - type: parsedText
                          data:
                            id: suspend-value
                            text: "{reqsJsonPath[0]['.items.0.spec.suspend']['false']}"

        # RIGHT COLUMN — Job status
        - type: antdCol
          data:
            id: job-col-right
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: job-status-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: job-status-icon
                    iconName: CheckCircleOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: job-status-title-text
                    text: "Status"
                    style:
                      fontSize: 16px
                      lineHeight: 24px
            - type: DefaultDiv
              data:
                id: job-col-right-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:
                - type: antdFlex
                  data:
                    gap: 12
                    id: job-col-right-timing-stack
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: start-time-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: start-time-label
                            strong: true
                            text: "Start time"
                        - type: parsedText
                          data:
                            id: start-time-value
                            text: "{reqsJsonPath[0]['.items.0.status.startTime']['Not started yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: completion-time-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: completion-time-label
                            strong: true
                            text: "Completion time"
                        - type: parsedText
                          data:
                            id: completion-time-value
                            text: "{reqsJsonPath[0]['.items.0.status.completionTime']['Not finished yet']}"

                - type: antdFlex
                  data:
                    gap: 12
                    id: job-col-right-counters-stack
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: succeeded-pods-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: succeeded-pods-label
                            strong: true
                            text: "Succeeded"
                        - type: parsedText
                          data:
                            id: succeeded-pods-value
                            text: "{reqsJsonPath[0]['.items.0.status.succeeded']['0']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: active-pods-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: active-pods-label
                            strong: true
                            text: "Active"
                        - type: parsedText
                          data:
                            id: active-pods-value
                            text: "{reqsJsonPath[0]['.items.0.status.active']['0']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: failed-pods-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: failed-pods-label
                            strong: true
                            text: "Failed"
                        - type: parsedText
                          data:
                            id: failed-pods-value
                            text: "{reqsJsonPath[0]['.items.0.status.failed']['0']}"



{{- end -}}
