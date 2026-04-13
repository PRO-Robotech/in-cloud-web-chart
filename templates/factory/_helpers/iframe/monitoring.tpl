{{/*
  Grafana monitoring tab: embeds node/pod dashboards in an iframe (kiosk, time range, datasource
  UID, resource vars).
*/}}
{{- define "in-cloud.web.iframe.monitoring.node" -}}
- type: DefaultIframe
  data:
    id: DefaultIframe
    # AntD iframe sizing
    width: 100%
    height: 1100px
    style:
      border: 0
    # src: grafanaBaseUrl + /d/ + grafanaDashboardPath; var-datasource=grafanaDatasource (datasource
    # UID); var-node from current object name; orgId/from/to/timezone/resolution/refresh/kiosk/theme
    # are Grafana query params.
    src: >-
      {{ .grafanaBaseUrl }}/d/{{ .grafanaDashboardPath }}?orgId=1&from=now-1h&to=now&timezone=utc&var-datasource={{ .grafanaDatasource }}&var-resolution=30s&var-node={reqsJsonPath[0]['.items.0.metadata.name']['-']}&var-instance=&refresh=30s&kiosk=true&theme={theme}
{{- end -}}

{{- define "in-cloud.web.iframe.monitoring.pod" -}}
- type: DefaultIframe
  data:
    id: DefaultIframe
    # AntD iframe sizing
    width: 100%
    height: 1100px
    style:
      border: 0
    # src: grafanaBaseUrl + /d/ + grafanaDashboardPath; var-datasource=grafanaDatasource (UID);
    # var-namespace/var-pod from current Pod; remaining params set time range, resolution, refresh,
    # kiosk, theme.
    src: >-
      {{ .grafanaBaseUrl }}/d/{{ .grafanaDashboardPath }}?orgId=1&from=now-1h&to=now&timezone=utc&var-datasource={{ .grafanaDatasource }}&var-namespace={reqsJsonPath[0]['.items.0.metadata.namespace']['-']}&var-pod={reqsJsonPath[0]['.items.0.metadata.name']['-']}&var-resolution=30s&var-job=kube-state-metrics&refresh=5s&kiosk=true&theme={theme}
{{- end -}}
