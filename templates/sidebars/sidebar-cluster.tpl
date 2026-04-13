{{/*
============================================================================
Helm: sidebar-cluster.tpl (named templates)
----------------------------------------------------------------------------
Renders cluster-scoped sidebar menuItems (nested key/label/link); included from
sidebars/fallback-clusterscoped.yaml. Placeholder {cluster} matches URL index {2}
in paths like /openapi-ui/{2}/… (segment after the UI base prefix).
Route kinds: builtin-table — curated tables by short resource name; api-table —
Kubernetes group/version/resource segments for the API browser.
Named templates below return [] when the generated menu would be empty.
============================================================================
*/}}
{{ define "incloud-web-chart.sidebar.menu.items.cluster" }}
{{- if (include "incloud-web-chart.sidebar.menu.items.cluster-items" . | trim) }}
{{ include "incloud-web-chart.sidebar.menu.items.cluster-items" . }}
{{ else }}
[]
{{- end }}
{{- end }}

{{ define "incloud-web-chart.sidebar.menu.items.cluster-items" }}
{{ $sidebars := .Values.sidebars.cluster }}
{{ $projRes := .Values.projectResource }}
{{ $instRes := .Values.instanceResource }}

{{- with $sidebars.home }}
  {{- if .enabled }}
- children:
    {{- if .items.search }}
    - key: search
      label: Search
      link: /openapi-ui/{cluster}/search
    - key: clusters
      label: Clusters
      link: /openapi-ui/clusters
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: home
  label: Home
  {{- end }}

{{- end }}

{{- if $sidebars.customItems -}}
  {{- range $sidebars.customItems }}
{{ $sidebars.customItems | toYaml }}
  {{- end }}
{{- end -}}

{{- with $sidebars.workloads }}
  {{- if .enabled }}
- children:
    {{- if .items.pods }}
    - key: pods
      label: Pods
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/pods?resources=metrics.k8s.io/v1beta1/pods
    {{- end }}
    {{- if .items.deployments }}
    - key: deployments
      label: Deployments
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/apps/v1/deployments
    {{- end }}
    {{- if .items.statefulsets }}
    - key: statefulsets
      label: Statefulsets
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/apps/v1/statefulsets
    {{- end }}
    {{- if .items.secrets }}
    - key: secrets
      label: Secrets
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/secrets
    {{- end }}
    {{- if .items.configmaps }}
    - key: configmaps
      label: ConfigMaps
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/configmaps
    {{- end }}
    {{- if .items.cronjobs }}
    - key: cronjobs
      label: CronJobs
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/batch/v1/cronjobs
    {{- end }}
    {{- if .items.jobs }}
    - key: jobs
      label: Jobs
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/batch/v1/jobs
    {{- end }}
    {{- if .items.daemonsets }}
    - key: daemonsets
      label: Daemonsets
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/apps/v1/daemonsets
    {{- end }}
    {{- if .items.replicasets }}
    - key: replicasets
      label: ReplicaSets
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/apps/v1/replicasets
    {{- end }}
    {{- if .items.horizontalpodautoscalers }}
    - key: horizontalpodautoscalers
      label: HorizontalPodAutoscalers
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/autoscaling/v2/horizontalpodautoscalers
    {{- end }}
    {{- if .items.poddisruptionbudgets }}
    - key: poddisruptionbudgets
      label: PodDisruptionBudgets
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/policy/v1/poddisruptionbudgets
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
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/services
    {{- end }}
    {{- if .items.networkpolicies }}
    - key: networkpolicies
      label: NetworkPolicies
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/networking.k8s.io/v1/networkpolicies
    {{- end }}
    {{- if .items.ingresses }}
    - key: ingresses
      label: Ingresses
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/networking.k8s.io/v1/ingresses
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
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/persistentvolumes
    {{- end }}
    {{- if .items.persistentvolumeclaims }}
    - key: persistentvolumeclaims
      label: PersistentVolumeClaims
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/persistentvolumeclaims
    {{- end }}
    {{- if .items.storageclasses }}
    - key: storageclasses
      label: StorageClasses
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/storage.k8s.io/v1/storageclasses
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
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/nodes?resources=metrics.k8s.io/v1beta1/nodes
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
    {{- if .items.rolesDiscovery }}
    - key: rolesdiscovery
      label: RolesDiscovery
      link: /{{ $.Values.basePrefix }}/{cluster}/plugins/plugin-rbac/table
    {{- end }}
    {{- if .items.rolesDiscoveryGraph }}
    - key: rolesdiscoverygraph
      label: RolesDiscoveryGraph
      link: /{{ $.Values.basePrefix }}/{cluster}/plugins/plugin-rbac/rbac
    {{- end }}
    {{- if .items.serviceaccounts }}
    - key: serviceaccounts
      label: ServiceAccounts
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/serviceaccounts
    {{- end }}
    {{- if .items.roles }}
    - key: roles
      label: Roles
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/rbac.authorization.k8s.io/v1/roles
    {{- end }}
    {{- if .items.rolebindings }}
    - key: rolebindings
      label: RoleBindings
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/rbac.authorization.k8s.io/v1/rolebindings
    {{- end }}
    {{- if .items.clusterroles }}
    - key: clusterroles
      label: ClusterRoles
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/rbac.authorization.k8s.io/v1/clusterroles
    {{- end }}
    {{- if .items.clusterrolebindings }}
    - key: clusterrolebindings
      label: ClusterRoleBindings
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/rbac.authorization.k8s.io/v1/clusterrolebindings
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
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/namespaces
    {{- end }}
    {{- if .items.limitranges }}
    - key: limitranges
      label: LimitRanges
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/limitranges
    {{- end }}
    {{- if .items.resourcequotas }}
    - key: resourcequotas
      label: ResourceQuotas
      link: /{{ $.Values.basePrefix }}/{cluster}/builtin-table/resourcequotas
    {{- end }}
    {{- if .items.customresourcedefinitions }}
    - key: customresourcedefinitions
      label: CustomResourceDefinitions
      link: /{{ $.Values.basePrefix }}/{cluster}/api-table/apiextensions.k8s.io/v1/customresourcedefinitions
    {{- end }}
    {{- with .extraItems }}
      {{ . | toYaml | nindent 4 }}
    {{- end }}
  key: administration
  label: Administration
  {{- end }}
{{- end }}
{{- end }}
