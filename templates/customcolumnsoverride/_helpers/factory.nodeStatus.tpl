{{/*
  Custom column: node availability. Delegates to StatusText rules (Ready vs pressure reasons); label
  color follows matched criteria.
*/}}
{{- define "in-cloud.web.columns.factory.nodeStatus" -}}
customProps:
  disableEventBubbling: true
  items:
    {{ include "in-cloud.web.statusText.nodeAvailability" (dict
        "itemPath" ""
      ) | nindent 4
    }}
{{- end -}}