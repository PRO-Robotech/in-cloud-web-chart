{{- define "in-cloud.web.contentCard.podLogs" -}}
- type: ContentCard
  data:
    id: details-card
    style:
      marginBottom: 24px
  children:
    - type: PodLogs
      data:
        id: pod-logs
        cluster: "{2}"
        namespace: "{reqsJsonPath[0]['.items.0.metadata.namespace']['-']}"
        podName: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        substractHeight: 350
        tailLines: 1000
{{- end -}}
