{{- define "in-cloud.web.cco.props.badgeLink" -}}
{{- $ctx := . -}}
{{- if kindIs "slice" . -}}
{{- $root := index . 0 -}}
{{- $href := index . 1 -}}
{{- $options := dict -}}
{{- if gt (len .) 2 -}}
{{- $options = index . 2 -}}
{{- end -}}
{{- $ctx = merge (dict
    "root" $root
    "href" $href
  ) $options
-}}
{{- end -}}
{{- $columnName := default "Name" $ctx.name -}}
{{- $badge := $ctx.badge -}}
{{- $href := $ctx.href -}}
{{- if eq $columnName "Name" -}}
{{- $badge = "{reqsJsonPath[0]['.kind']['-']}" -}}
{{- end -}}
{{- if and $href $ctx.root -}}
{{- $href = (include "in-cloud.web.cco.href.resolveFromLegacy" (dict
    "root" $ctx.root
    "href" $href
  ) | trim)
}}
{{- else if and (not $href) $ctx.root -}}
{{- $href = (include "in-cloud.web.cco.href.factoryDetails" $ctx | trim) -}}
{{- end -}}
jsonPath: {{ default ".metadata.name" $ctx.jsonPath }}
{{ include "in-cloud.web.columns.factory.badgeLink" (dict
    "badge" $badge
    "href" $href
    "text" (default "{reqsJsonPath[0]['.metadata.name']['-']}" $ctx.text)
  )
}}
{{- end -}}

{{- define "in-cloud.web.cco.props.namespaceBadgeLink" -}}
{{ include "in-cloud.web.cco.props.badgeLink" (dict
    "root" $
    "name" "Namespace"
    "jsonPath" ".metadata.namespace"
    "badge" "Namespace"
    "href" "/openapi-ui/{2}/factory/namespace-details/v1/namespaces/{reqsJsonPath[0]['.metadata.namespace']['-']}"
    "text" "{reqsJsonPath[0]['.metadata.namespace']['-']}"
  )
}}
{{- end -}}

{{- define "in-cloud.web.cco.props.labelsEditor" -}}
jsonPath: .metadata.labels
customProps:
  disableEventBubbling: true
  items:
    - type: Labels
      data:
        id: labels-editor
        reqIndex: 0
        jsonPathToLabels: .metadata.labels
        endpoint: {{ .endpoint | quote }}
        pathToValue: /metadata/labels
        linkPrefix: {{ .linkPrefix | quote }}
        inputLabel: "false"
        modalTitle: Edit labels
        modalDescriptionText: ""
        editModalWidth: 650
        maxEditTagTextLength: 35
        paddingContainerEnd: 24px
        notificationSuccessMessage: Updated successfully
        notificationSuccessMessageDescription: Labels have been updated
        selectProps:
          maxTagTextLength: 35
        readOnly: true
        verticalViewList: true
{{- end -}}

{{- define "in-cloud.web.cco.props.podSelector" -}}
jsonPath: {{ .jsonPath }}
customProps:
  disableEventBubbling: true
  items:
    - type: LabelsToSearchParams
      data:
        id: pod-to-search-params
        reqIndex: 0
        jsonPathToLabels: {{ .jsonPath }}
        linkPrefix: {{ .linkPrefix | quote }}
        errorText: No selector
        maxTextLength: 11
        # textLink: Search
        renderLabelsAsRows: true
        errorMode: 'default'
{{- end -}}

{{- define "in-cloud.web.cco.props.created" -}}
jsonPath: .metadata.creationTimestamp
{{ include "in-cloud.web.columns.factory.created" . }}
{{- end -}}

{{- define "in-cloud.web.cco.props.timestamp" -}}
jsonPath: {{ .jsonPath }}
customProps:
  disableEventBubbling: true
  items:
    - type: antdFlex
      data:
        id: time-block
        align: center
        gap: 6
      children:
        - type: antdText
          data:
            id: time-icon
            text: "\U0001F310"
        - type: parsedText
          data:
            id: time-value
            formatter: timestamp
            text: {{ .value | quote }}
{{- end -}}

{{- define "in-cloud.web.cco.props.text" -}}
jsonPath: {{ .jsonPath }}
{{ include "in-cloud.web.columns.factory.text" (dict
    "value" .value
  )
}}
{{- end -}}

{{- define "in-cloud.web.cco.props.link" -}}
jsonPath: {{ default ".metadata.name" .jsonPath }}
{{ include "in-cloud.web.columns.factory.link" (dict
    "link" .link
    "text" .text
  )
}}
{{- end -}}

{{- define "in-cloud.web.cco.props.memory" -}}
{{ include "in-cloud.web.columns.factory.memory" (dict
    "value" .value
  )
}}
{{- end -}}

{{- define "in-cloud.web.cco.props.cpu" -}}
{{ include "in-cloud.web.columns.factory.cpu" (dict
    "value" .value
  )
}}
{{- end -}}

{{- define "in-cloud.web.cco.props.ownerRefs" -}}
jsonPath: {{ default .jsonPathToArrayOfRefs .jsonPath }}
customProps:
  disableEventBubbling: true
  items:
    - type: OwnerRefs
      data:
        id: refs
        reqIndex: 0
        cluster: {{ default "{2}" .cluster | quote }}
        baseprefix: {{ default "/openapi-ui" .baseprefix }}
        {{- if not .skipForcedNamespace }}
        forcedNamespace: {{ default "{reqsJsonPath[0]['.metadata.namespace']['-']}" .forcedNamespace | quote }}
        {{- end }}
        {{- with .forcedApiVersion }}
        forcedApiVersion:
{{ toYaml . | indent 10 }}
        {{- end }}
        jsonPathToArrayOfRefs: {{ .jsonPathToArrayOfRefs }}
        errorText: error getting refs
        notArrayErrorText: refs on path are not arr
        emptyArrayErrorText: "-"
        isNotRefsArrayErrorText: objects in arr are not refs
        baseFactoryClusterSceopedAPIKey: base-factory-clusterscoped-api
        baseFactoryClusterSceopedBuiltinKey: base-factory-clusterscoped-builtin
        baseFactoryNamespacedAPIKey: base-factory-namespaced-api
        baseFactoryNamespacedBuiltinKey: base-factory-namespaced-builtin
        baseNamespaceFactoryKey: namespace-details
        baseNavigationPlural: navigations
        baseNavigationName: navigation
{{- end -}}

{{- define "in-cloud.web.cco.props.statusDeployment" -}}
customProps:
  disableEventBubbling: true
  items:
    {{ include "in-cloud.web.statusText.deploymentAvailability" (dict
        "itemPath" ""
      ) | nindent 4
    }}
{{- end -}}

{{- define "in-cloud.web.cco.props.statusJob" -}}
customProps:
  disableEventBubbling: true
  items:
    {{ include "in-cloud.web.statusText.jobAvailability" (dict
        "itemPath" ""
      ) | nindent 4
    }}
{{- end -}}

{{- define "in-cloud.web.cco.props.statusPod" -}}
customProps:
  disableEventBubbling: true
  items:
    {{ include "in-cloud.web.statusText.podAvailability" (dict
        "itemPath" ""
      ) | nindent 4
    }}
{{- end -}}

{{- define "in-cloud.web.cco.column.badgeLink" -}}
# Generic factory column with badge + link renderer
- name: {{ default "Name" .name }}
  type: factory
  {{ include "in-cloud.web.cco.props.badgeLink" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.namespaceBadgeLink" -}}
# Standard Namespace badge-link column
- name: Namespace
  type: factory
  {{ include "in-cloud.web.cco.props.namespaceBadgeLink" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.labelsEditor" -}}
# Standard editable labels column
- name: Labels
  type: factory
  {{ include "in-cloud.web.cco.props.labelsEditor" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.podSelector" -}}
# Standard pod selector search column
- name: Pod Selector
  type: factory
  {{ include "in-cloud.web.cco.props.podSelector" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.created" -}}
# Standard creation timestamp column
- name: Created
  type: factory
  {{ include "in-cloud.web.cco.props.created" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.text" -}}
# Generic parsedText-based factory column
- name: {{ .name }}
  type: factory
  {{ include "in-cloud.web.cco.props.text" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.memory" -}}
# Generic memory usage column
- name: {{ default "Memory" .name }}
  type: factory
  {{ include "in-cloud.web.cco.props.memory" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.cpu" -}}
# Generic CPU usage column
- name: {{ default "CPU" .name }}
  type: factory
  {{ include "in-cloud.web.cco.props.cpu" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.ownerRefs" -}}
# Generic OwnerRefs-based factory column
- name: {{ .name }}
  type: factory
  {{ include "in-cloud.web.cco.props.ownerRefs" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.statusDeployment" -}}
# Standard Deployment status column
- name: Status
  type: factory
  {{ include "in-cloud.web.cco.props.statusDeployment" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.statusJob" -}}
# Standard Job status column
- name: Status
  type: factory
  {{ include "in-cloud.web.cco.props.statusJob" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.statusPod" -}}
# Standard Pod status column
- name: Status
  type: factory
  {{ include "in-cloud.web.cco.props.statusPod" . | nindent 2 }}
{{- end -}}
