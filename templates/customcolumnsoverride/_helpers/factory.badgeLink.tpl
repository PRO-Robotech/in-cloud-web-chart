{{- define "in-cloud.web.columns.factory.badgeLink" -}}
customProps:
  disableEventBubbling: true
  items:
    - type: antdFlex
      data:
        id: resource-badge-link-row
        align: center
        direction: row
        gap: 6
      children:
        - type: ResourceBadge
          data:
            id: example-resource-badge
            value: {{ .badge | quote }}
        - type: antdLink
          data:
            id: name-link
            href: {{ .href | quote }}
            text: {{ .text | quote }}
{{- end -}}
