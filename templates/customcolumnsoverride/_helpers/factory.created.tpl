{{- define "in-cloud.web.columns.factory.created" -}}
customProps:
  disableEventBubbling: true
  items:
    - type: antdFlex
      data:
        id: time-block
        align: center
        gap: 6
      children:
        - type: antdText
          data:
            id: time-icon
            text: "🌐"
        - type: parsedText
          data:
            id: time-value
            formatter: timestamp
            text: "{reqsJsonPath[0]['.metadata.creationTimestamp']['-']}"
{{- end -}}
