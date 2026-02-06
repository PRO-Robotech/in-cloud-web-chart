# Return an empty array when no sidebar section is enabled.
{{ define "incloud-web-chart.sidebar.menu.items.namespaced" }}
{{- if (include "incloud-web-chart.sidebar.menu.items.namespaced-items" . | trim) }}
{{ include "incloud-web-chart.sidebar.menu.items.namespaced-items" . }}
{{ else }}
[]
{{- end }}
{{- end }}

{{- define "incloud-web-chart.sidebar.menu.items.namespaced-items" }}
{{- $sidebars := .Values.sidebars.namespaced }}

{{- with $sidebars.home }}
  {{- if .enabled }}
- children:
    {{- if .items.search }}
    - key: search
      label: Search
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/search
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: home
  label: Home
  {{- end }}
{{- end }}

{{/* Keep user-defined custom items as-is to avoid mutating their structure. */}}
{{- with $sidebars.customItems }}
{{- toYaml . | nindent 0 }}
{{- end }}

{{- with $sidebars.workloads }}
  {{- if .enabled }}
- children:
    {{- if .items.pods }}
    - key: pods
      label: Pods
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/pods?resources=metrics.k8s.io/v1beta1/pods
    {{- end }}
    {{- if .items.deployments }}
    - key: deployments
      label: Deployments
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/apps/v1/deployments
    {{- end }}
    {{- if .items.statefulsets }}
    - key: statefulsets
      label: Statefulsets
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/apps/v1/statefulsets
    {{- end }}
    {{- if .items.secrets }}
    - key: secrets
      label: Secrets
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/secrets
    {{- end }}
    {{- if .items.configmaps }}
    - key: configmaps
      label: ConfigMaps
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/configmaps
    {{- end }}
    {{- if .items.cronjobs }}
    - key: cronjobs
      label: CronJobs
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/batch/v1/cronjobs
    {{- end }}
    {{- if .items.jobs }}
    - key: jobs
      label: Jobs
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/batch/v1/jobs
    {{- end }}
    {{- if .items.daemonsets }}
    - key: daemonsets
      label: Daemonsets
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/apps/v1/daemonsets
    {{- end }}
    {{- if .items.replicasets }}
    - key: replicasets
      label: ReplicaSets
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/apps/v1/replicasets
    {{- end }}
    {{- if .items.horizontalpodautoscalers }}
    - key: horizontalpodautoscalers
      label: HorizontalPodAutoscalers
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/autoscaling/v2/horizontalpodautoscalers
    {{- end }}
    {{- if .items.poddisruptionbudgets }}
    - key: poddisruptionbudgets
      label: PodDisruptionBudgets
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/policy/v1/poddisruptionbudgets
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: workloads
  label: Workloads
  {{- end }}
{{- end }}

{{- with $sidebars.networking }}
  {{- if .enabled }}
- children:
    {{- if .items.services }}
    - key: services
      label: Services
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/services
    {{- end }}
    {{- if .items.networkpolicies }}
    - key: networkpolicies
      label: NetworkPolicies
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/networking.k8s.io/v1/networkpolicies
    {{- end }}
    {{- if .items.ingresses }}
    - key: ingresses
      label: Ingresses
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/networking.k8s.io/v1/ingresses
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: networking
  label: Networking
  {{- end }}
{{- end }}

{{- with $sidebars.storage }}
  {{- if .enabled }}
- children:
    {{- if .items.persistentvolumes }}
    - key: persistentvolumes
      label: PersistentVolumes
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/builtin-table/persistentvolumes
    {{- end }}
    {{- if .items.persistentvolumeclaims }}
    - key: persistentvolumeclaims
      label: PersistentVolumeClaims
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/persistentvolumeclaims
    {{- end }}
    {{- if .items.storageclasses }}
    - key: storageclasses
      label: StorageClasses
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/api-table/storage.k8s.io/v1/storageclasses
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: storage
  label: Storage
  {{- end }}
{{- end }}

{{- with $sidebars.compute }}
  {{- if .enabled }}
- children:
    {{- if .items.nodes }}
    - key: nodes
      label: Nodes
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/builtin-table/nodes?resources=metrics.k8s.io/v1beta1/nodes
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: compute
  label: Compute
  {{- end }}
{{- end }}

{{- with $sidebars.usermanagement }}
  {{- if .enabled }}
- children:
    {{- if .items.serviceaccounts }}
    - key: serviceaccounts
      label: ServiceAccounts
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/serviceaccounts
    {{- end }}
    {{- if .items.roles }}
    - key: roles
      label: Roles
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/rbac.authorization.k8s.io/v1/roles
    {{- end }}
    {{- if .items.rolebindings }}
    - key: rolebindings
      label: RoleBindings
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/api-table/rbac.authorization.k8s.io/v1/rolebindings
    {{- end }}
    {{- if .items.clusterroles }}
    - key: clusterroles
      label: ClusterRoles
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/api-table/rbac.authorization.k8s.io/v1/clusterroles
    {{- end }}
    {{- if .items.clusterrolebindings }}
    - key: clusterrolebindings
      label: ClusterRoleBindings
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/api-table/rbac.authorization.k8s.io/v1/clusterrolebindings
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: usermanagement
  label: User Management
  {{- end }}
{{- end }}

{{- with $sidebars.administration }}
  {{- if .enabled }}
- children:
    {{- if .items.namespaces }}
    - key: namespaces
      label: Namespaces
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/builtin-table/namespaces
    {{- end }}
    {{- if .items.limitranges }}
    - key: limitranges
      label: LimitRanges
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/limitranges
    {{- end }}
    {{- if .items.resourcequotas }}
    - key: resourcequotas
      label: ResourceQuotas
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/{namespace}/builtin-table/resourcequotas
    {{- end }}
    {{- if .items.customresourcedefinitions }}
    - key: customresourcedefinitions
      label: CustomResourceDefinitions
      link: {{ include "incloud-web.basePrefixWithSlash" $ }}/{cluster}/api-table/apiextensions.k8s.io/v1/customresourcedefinitions
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: administration
  label: Administration
  {{- end }}
{{- end }}
{{- end }}
