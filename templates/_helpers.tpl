{{/* ======================================================================
 URL / JSONPath placeholder reference (used across all templates)
 ======================================================================
 Positional URL path segments (1-based):
   {1}..{N}          — segments of the current browser URL path
   {cluster}         — current cluster name (= {2} in most routes)
   {namespace}       — current namespace   (= {3} in namespaced routes)
   {selectedCluster} — cluster chosen in the header selector dropdown
   {value}           — value the user just selected (instance/namespace/project)
   ~recordValue~     — replaced at runtime with the clicked table row value

 reqsJsonPath expressions (data from Factory.spec.urlsToFetch):
   {reqsJsonPath[<reqIdx>]['<jsonPath>']['<fallback>']}
     reqIdx   — 0-based index into urlsToFetch array
     jsonPath — JSONPath inside the fetched K8s object (e.g. '.metadata.name')
     fallback — text shown when the value is missing (e.g. '-')

 Example: /openapi-ui/mycluster/myns/api-table/apps/v1/deployments
   {1}=openapi-ui  {2}=mycluster  {3}=myns  {4}=api-table
   {5}=apps  {6}=v1  {7}=deployments

 Route types used in sidebar links:
   builtin-table — core/v1 resources (pods, services, configmaps, ...)
   api-table     — API extension resources (apps/v1, batch/v1, networking.k8s.io/v1, ...)
   factory       — detail page rendered by a Factory CR
   plugins       — page provided by a microfrontend plugin
 ====================================================================== */}}

{{/* ----------------------------------------------------------------------
 Name helpers
---------------------------------------------------------------------- */}}
{{- define "incloud-web.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "incloud-web.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "incloud-web.name" . -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end }}

{{/* ----------------------------------------------------------------------
 Labels (app & selector)
---------------------------------------------------------------------- */}}
{{- define "incloud-web.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "incloud-web.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "incloud-web.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- range $k, $v := .Values.selectorLabels }}
{{ $k }}: {{ $v | quote }}
{{- end }}
{{- end }}

{{/* ----------------------------------------------------------------------
 ServiceAccount name
---------------------------------------------------------------------- */}}
{{- define "incloud-web.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ include "incloud-web.fullname" . }}
{{- else -}}
{{- default (include "incloud-web.fullname" .) .Values.serviceAccount.name -}}
{{- end -}}
{{- end }}

{{/* ----------------------------------------------------------------------
 ENV map -> list of {name,value}
 Usage: {{ include "incloud-web.env" .Values.bff.env }}
---------------------------------------------------------------------- */}}
{{- define "incloud-web.env" -}}
{{- $env := . | default dict -}}
{{- range $k, $v := $env }}
- name: {{ $k }}
  value: {{ $v | quote }}
{{- end }}
{{- end }}
