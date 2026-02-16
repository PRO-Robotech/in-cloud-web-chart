{{- define "in-cloud.web.contentCard.podTerminal" -}}
- type: ContentCard
  data:
    id: details-card
    style:
      marginBottom: 24px
  children:
    - type: PodTerminal
      data:
        id: pod-terminal
        cluster: "{2}"
        namespace: "{reqsJsonPath[0]['.items.0.metadata.namespace']['-']}"
        podName: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        substractHeight: 350
{{- end -}}
