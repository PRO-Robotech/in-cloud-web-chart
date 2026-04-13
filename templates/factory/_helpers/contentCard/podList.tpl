{{/*
  ContentCard with EnrichedTable listing Pods: k8sResourceToFetch for v1/pods, optional
  labelSelectorFull/fieldSelector, pathToItems .items.
*/}}
{{- define "in-cloud.web.contentCard.podList" -}}
- type: ContentCard
  data:
    id: pod-list-card
    style:
      marginBottom: 24px
  children:
    - type: EnrichedTable
      data:
        id: pods-table
        baseprefix: /openapi-ui
        cluster: "{2}"
        customizationId: "factory-/v1/pods"

        # k8sResourceToFetch: API coordinates used to load and refresh the Pod list.
        k8sResourceToFetch:
          apiVersion: "v1"
          plural: "pods"
          {{- if index . "ifNamespaced" }}
          namespace: "{3}"
          {{- end }}

        dataForControls:
          cluster: "{2}"
          apiVersion: "v1"
          plural: "pods"
          {{- if index . "ifNamespaced" }}
          namespace: "{3}"
          {{- end }}

        # Label selector (optional)
        {{- if index . "labelSelectorFull" }}
        labelSelectorFull:
          {{- toYaml (index . "labelSelectorFull") | nindent 10 }}
        {{- end }}

        # Field selector (optional)
        {{- if index . "fieldSelector" }}
        fieldSelector:
          {{- toYaml (index . "fieldSelector") | nindent 10 }}
        {{- end }}

        pathToItems: ".items"

        additionalReqsDataToEachItem:
          - 1
{{- end -}}
