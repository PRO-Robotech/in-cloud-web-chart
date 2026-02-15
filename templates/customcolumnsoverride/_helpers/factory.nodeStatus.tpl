{{- define "in-cloud.web.columns.factory.nodeStatus" -}}
customProps:
  disableEventBubbling: true
  items:
    {{ include "in-cloud.web.statusText.nodeAvailability" (dict
        "itemPath" ""
      ) | nindent 4
    }}
{{- end -}}