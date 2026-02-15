{{- define "in-cloud.web.contentCard.networkpolicyRuntimeFacts" -}}
# Content card with NetworkPolicy runtime facts
- type: ContentCard
  data:
    id: networkpolicy-runtime-facts-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: networkpolicy-runtime-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: networkpolicy-runtime-icon
            iconName: InfoCircleOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: networkpolicy-runtime-title-text
            text: "Policy Overview"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: antdRow
      data:
        gutter: [24, 12]
      children:
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
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Pod Selector
                        strong: true
                    - type: LabelsToSearchParams
                      data:
                        id: networkpolicy-pod-selector
                        reqIndex: 0
                        jsonPathToLabels: ".items.0.spec.podSelector.matchLabels"
                        linkPrefix: "/openapi-ui/{2}/{3}/search?kinds=~v1~pods"
                        errorText: "Selects all pods in namespace"
                        textLink: Search
                        renderLabelsAsRows: true

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Policy Types
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.policyTypes']['Not reported']}"

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
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Ingress Ports
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.ingress[*].ports[*].port']['All ports or not configured']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Egress Ports
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.egress[*].ports[*].port']['All ports or not configured']}"
{{- end -}}
