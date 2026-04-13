{{/* ReplicaSet-specific detail cards: replica counts and status. */}}
{{- define "in-cloud.web.contentCard.replicasetRuntimeFacts" -}}
# Content card with ReplicaSet runtime facts (two columns, status split into two columns)
- type: ContentCard
  data:
    id: replicaset-runtime-facts-card
  children:

    - type: antdRow
      data:
        gutter: [24, 12]
        id: replicaset-runtime-grid
      children:

        - type: antdCol
          data:
            id: replicaset-col-status
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: replicaset-status-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: replicaset-status-icon
                    iconName: CheckCircleOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24px
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: replicaset-status-title-text
                    text: "Status"
                    style:
                      fontSize: 16px
                      lineHeight: 24px

            # Two-column grid inside Status
            - type: DefaultDiv
              data:
                id: replicaset-status-grid
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
                    id: replicaset-status-left
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

                # RIGHT STATUS COLUMN
                - type: antdFlex
                  data:
                    gap: 12
                    id: replicaset-status-right
                    vertical: true
                  children:
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

                    - type: antdFlex
                      data:
                        gap: 4
                        id: fully-labeled-replicas-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: fully-labeled-replicas-label
                            strong: true
                            text: Fully labeled
                        - type: parsedText
                          data:
                            id: fully-labeled-replicas-value
                            text: "{reqsJsonPath[0]['.items.0.status.fullyLabeledReplicas']['Not reported yet']}"

{{- end -}}
