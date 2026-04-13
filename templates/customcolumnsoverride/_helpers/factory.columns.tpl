{{/*
  CCO factory column helpers: YAML fragments (props) and full factory columns for CustomColumnsOverride tables.
*/}}
{{/*
  badgeLink: resource badge with a clickable link to the resource detail page.
  root — Helm root / factory context (badge mapping, Navigation); href — detail URL template with placeholders;
  badge — badge label; jsonPath — JSONPath into the row payload for the cell; text — link label override.
  href+root → resolveFromLegacy; root only (no href) → factoryDetails (mappingKey + baseFactoriesMapping).
*/}}
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
# JSONPath into row/API payload for this column
jsonPath: {{ default ".metadata.name" $ctx.jsonPath }}
{{ include "in-cloud.web.columns.factory.badgeLink" (dict
    "badge" $badge
    "href" $href
    "text" (default "{reqsJsonPath[0]['.metadata.name']['-']}" $ctx.text)
  )
}}
{{- end -}}

{{/*
  namespaceBadgeLink: same as badgeLink, fixed for the Namespace column.
  href — /openapi-ui/{2}/factory/namespace-details/v1/namespaces/{namespace}; {2} is the cluster segment in the UI path.
*/}}
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

{{/*
  labelsEditor: editable labels column.
  endpoint — PATCH target; linkPrefix — base path for label navigation; reqIndex — index in parallel fetch responses;
  jsonPathToLabels — path to the labels map; pathToValue — JSON patch path for persisted updates.
*/}}
{{- define "in-cloud.web.cco.props.labelsEditor" -}}
jsonPath: .metadata.labels
customProps:
  disableEventBubbling: true
  items:
    - type: Labels
      data:
        id: labels-editor
        # index into parallel fetch responses (row is reqsJsonPath[0])
        reqIndex: 0
        # JSONPath to labels object for display/edit
        jsonPathToLabels: .metadata.labels
        # PATCH URL for label updates
        endpoint: {{ .endpoint | quote }}
        # JSON patch path sent with the request body
        pathToValue: /metadata/labels
        # navigation prefix when following a label
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

{{/*
  podSelector: pod selector as chips with search navigation.
  jsonPath — field path to the selector on the row; linkPrefix — base path for “search by label” navigation.
*/}}
{{- define "in-cloud.web.cco.props.podSelector" -}}
jsonPath: {{ .jsonPath }}
customProps:
  disableEventBubbling: true
  items:
    - type: LabelsToSearchParams
      data:
        id: pod-to-search-params
        reqIndex: 0
        # same path: selector labels → query params
        jsonPathToLabels: {{ .jsonPath }}
        linkPrefix: {{ .linkPrefix | quote }}
        errorText: No selector
        maxTextLength: 11
        # textLink: Search
        renderLabelsAsRows: true
        errorMode: 'default'
{{- end -}}

{{/*
  created: creation timestamp column; implementation uses factory.created (parsedText formatter: timestamp on creationTimestamp).
*/}}
{{- define "in-cloud.web.cco.props.created" -}}
jsonPath: .metadata.creationTimestamp
{{ include "in-cloud.web.columns.factory.created" . }}
{{- end -}}

{{/*
  timestamp: generic timestamp cell; formatter — timestamp on parsedText; .jsonPath / .value — source path or literal.
*/}}
{{- define "in-cloud.web.cco.props.timestamp" -}}
jsonPath: {{ .jsonPath }}
customProps:
  disableEventBubbling: true
  items:
    {{- /* antdFlex: horizontal row for icon + time */}}
    - type: antdFlex
      data:
        id: time-block
        align: center
        gap: 6
      children:
        {{- /* antdText: leading icon */}}
        - type: antdText
          data:
            id: time-icon
            text: "\U0001F310"
        - type: parsedText
          data:
            id: time-value
            # platform format for RFC3339-style instants
            formatter: timestamp
            text: {{ .value | quote }}
{{- end -}}

{{/*
  text: plain parsedText column; jsonPath — row field; value — default text or placeholder.
*/}}
{{- define "in-cloud.web.cco.props.text" -}}
jsonPath: {{ .jsonPath }}
{{ include "in-cloud.web.columns.factory.text" (dict
    "value" .value
  )
}}
{{- end -}}

{{/*
  link: simple hyperlink column; jsonPath — cell value path; link — href; text — anchor label.
*/}}
{{- define "in-cloud.web.cco.props.link" -}}
jsonPath: {{ default ".metadata.name" .jsonPath }}
{{ include "in-cloud.web.columns.factory.link" (dict
    "link" .link
    "text" .text
  )
}}
{{- end -}}

{{/* memory: numeric/memory column via factory.memory helper. */}}
{{- define "in-cloud.web.cco.props.memory" -}}
{{ include "in-cloud.web.columns.factory.memory" (dict
    "value" .value
  )
}}
{{- end -}}

{{/* cpu: CPU usage column via factory.cpu helper. */}}
{{- define "in-cloud.web.cco.props.cpu" -}}
{{ include "in-cloud.web.columns.factory.cpu" (dict
    "value" .value
  )
}}
{{- end -}}

{{/*
  ownerRefs: owner reference links with factory resolution.
  jsonPathToArrayOfRefs — JSONPath to the ownerReferences array; forcedNamespace — override namespace for link targets;
  forcedApiVersion — map of group/version hints when resolving refs to detail pages.
*/}}
{{- define "in-cloud.web.cco.props.ownerRefs" -}}
jsonPath: {{ default .jsonPathToArrayOfRefs .jsonPath }}
customProps:
  disableEventBubbling: true
  items:
    - type: OwnerRefs
      data:
        id: refs
        reqIndex: 0
        # cluster segment in UI paths (same as {2} elsewhere)
        cluster: {{ default "{2}" .cluster | quote }}
        baseprefix: {{ default "/openapi-ui" .baseprefix }}
        {{- if not .skipForcedNamespace }}
        # default: row namespace
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

{{/*
  statusDeployment: deployment status column; delegates to
  in-cloud.web.statusText.deploymentAvailability.
*/}}
{{- define "in-cloud.web.cco.props.statusDeployment" -}}
customProps:
  disableEventBubbling: true
  items:
    {{ include "in-cloud.web.statusText.deploymentAvailability" (dict
        "itemPath" ""
      ) | nindent 4
    }}
{{- end -}}

{{/* statusJob: job status column; delegates to in-cloud.web.statusText.jobAvailability. */}}
{{- define "in-cloud.web.cco.props.statusJob" -}}
customProps:
  disableEventBubbling: true
  items:
    {{ include "in-cloud.web.statusText.jobAvailability" (dict
        "itemPath" ""
      ) | nindent 4
    }}
{{- end -}}

{{/* statusPod: pod status column; delegates to in-cloud.web.statusText.podAvailability. */}}
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
# Standard Deployment status column (statusText.deploymentAvailability)
- name: Status
  type: factory
  {{ include "in-cloud.web.cco.props.statusDeployment" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.statusJob" -}}
# Standard Job status column (statusText.jobAvailability)
- name: Status
  type: factory
  {{ include "in-cloud.web.cco.props.statusJob" . | nindent 2 }}
{{- end -}}

{{- define "in-cloud.web.cco.column.statusPod" -}}
# Standard Pod status column (statusText.podAvailability)
- name: Status
  type: factory
  {{ include "in-cloud.web.cco.props.statusPod" . | nindent 2 }}
{{- end -}}
