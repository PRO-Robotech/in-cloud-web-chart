{{- define "in-cloud.web.action.edit" -}}
- type: edit
  props:
    # =========================
    # UI metadata
    # =========================
    text: Edit
    icon: EditOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API target (resource addressing)
    # =========================
    {{- with .k8sResourceToFetch }}
    {{ toYaml . | nindent 4 }}
    {{- end }}

    # =========================
    # Target resource identity
    # =========================
    {{- if not (and (kindIs "map" .k8sResourceToFetch) (hasKey .k8sResourceToFetch "name")) }}
    name: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
    {{- end }}

    # =========================
    # Navigation prefix
    # =========================
    baseprefix: /openapi-ui
{{- end -}}

{{- define "in-cloud.web.action.editLabels" -}}
- type: editLabels
  props:
    # =========================
    # UI metadata
    # =========================
    text: Edit Labels
    icon: TagsOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Data binding
    # =========================
    reqIndex: "0"
    jsonPathToLabels: ".items.0.metadata.labels"

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/metadata/labels"

    # =========================
    # Modal configuration
    # =========================
    modalTitle: Edit Labels
    editModalWidth: 650
    paddingContainerEnd: "24px"
    maxEditTagTextLength: 35
{{- end -}}

{{- define "in-cloud.web.action.editAnnotations" -}}
- type: editAnnotations
  props:
    # =========================
    # UI metadata
    # =========================
    text: Edit Annotations
    icon: FileTextOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Data binding
    # =========================
    reqIndex: "0"
    jsonPathToObj: ".items.0.metadata.annotations"

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/metadata/annotations"

    # =========================
    # Modal configuration
    # =========================
    modalTitle: Edit Annotations
    cols: [11, 11, 2]
    editModalWidth: 800px
{{- end -}}

{{- define "in-cloud.web.action.delete" -}}
- type: delete
  props:
    # =========================
    # UI metadata
    # =========================
    text: Delete
    icon: DeleteOutlined
    danger: true

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Target resource identity
    # =========================
    name: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"

    # =========================
    # Post-delete redirect (parameterized)
    # =========================
    redirectTo: {{ .redirectTo | quote }}
{{- end -}}

{{- define "in-cloud.web.action.editTaints" -}}
- type: editTaints
  props:
    # =========================
    # UI metadata
    # =========================
    text: Edit Taints

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Data binding
    # =========================
    reqIndex: "0"
    jsonPathToArray: ".items.0.spec.taints"

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/spec/taints"

    # =========================
    # Modal configuration
    # =========================
    modalTitle: Edit Taints
    cols: [8, 8, 6]
    editModalWidth: 800px

    # =========================
    # Icon
    # =========================
    iconBase64Encoded: PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTE4LjgxNDcgMTguMjE5NUMxOS45ODUyIDE4LjIxOTUgMjAuOTQxNSAxNy4yNDk5IDIwLjk0MTUgMTYuMDYzM0MyMC45NDE1IDE0LjYzMDIgMTguODE0NyAxMi4yOTE4IDE4LjgxNDcgMTIuMjkxOEMxOC44MTQ3IDEyLjI5MTggMTYuNjg3OSAxNC42MzAyIDE2LjY4NzkgMTYuMDYzM0MxNi42ODc5IDE3LjI0OTkgMTcuNjQ0MiAxOC4yMTk1IDE4LjgxNDcgMTguMjE5NVpNOC43MTM4MSAxNy4wMzgzQzguOTAzOTkgMTcuMjI4NSA5LjIxMjAzIDE3LjIyODUgOS4zOTk1MyAxNy4wMzgzTDE2LjI1OTMgMTAuMTgxMUMxNi40NDk1IDkuOTkwOTUgMTYuNDQ5NSA5LjY4MjkyIDE2LjI1OTMgOS40OTU0Mkw5LjQwMjIgMi42MzgyN0M5LjM4NjEzIDIuNjIyMiA5LjM2NzM4IDIuNjA2MTMgOS4zNDg2MyAyLjU5Mjc0TDcuMjUzOTkgMC40OTgwOTRDNy4yMDgzMiAwLjQ1MzAxMiA3LjE0NjczIDAuNDI3NzM0IDcuMDgyNTYgMC40Mjc3MzRDNy4wMTgzOSAwLjQyNzczNCA2Ljk1NjggMC40NTMwMTIgNi45MTExMyAwLjQ5ODA5NEw1LjYyNTQyIDEuNzgzODFDNS41ODAzNCAxLjgyOTQ4IDUuNTU1MDYgMS44OTEwNyA1LjU1NTA2IDEuOTU1MjRDNS41NTUwNiAyLjAxOTQxIDUuNTgwMzQgMi4wODEgNS42MjU0MiAyLjEyNjY3TDcuNDI1NDIgMy45MjY2N0wxLjg1OTM1IDkuNDk1NDJDMS42NjkxNyA5LjY4NTYgMS42NjkxNyA5Ljk5MzYzIDEuODU5MzUgMTAuMTgxMUw4LjcxMzgxIDE3LjAzODNaTTkuMDU5MzUgNS4wMjIyTDEzLjg1MTMgOS44MTQxN0g0LjI3MDA2TDkuMDU5MzUgNS4wMjIyWk0yMi41MDA0IDIwLjE0MDFIMS41MDA0MkMxLjM4MjU2IDIwLjE0MDEgMS4yODYxMyAyMC4yMzY1IDEuMjg2MTMgMjAuMzU0M1YyMi40OTcyQzEuMjg2MTMgMjIuNjE1MSAxLjM4MjU2IDIyLjcxMTUgMS41MDA0MiAyMi43MTE1SDIyLjUwMDRDMjIuNjE4MyAyMi43MTE1IDIyLjcxNDcgMjIuNjE1MSAyMi43MTQ3IDIyLjQ5NzJWMjAuMzU0M0MyMi43MTQ3IDIwLjIzNjUgMjIuNjE4MyAyMC4xNDAxIDIyLjUwMDQgMjAuMTQwMVoiIGZpbGw9e3Rva2VuLmNvbG9yVGV4dH0vPgo8L3N2Zz4K
{{- end -}}

{{- define "in-cloud.web.action.cordon" -}}
- type: cordon
  props:
    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # UI metadata
    # =========================
    icon: StopOutlined
    text: Cordon

    # =========================
    # Patch configuration
    # =========================
    pathToValue: /spec/unschedulable
    value: true

    # =========================
    # Visibility rules
    # =========================
    visibleWhen:
      criteria: notEquals
      value: "{reqsJsonPath[0]['.items.0.spec.unschedulable']['-']}"
      valueToCompare: "true"
{{- end -}}

{{- define "in-cloud.web.action.uncordon" -}}
- type: uncordon
  props:
    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # UI metadata
    # =========================
    icon: CheckCircleOutlined
    text: Uncordon

    # =========================
    # Patch configuration
    # =========================
    pathToValue: /spec/unschedulable
    value: false

    # =========================
    # Visibility rules
    # =========================
    visibleWhen:
      criteria: equals
      value: "{reqsJsonPath[0]['.items.0.spec.unschedulable']['-']}"
      valueToCompare: "true"
{{- end -}}

{{- define "in-cloud.web.action.openKubeletConfig" -}}
- type: openKubeletConfig
  props:
    # =========================
    # UI metadata
    # =========================
    icon: SettingOutlined
    target: _blank
    text: Kubelet Config

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Target URL (parameterized)
    # =========================
    url: {{ .url | quote }}
{{- end -}}


{{- define "in-cloud.web.action.suspend" -}}
- type: suspend
  props:
    # =========================
    # UI metadata
    # =========================
    text: Suspend
    icon: PauseCircleOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/spec/paused"
    value: true

    # =========================
    # Visibility rules
    # =========================
    visibleWhen:
      criteria: notEquals
      value: "{reqsJsonPath[0]['.items.0.spec.paused']['-']}"
      valueToCompare: "true"
{{- end -}}


{{- define "in-cloud.web.action.resume" -}}
- type: resume
  props:
    # =========================
    # UI metadata
    # =========================
    text: Resume
    icon: PlayCircleOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/spec/paused"
    value: false

    # =========================
    # Visibility rules
    # =========================
    visibleWhen:
      criteria: equals
      value: "{reqsJsonPath[0]['.items.0.spec.paused']['-']}"
      valueToCompare: "true"
{{- end -}}


{{- define "in-cloud.web.action.scale" -}}
- type: scale
  props:
    # =========================
    # UI metadata
    # =========================
    text: Scale
    icon: ColumnHeightOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Scale configuration
    # =========================
    currentReplicas: "{reqsJsonPath[0]['.items.0.spec.replicas']['-']}"
    name: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
    namespace: "{3}"
    apiVersion: "autoscaling/v1"
{{- end -}}


{{- define "in-cloud.web.action.rolloutRestart" -}}
- type: rolloutRestart
  props:
    # =========================
    # UI metadata
    # =========================
    text: Rollout Restart
    icon: ReloadOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}
{{- end -}}


{{- define "in-cloud.web.action.evict" -}}
- type: evict
  props:
    # =========================
    # UI metadata
    # =========================
    text: Evict
    icon: DisconnectOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Eviction target
    # =========================
    endpoint: {{ .endpoint | quote }}
    name: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
    namespace: "{3}"
    apiVersion: "policy/v1"
    gracePeriodSeconds: 30
{{- end -}}


{{- define "in-cloud.web.action.editTolerations" -}}
- type: editTolerations
  props:
    # =========================
    # UI metadata
    # =========================
    text: Edit Tolerations

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Data binding
    # =========================
    reqIndex: "0"
    jsonPathToArray: ".items.0.spec.tolerations"

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/spec/tolerations"

    # =========================
    # Modal configuration
    # =========================
    modalTitle: Edit Tolerations
    cols: [8, 8, 6]
    editModalWidth: 800px

    # =========================
    # Icon
    # =========================
    iconBase64Encoded: PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTE4LjgxNDcgMTguMjE5NUMxOS45ODUyIDE4LjIxOTUgMjAuOTQxNSAxNy4yNDk5IDIwLjk0MTUgMTYuMDYzM0MyMC45NDE1IDE0LjYzMDIgMTguODE0NyAxMi4yOTE4IDE4LjgxNDcgMTIuMjkxOEMxOC44MTQ3IDEyLjI5MTggMTYuNjg3OSAxNC42MzAyIDE2LjY4NzkgMTYuMDYzM0MxNi42ODc5IDE3LjI0OTkgMTcuNjQ0MiAxOC4yMTk1IDE4LjgxNDcgMTguMjE5NVpNOC43MTM4MSAxNy4wMzgzQzguOTAzOTkgMTcuMjI4NSA5LjIxMjAzIDE3LjIyODUgOS4zOTk1MyAxNy4wMzgzTDE2LjI1OTMgMTAuMTgxMUMxNi40NDk1IDkuOTkwOTUgMTYuNDQ5NSA5LjY4MjkyIDE2LjI1OTMgOS40OTU0Mkw5LjQwMjIgMi42MzgyN0M5LjM4NjEzIDIuNjIyMiA5LjM2NzM4IDIuNjA2MTMgOS4zNDg2MyAyLjU5Mjc0TDcuMjUzOTkgMC40OTgwOTRDNy4yMDgzMiAwLjQ1MzAxMiA3LjE0NjczIDAuNDI3NzM0IDcuMDgyNTYgMC40Mjc3MzRDNy4wMTgzOSAwLjQyNzczNCA2Ljk1NjggMC40NTMwMTIgNi45MTExMyAwLjQ5ODA5NEw1LjYyNTQyIDEuNzgzODFDNS41ODAzNCAxLjgyOTQ4IDUuNTU1MDYgMS44OTEwNyA1LjU1NTA2IDEuOTU1MjRDNS41NTUwNiAyLjAxOTQxIDUuNTgwMzQgMi4wODEgNS42MjU0MiAyLjEyNjY3TDcuNDI1NDIgMy45MjY2N0wxLjg1OTM1IDkuNDk1NDJDMS42NjkxNyA5LjY4NTYgMS42NjkxNyA5Ljk5MzYzIDEuODU5MzUgMTAuMTgxMUw4LjcxMzgxIDE3LjAzODNaTTkuMDU5MzUgNS4wMjIyTDEzLjg1MTMgOS44MTQxN0g0LjI3MDA2TDkuMDU5MzUgNS4wMjIyWk0yMi41MDA0IDIwLjE0MDFIMS41MDA0MkMxLjM4MjU2IDIwLjE0MDEgMS4yODYxMyAyMC4yMzY1IDEuMjg2MTMgMjAuMzU0M1YyMi40OTcyQzEuMjg2MTMgMjIuNjE1MSAxLjM4MjU2IDIyLjcxMTUgMS41MDA0MiAyMi43MTE1SDIyLjUwMDRDMjIuNjE4MyAyMi43MTE1IDIyLjcxNDcgMjIuNjE1MSAyMi43MTQ3IDIyLjQ5NzJWMjAuMzU0M0MyMi43MTQ3IDIwLjIzNjUgMjIuNjE4MyAyMC4xNDAxIDIyLjUwMDQgMjAuMTQwMVoiIGZpbGw9e3Rva2VuLmNvbG9yVGV4dH0vPgo8L3N2Zz4K
{{- end -}}


{{- define "in-cloud.web.action.cronJobSuspend" -}}
- type: suspend
  props:
    # =========================
    # UI metadata
    # =========================
    text: Suspend
    icon: PauseCircleOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/spec/suspend"
    value: true

    # =========================
    # Visibility rules
    # =========================
    visibleWhen:
      criteria: notEquals
      value: "{reqsJsonPath[0]['.items.0.spec.suspend']['-']}"
      valueToCompare: "true"
{{- end -}}


{{- define "in-cloud.web.action.cronJobResume" -}}
- type: resume
  props:
    # =========================
    # UI metadata
    # =========================
    text: Resume
    icon: PlayCircleOutlined

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # API endpoint (parameterized)
    # =========================
    endpoint: {{ .endpoint | quote }}

    # =========================
    # Patch configuration
    # =========================
    pathToValue: "/spec/suspend"
    value: false

    # =========================
    # Visibility rules
    # =========================
    visibleWhen:
      criteria: equals
      value: "{reqsJsonPath[0]['.items.0.spec.suspend']['-']}"
      valueToCompare: "true"
{{- end -}}


{{- define "in-cloud.web.action.triggerRun" -}}
- type: triggerRun
  props:
    # =========================
    # UI metadata
    # =========================
    text: Trigger Run
    icon: PlaySquareOutlined

    # =========================
    # PERMISSION CHECK (create jobs in same namespace)
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Job creation endpoint (batch/v1/jobs in namespace)
    # =========================
    createEndpoint: {{ .createEndpoint | quote }}

    # =========================
    # CronJob identity and template
    # =========================
    cronJobName: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
    jobTemplate: "{reqs[0]['items','0','spec','jobTemplate']}"
{{- end -}}


{{- define "in-cloud.web.action.rerunLast" -}}
- type: rerunLast
  props:
    # =========================
    # UI metadata
    # =========================
    text: Rerun
    icon: RedoOutlined

    # =========================
    # PERMISSION CHECK (create jobs in same namespace)
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Job creation endpoint
    # =========================
    createEndpoint: {{ .createEndpoint | quote }}

    # =========================
    # Source job spec and name
    # =========================
    sourceJobName: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
    sourceJobSpec: "{reqs[0]['items','0']}"
{{- end -}}


{{- define "in-cloud.web.action.deleteChildren" -}}
- type: deleteChildren
  props:
    # =========================
    # UI metadata
    # =========================
    text: {{ .text | default "Delete Active Jobs" | quote }}
    icon: ClearOutlined
    danger: true

    # =========================
    # PERMISSION CHECK
    # =========================
    {{- with .permissionContext }}
    permissionContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}

    # =========================
    # Children config (JSON array of {name, endpoint})
    # =========================
    children: {{ .children | quote }}
    childResourceName: {{ .childResourceName | default "Jobs" | quote }}
{{- end -}}
