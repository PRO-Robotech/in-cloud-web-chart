{{/*
  Badge + link row for factory columns (see in-cloud.web.cco.props.badgeLink).
  disableEventBubbling — prevents the table row click when interacting with the cell;
  ResourceBadge — colored kind/status badge; antdLink — clickable label with href/text.
*/}}
{{- define "in-cloud.web.columns.factory.badgeLink" -}}
customProps:
  disableEventBubbling: true
  items:
    {{- /* antdFlex: horizontal badge + link */}}
    - type: antdFlex
      data:
        id: resource-badge-link-row
        align: center
        direction: row
        gap: 6
      children:
        {{- /* ResourceBadge: colored badge for kind/state */}}
        - type: ResourceBadge
          data:
            id: example-resource-badge
            value: {{ .badge | quote }}
        {{- /* antdLink: clickable name/detail URL */}}
        - type: antdLink
          data:
            id: name-link
            href: {{ .href | quote }}
            text: {{ .text | quote }}
{{- end -}}
