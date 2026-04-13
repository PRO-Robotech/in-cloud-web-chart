{{/* Pod-specific detail cards: node link, networking, and QoS/runtime fields. */}}
{{- define "in-cloud.web.contentCard.podRuntimeFacts" -}}
# Content card with Pod runtime facts (structure copied from Factory -> Details -> right column)
- type: ContentCard
  data:
    id: pod-runtime-facts-card
  children:
      # Card title with icon
    - type: DefaultDiv
      data:
        id: pod-info-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: pod-info-icon
            iconName: InfoCircleOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: pod-info-title-text
            text: "Runtime"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: antdRow
      data:
        gutter: [24, 12]
        id: details-grid
      children:
        # LEFT COLUMN
        - type: antdCol
          data:
            id: col-left
            span: 12
            xs: 24
            xl: 12
          children:
            - type: antdFlex
              data:
                gap: 12
                id: col-left-stack
                vertical: true
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: node-link-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: meta-node
                        strong: true
                        text: Node
                    - type: antdFlex
                      data:
                        align: center
                        direction: row
                        gap: 6
                        id: node-badge-link-row
                      children:
                        - type: ResourceBadge
                          data:
                            id: node-resource-badge
                            value: Node
                        - type: antdLink
                          data:
                            id: name-link
                            href: "/openapi-ui/{2}/factory/node-details/v1/nodes/{reqsJsonPath[0]['.items.0.spec.nodeName']['-']}"
                            text: "{reqsJsonPath[0]['.items.0.spec.nodeName']['-']}"

                - type: antdFlex
                  data:
                    gap: 4
                    id: qos-class-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: qos-class-label
                        strong: true
                        text: QOS class
                    - type: parsedText
                      data:
                        id: qos-class-value
                        text: "{reqsJsonPath[0]['.items.0.status.qosClass']['Not classified yet']}"

                - type: antdFlex
                  data:
                    gap: 4
                    id: restart-policy-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: restart-policy-label
                        strong: true
                        text: Restart policy
                    - type: parsedText
                      data:
                        id: restart-policy-value
                        text: "{reqsJsonPath[0]['.items.0.spec.restartPolicy']['Always (default)']}"

        # RIGHT COLUMN
        - type: antdCol
          data:
            id: col-right
            span: 12
            xs: 24
            xl: 12
          children:
            - type: antdFlex
              data:
                gap: 12
                id: col-right-stack
                vertical: true
              children:
                - type: antdFlex
                  data:
                    gap: 4
                    id: pod-ip-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: pod-ip-label
                        strong: true
                        text: Pod IP
                    - type: parsedText
                      data:
                        id: pod-ip-value
                        text: "{reqsJsonPath[0]['.items.0.status.podIP']['Not assigned yet']}"

                - type: antdFlex
                  data:
                    gap: 4
                    id: host-ip-block
                    vertical: true
                  children:
                    - type: antdText
                      data:
                        id: host-ip-label
                        strong: true
                        text: Node IP
                    - type: parsedText
                      data:
                        id: host-ip-value
                        text: "{reqsJsonPath[0]['.items.0.status.hostIP']['Not assigned yet']}"
{{- end -}}
