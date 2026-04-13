{{- define "in-cloud.web.contentCard.podTerminal" -}}
# Pod terminal: interactive shell attached to the current Pod (exec/attach in openapi-ui).
- type: ContentCard
  data:
    id: details-card
    # AntD: card spacing
    style:
      marginBottom: 24px
  children:
    - type: PodTerminal
      data:
        id: pod-terminal
        # Target cluster for exec/terminal API
        cluster: "{2}"
        # Pod namespace
        namespace: "{reqsJsonPath[0]['.items.0.metadata.namespace']['-']}"
        # Pod to attach the terminal to
        podName: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        # Viewport height offset (pixels subtracted from available height)
        substractHeight: 350
{{- end -}}
