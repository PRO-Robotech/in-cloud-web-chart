{{- define "in-cloud.web.iframe.monitoring.node" -}}
- type: DefaultIframe
  data:
    id: DefaultIframe
    width: 100%
    height: 1100px
    style:
      border: 0
    # Grafana dashboard path (same dashboard, extracted to template param)
    src: >-
      {{ .grafanaBaseUrl }}/d/{{ .grafanaDashboardPath }}?orgId=1&from=now-1h&to=now&timezone=utc&var-datasource={{ .grafanaDatasource }}&var-resolution=30s&var-node={reqsJsonPath[0]['.items.0.metadata.name']['-']}&var-instance=&refresh=30s&kiosk=true&theme={theme}
{{- end -}}

{{- define "in-cloud.web.iframe.monitoring.pod" -}}
- type: DefaultIframe
  data:
    id: DefaultIframe
    width: 100%
    height: 1100px
    style:
      border: 0
    # Grafana dashboard path (same dashboard, extracted to template param)
    src: >-
      {{ .grafanaBaseUrl }}/d/{{ .grafanaDashboardPath }}?orgId=1&from=now-1h&to=now&timezone=utc&var-datasource={{ .grafanaDatasource }}&var-namespace={reqsJsonPath[0]['.items.0.metadata.namespace']['-']}&var-pod={reqsJsonPath[0]['.items.0.metadata.name']['-']}&var-resolution=30s&var-job=kube-state-metrics&refresh=5s&kiosk=true&theme={theme}
{{- end -}}
