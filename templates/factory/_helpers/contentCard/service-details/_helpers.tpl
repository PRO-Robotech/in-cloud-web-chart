{{- define "in-cloud.web.contentCard.serviceRuntimeFacts" -}}
# Content card with Service runtime policy facts
- type: ContentCard
  data:
    id: service-runtime-facts-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: service-runtime-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: service-runtime-icon
            iconName: SettingOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: service-runtime-title-text
            text: "Runtime"
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
                        text: Type
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.type']['ClusterIP (default)']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Session affinity
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.sessionAffinity']['None (default)']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Internal traffic policy
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.internalTrafficPolicy']['Cluster (default)']}"

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
                        text: IP family policy
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.ipFamilyPolicy']['SingleStack (default)']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: External traffic policy
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.externalTrafficPolicy']['Not configured']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Publish not-ready addresses
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.publishNotReadyAddresses']['false (default)']}"
{{- end -}}

{{- define "in-cloud.web.contentCard.serviceRoutingAndPorts" -}}
# Content card with Service routing facts, ports and endpoint slices
- type: ContentCard
  data:
    id: service-routing-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: service-routing-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: service-routing-icon
            iconName: BranchesOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: service-routing-title-text
            text: "Routing"
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
                        text: Hostname
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}.{reqsJsonPath[0]['.items.0.metadata.namespace']['-']}.svc.cluster.local"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: ClusterIP
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.clusterIP']['None']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Load balancer IP
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.status.loadBalancer.ingress[0].ip']['Not assigned']}"

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
                        text: External name
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.externalName']['Not configured']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: External IPs
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.externalIPs']['Not configured']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Pod selector
                        strong: true
                    - type: LabelsToSearchParams
                      data:
                        id: service-pod-selector
                        reqIndex: 0
                        jsonPathToLabels: ".items.0.spec.selector"
                        linkPrefix: "/openapi-ui/{2}/{3}/search?kinds=~v1~pods"
                        errorText: "No selector"
                        textLink: Search
                        renderLabelsAsRows: true

    - type: antdFlex
      data:
        vertical: true
        gap: 8
      children:
        - type: antdText
          data:
            text: Service ports
            strong: true
        - type: EnrichedTable
          data:
            id: service-port-mapping-table
            cluster: "{2}"
            customizationId: "factory-service-details-port-mapping"
            baseprefix: /openapi-ui
            withoutControls: true
            pathToItems: ".items.0.spec.ports"
            k8sResourceToFetch:
              {{- toYaml .k8sResourceToFetch | nindent 14 }}
            fieldSelector:
              {{- toYaml .fieldSelector | nindent 14 }}

    # Endpoint slices are relevant only when Service has selectors
    - type: VisibilityContainer
      data:
        id: service-endpoints-visibility
        value: "{reqsJsonPath[0]['.items.0.spec.selector']['-']}"
        style:
          margin: 0
          padding: 0
      children:
        - type: antdFlex
          data:
            vertical: true
            gap: 8
          children:
            - type: antdText
              data:
                text: Pod serving
                strong: true
            - type: EnrichedTable
              data:
                id: service-endpoints-table
                cluster: "{2}"
                customizationId: "factory-service-details-endpointslice"
                baseprefix: /openapi-ui
                withoutControls: true
                labelSelector:
                  kubernetes.io/service-name: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
                pathToItems: ".items[*].endpoints"
                k8sResourceToFetch:
                  apiGroup: "discovery.k8s.io"
                  apiVersion: "v1"
                  namespace: "{3}"
                  plural: "endpointslices"
{{- end -}}
