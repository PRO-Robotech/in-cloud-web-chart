{{- define "in-cloud.web.contentCard.nodeTerminal" -}}
# Node terminal: shell session on a Node via openapi-ui (cluster + node context).
- type: ContentCard
  data:
    id: node-terminal-card
    style:
      marginBottom: 24px
  children:
    - type: NodeTerminal
      data:
        id: terminal
        # Cluster identifier for terminal connection
        cluster: "{2}"
        # Namespace with predefined pod templates for terminal
        listPodTemplatesNs: in-cloud-web
        # Node name used to attach terminal session
        nodeName: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        # Height offset for terminal viewport
        substractHeight: 350
{{- end -}}
