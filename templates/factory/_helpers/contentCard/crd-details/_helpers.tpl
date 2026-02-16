{{- define "in-cloud.web.contentCard.crdRuntimeFacts" -}}
# Content card with CRD runtime facts
- type: ContentCard
  data:
    id: crd-runtime-facts-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: crd-runtime-facts-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: crd-runtime-facts-icon
            iconName: InfoCircleOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: crd-runtime-facts-title-text
            text: "CRD Facts"
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
                        text: Group
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.group']['Not reported']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Scope
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.scope']['Not reported']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Kind
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.names.kind']['Not reported']}"

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
                        text: Plural
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.spec.names.plural']['Not reported']}"

                - type: antdFlex
                  data:
                    vertical: true
                    gap: 4
                  children:
                    - type: antdText
                      data:
                        text: Latest Stored Version
                        strong: true
                    - type: parsedText
                      data:
                        text: "{reqsJsonPath[0]['.items.0.status.storedVersions[0]']['Not reported']}"
{{- end -}}

{{- define "in-cloud.web.contentCard.crdVersionsTable" -}}
# Content card with CRD versions table
- type: ContentCard
  data:
    id: crd-versions-card
  children:
    # Card title with icon
    - type: DefaultDiv
      data:
        id: crd-versions-title
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: crd-versions-icon
            iconName: BranchesOutlined
            iconProps:
              size: 24
              style:
                fontSize: 24
                color: token.colorInfo
        - type: antdText
          data:
            id: crd-versions-title-text
            text: "Versions"
            style:
              fontSize: 16px
              lineHeight: 24px

    - type: EnrichedTable
      data:
        id: crd-versions-table
        cluster: "{2}"
        customizationId: versions-apiextensions.k8s.io.v1.customresourcedefinitions
        baseprefix: /openapi-ui
        withoutControls: true
        pathToItems: ".items.0.spec.versions"
        k8sResourceToFetch:
          {{- toYaml .k8sResourceToFetch | nindent 10 }}
        fieldSelector:
          {{- toYaml .fieldSelector | nindent 10 }}
{{- end -}}

{{- define "in-cloud.web.contentCard.crdInstancesTable" -}}
# Content card with list of instances for selected CRD
- type: ContentCard
  data:
    id: crd-instances-card
    title: Instances
  children:
    - type: EnrichedTable
      data:
        id: instances-table
        cluster: "{2}"
        customizationId: instances-crd
        baseprefix: /openapi-ui
        pathToItems: ".items"
        dataForControls:
          plural: "{reqsJsonPath[0]['.items.0.spec.names.plural']['-']}"
          apiVersion: "{reqsJsonPath[0]['.items.0.status.storedVersions[0]']['-']}"
          apiGroup: "{reqsJsonPath[0]['.items.0.spec.group']['-']}"
        k8sResource:
          plural: "{reqsJsonPath[0]['.items.0.spec.names.plural']['-']}"
          apiVersion: "{reqsJsonPath[0]['.items.0.status.storedVersions[0]']['-']}"
          apiGroup: "{reqsJsonPath[0]['.items.0.spec.group']['-']}"
        k8sResourceToFetch:
          plural: "{reqsJsonPath[0]['.items.0.spec.names.plural']['-']}"
          apiVersion: "{reqsJsonPath[0]['.items.0.status.storedVersions[0]']['-']}"
          apiGroup: "{reqsJsonPath[0]['.items.0.spec.group']['-']}"
{{- end -}}
