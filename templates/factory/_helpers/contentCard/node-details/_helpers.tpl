{{/*
  Node-specific detail cards: overview, identifiers, and addresses (pods/terminal/taints may be
  composed elsewhere).
*/}}
{{- define "in-cloud.web.contentCard.nodeInfo" -}}
# Content card with runtime and OS information about the Node
- type: ContentCard
  data:
    id: node-info-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: node-info-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: node-info-icon
            iconName: InfoCircleOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: node-info-title-text
            text: "Node Overview"
            style:
              fontSize: 16px
              lineHeight: 24px

    # Main content: Node runtime / OS fields
    - type: antdRow
      data:
        gutter: [24, 0]
      children:
        # Left column: kubelet, OS, container runtime, addresses
        - type: antdCol
          data:
            span: 12
            xs: 24
            xl: 12
          children:
            - type: antdFlex
              data:
                vertical: true
                gap: 12
              children:
                - type: antdFlex
                  data: { vertical: true, gap: 4 }
                  children:
                    - type: antdText
                      data:
                        strong: true
                        text: Kubelet version
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.kubeletVersion']['Not reported']}"

                - type: antdFlex
                  data: { vertical: true, gap: 4 }
                  children:
                    - type: antdText
                      data:
                        strong: true
                        text: OS image
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.osImage']['Not reported']}"

                - type: antdFlex
                  data: { vertical: true, gap: 4 }
                  children:
                    - type: antdText
                      data:
                        strong: true
                        text: Container runtime
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.containerRuntimeVersion']['Not reported']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        strong: true
                        text: Node address
                    - type: ArrayOfObjectsToKeyValues
                      data:
                        {{/* Which parallel fetch result (reqsJsonPath index) to read */}}
                        reqIndex: 0
                        jsonPathToArray: .items.0.status.addresses
                        keyFieldName: type
                        keyFieldStyle:
                          color: "#aaabac"
                        valueFieldName: address

        # Right column: architecture and kernel version
        - type: antdCol
          data:
            span: 12
            xs: 24
            xl: 12
          children:
            - type: antdFlex
              data:
                vertical: true
                gap: 12
              children:
                - type: antdFlex
                  data: { vertical: true, gap: 4 }
                  children:
                    - type: antdText
                      data:
                        strong: true
                        text: Architecture
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.architecture']['Not reported']}"

                - type: antdFlex
                  data: { vertical: true, gap: 4 }
                  children:
                    - type: antdText
                      data:
                        strong: true
                        text: Kernel version
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.kernelVersion']['Not reported']}"
{{- end -}}


{{- define "in-cloud.web.contentCard.nodeFacts" -}}
# Content card with immutable node identifiers and machine facts
- type: ContentCard
  data:
    id: node-facts-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: node-facts-card-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: node-facts-icon
            iconName: TagsOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: node-facts-title-text
            text: "Node IDs"
            style:
              fontSize: 16px
              lineHeight: 24px

    # Main content: immutable identifiers
    - type: antdFlex
      data:
        vertical: true
        gap: 12
      children:
        - type: antdFlex
          data: { vertical: true, gap: 4 }
          children:
            - type: antdText
              data:
                strong: true
                text: Boot ID
            - type: parsedText
              data:
                text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.bootID']['Not reported']}"

        - type: antdFlex
          data: { vertical: true, gap: 4 }
          children:
            - type: antdText
              data:
                strong: true
                text: System UUID
            - type: parsedText
              data:
                text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.systemUUID']['Not reported']}"

        - type: antdFlex
          data: { vertical: true, gap: 4 }
          children:
            - type: antdText
              data:
                strong: true
                text: Machine ID
            - type: parsedText
              data:
                text: "{reqsJsonPath[0]['.items.0.status.nodeInfo.machineID']['Not reported']}"
{{- end -}}
