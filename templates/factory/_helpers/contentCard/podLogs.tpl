{{- define "in-cloud.web.contentCard.podLogs" -}}
# Pod log viewer: streams container logs for the current Pod in openapi-ui.
- type: ContentCard
  data:
    id: details-card
    # AntD: card spacing
    style:
      marginBottom: 24px
  children:
    - type: PodLogs
      data:
        id: pod-logs
        # Target cluster for log API
        cluster: "{2}"
        # Pod namespace
        namespace: "{reqsJsonPath[0]['.items.0.metadata.namespace']['-']}"
        # Pod whose logs are shown
        podName: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        # Viewport height offset (pixels subtracted from available height)
        substractHeight: 350
        # Initial number of log lines to load
        tailLines: 1000
{{- end -}}
