{{- define "in-cloud.web.factoryContext.namespacedApi" -}}
{{/* Shared context for namespaced custom resources (apis/<group>/<version>) */}}
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
{{/* Shared context for namespaced builtin resources (api/<version>) */}}
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
{{/* Shared context for cluster-scoped custom resources (apis/<group>/<version>) */}}
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
{{/* Shared context for cluster-scoped builtin resources (api/<version>) */}}
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
{{/* Utility: build the primary urlsToFetch item from resource + name selector */}}
{{- toYaml (list (merge (dict
  "fieldSelector" .fieldSelector
) .resource)) -}}
{{- end -}}

{{- define "in-cloud.web.factoryContext.metricsPodsUrlToFetchList" -}}
{{/* Utility: optional extra urlsToFetch item for pods metrics (metrics.k8s.io/v1beta1) */}}
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
