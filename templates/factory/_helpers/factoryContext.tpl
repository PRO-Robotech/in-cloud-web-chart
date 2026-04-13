{{- define "in-cloud.web.factoryContext.namespacedApi" -}}
{{/*
  factoryContext.tpl — shared YAML fragments for Factory detail pages in openapi-ui.

  Defines: namespacedApi / namespacedBuiltin (namespaced), clusterScopedApi / clusterScopedBuiltin
  (cluster-scoped), primaryUrlToFetchList (resource + fieldSelector), metricsPodsUrlToFetchList
  (optional metrics.k8s.io pods). Placeholders {2}, {3}, … come from the UI route.

  Note: *Context* YAML is consumed by fromYaml() elsewhere — no inline “#” in emitted YAML.
  primaryUrlToFetchList output must not start with a stray “#” line under urlsToFetch (Helm validation).

  --- namespacedApi ---
  Context for namespaced custom resources: apis/<apiGroup>/<apiVersion>/namespaces/<ns>/<plural>/...

  resource.* (and permissionContext.*, same values):
  - cluster: {2}, namespace: {3} — URL segments.
  - apiGroup: {6}, apiVersion: {7}, plural: {8} — group, version, plural from the API path.

  permissionContext duplicates resource: the UI uses it for RBAC permission checks (same fields).

  endpoint: BFF proxy URL to the Kubernetes API. Pattern:
  /api/clusters/{cluster}/k8s/apis/{group}/{version}/namespaces/{namespace}/{plural}/{name}
  The name segment uses reqsJsonPath (current object in the request chain).
*/}}
resource:
  cluster: "{2}"
  namespace: "{3}"
  apiGroup: "{6}"
  apiVersion: "{7}"
  plural: "{8}"
permissionContext:
  cluster: "{2}"
  namespace: "{3}"
  apiGroup: "{6}"
  apiVersion: "{7}"
  plural: "{8}"
endpoint: "/api/clusters/{2}/k8s/apis/{6}/{7}/namespaces/{3}/{8}/{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
{{- end -}}

{{- define "in-cloud.web.factoryContext.namespacedBuiltin" -}}
{{/*
  Context for namespaced core/v1-style resources: api/<apiVersion>/namespaces/<ns>/<plural>/...
  Builtin paths have no separate apiGroup — only apiVersion and plural in the URL.

  resource / permissionContext:
  - cluster: {2}, namespace: {3}
  - apiVersion: {6}, plural: {7}

  permissionContext duplicates resource for RBAC. endpoint targets /api/clusters/{2}/k8s/api/...
*/}}
resource:
  cluster: "{2}"
  namespace: "{3}"
  apiVersion: "{6}"
  plural: "{7}"
permissionContext:
  cluster: "{2}"
  namespace: "{3}"
  apiVersion: "{6}"
  plural: "{7}"
endpoint: "/api/clusters/{2}/k8s/api/{6}/namespaces/{3}/{7}/{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
{{- end -}}

{{- define "in-cloud.web.factoryContext.clusterScopedApi" -}}
{{/*
  Cluster-scoped custom resource: apis/<apiGroup>/<apiVersion>/<plural>/...

  resource / permissionContext:
  - cluster: {2}
  - apiGroup: {5}, apiVersion: {6}, plural: {7}

  permissionContext duplicates resource for RBAC. endpoint has no namespace segment.
*/}}
resource:
  cluster: "{2}"
  apiGroup: "{5}"
  apiVersion: "{6}"
  plural: "{7}"
permissionContext:
  cluster: "{2}"
  apiGroup: "{5}"
  apiVersion: "{6}"
  plural: "{7}"
endpoint: "/api/clusters/{2}/k8s/apis/{5}/{6}/{7}/{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
{{- end -}}

{{- define "in-cloud.web.factoryContext.clusterScopedBuiltin" -}}
{{/*
  Cluster-scoped core API: api/<apiVersion>/<plural>/...

  resource / permissionContext:
  - cluster: {2}, apiVersion: {5}, plural: {6}

  permissionContext duplicates resource for RBAC. endpoint has no namespace.
*/}}
resource:
  cluster: "{2}"
  apiVersion: "{5}"
  plural: "{6}"
permissionContext:
  cluster: "{2}"
  apiVersion: "{5}"
  plural: "{6}"
endpoint: "/api/clusters/{2}/k8s/api/{5}/{6}/{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
{{- end -}}

{{- define "in-cloud.web.factoryContext.primaryUrlToFetchList" -}}
{{/*
  Builds one urlsToFetch list element: merge(.resource) with fieldSelector.

  fieldSelector is the Kubernetes list query parameter: server-side filtering (e.g. metadata.name=)
  so the list returns only matching objects.
*/}}
{{- toYaml (list (merge (dict
  "fieldSelector" .fieldSelector
) .resource)) -}}
{{- end -}}

{{- define "in-cloud.web.factoryContext.metricsPodsUrlToFetchList" -}}
{{/*
  Optional urlsToFetch entry: metrics.k8s.io/v1beta1, plural pods — pod resource metrics for the UI.
  If withNamespace is true, namespace {3} is set on the request (namespaced pod metrics).
*/}}
{{- $metricsPodsUrlToFetch := dict
  "cluster" "{2}"
  "apiGroup" "metrics.k8s.io"
  "apiVersion" "v1beta1"
  "plural" "pods"
-}}
{{- if .withNamespace -}}
{{- $_ := set $metricsPodsUrlToFetch "namespace" "{3}" -}}
{{- end -}}
{{- toYaml (list $metricsPodsUrlToFetch) -}}
{{- end -}}
