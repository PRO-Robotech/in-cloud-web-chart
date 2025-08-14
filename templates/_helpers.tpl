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
