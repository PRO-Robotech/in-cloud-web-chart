{{/*
  Generic ContentCard helpers: EnrichedTable-backed lists and container tables.
  AntD: optional card margin; list headers often use DefaultDiv flex rows (see genericContainersTableCard).
*/}}
{{- define "in-cloud.web.contentCard.genericResourceListCard" -}}
- type: ContentCard
  data:
    id: {{ .cardId }}
    # AntD: card spacing
    style:
      marginBottom: 24px
  children:
    - type: EnrichedTable
      data:
        id: {{ .tableId }}
        baseprefix: /openapi-ui
        # Target cluster for list fetch
        cluster: "{2}"
        # CCO id: table columns/presentation for this resource list
        customizationId: {{ .customizationId | quote }}

        # Kubernetes API object to list (group/version/plural[, namespace])
        k8sResourceToFetch:
          {{- if .apiGroup }}
          apiGroup: {{ .apiGroup | quote }}
          {{- end }}
          apiVersion: {{ .apiVersion | quote }}
          plural: {{ .plural | quote }}
          {{- if .ifNamespaced }}
          # Namespace for namespaced list API calls
          namespace: "{3}"
          {{- end }}

        dataForControls:
          # Cluster for table control actions (same target as list)
          cluster: "{2}"
          {{- if .apiGroup }}
          apiGroup: {{ .apiGroup | quote }}
          {{- end }}
          apiVersion: {{ .apiVersion | quote }}
          plural: {{ .plural | quote }}
          {{- if .ifNamespaced }}
          # Namespace for control actions on namespaced resources
          namespace: "{3}"
          {{- end }}

        # Label selector (optional, from parent resource podTemplate.labels)
        {{- with .labelSelectorFull }}
        labelSelectorFull:
          {{- toYaml . | nindent 10 }}
        {{- end }}

        # Field selector (optional)
        {{- with .fieldSelector }}
        fieldSelector:
          {{- toYaml . | nindent 10 }}
        {{- end }}

        # Path to items list in the response
        pathToItems: ".items"

        additionalReqsDataToEachItem:
          - 1
{{- end -}}

{{- define "in-cloud.web.contentCard.genericContainersTableCard" -}}
- type: ContentCard
  data:
    id: {{ .cardId }}
    title: {{ .title | quote }}
  children:

    # =========================
    # Header: icon + title
    # =========================
    - type: DefaultDiv
      data:
        id: {{ .titleRowId }}
        # AntD: flex row (icon + title)
        style:
          display: flex
          gap: 12px
          marginBottom: 12px
          alignItems: center
      children:
        - type: antdIcons
          data:
            id: {{ .iconId }}
            iconName: AppstoreOutlined
            iconProps:
              size: 24
              color: token.colorInfo
              style:
                fontSize: 24
                color: token.colorInfo

        - type: antdText
          data:
            id: {{ .titleTextId }}
            text: {{ .title | quote }}
            style:
              fontSize: 16px
              lineHeight: 24px

    # =========================
    # Table (full width)
    # =========================
    - type: EnrichedTable
      data:
        id: {{ .tableId }}
        # Target cluster for table data fetch
        cluster: "{2}"
        # CCO id: table columns/presentation for containers
        customizationId: {{ .customizationId | quote }}
        baseprefix: "/openapi-ui"
        withoutControls: true
        pathToItems: {{ .pathToItems }}
        pathToKey: .name
        # Kubernetes API object that holds the container list
        k8sResourceToFetch:
          {{- toYaml .k8sResourceToFetch | nindent 10 }}
        # Field selector: pin table to a single resource (e.g. by metadata.name)
        fieldSelector:
          metadata.name: {{ .nameFieldSelector | quote }}
        additionalReqsDataToEachItem:
          - 1
{{- end -}}

{{- define "in-cloud.web.contentCard.genericVisibilityInclude" -}}
{{- $includeContext := default (dict) .includeContext }}
- type: VisibilityContainer
  data:
    id: {{ .containerId }}
    value: {{ .value | quote }}
    {{- if .withResetSpacing }}
    style:
      margin: 0
      padding: 0
    {{- end }}
  children:
    {{ include .includeTemplate $includeContext | nindent 4 }}
{{- end -}}
