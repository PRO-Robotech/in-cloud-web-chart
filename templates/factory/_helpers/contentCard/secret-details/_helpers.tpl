{{- define "in-cloud.web.secretCard" -}}
# Content card with Secret data preview
- type: ContentCard
  data:
    id: secret-data-card
    title: Secret Data
    style:
      width: "100%"
      marginBottom: 0
  children:
    # Auto-sized multiline secret viewer:
    # grows with content and caps height to keep page balanced
    - type: SecretBase64Plain
      data:
        id: example-secret-base64
        type: base64
        reqIndex: "0"
        jsonPathToSecrets: .items.0.data
        multiline: true
        containerStyle:
          width: "100%"
        inputContainerStyle:
          width: "100%"
          height: "auto"
          maxHeight: "60vh"
          overflowY: "auto"
        textStyle:
          fontFamily: "JetBrains Mono, ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace"
          fontSize: "12px"
          lineHeight: 1.5
          whiteSpace: "pre-wrap"
          wordBreak: "break-word"
        notificationWidth: "420px"
        notificationText: "Secret value copied to clipboard."
        niceLooking: true
{{- end -}}
