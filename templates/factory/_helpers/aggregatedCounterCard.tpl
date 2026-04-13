{{/*
  AggregatedCounterCard helpers: compact counter badge cards for resource metadata and lists (e.g. counts of
  labels, annotations, taints, or status.images), often with edit or table drill-down in the active panel.
*/}}
{{- define "in-cloud.web.aggregatedCounterCard.labels" -}}
- type: AggregatedCounterCard
  data:
    id: labels-counter-card
    text: Labels
    # Icon for Labels card (Base64-encoded SVG)
    iconBase64Encoded: PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfMTk1M18yNDAzNCkiPjxwYXRoIGQ9Ik0yMy40MTEgMTAuNTcxN0wyMi42MTgxIDIuMTk4NDRDMjIuNTc3OSAxLjc2NDUxIDIyLjIzMjQgMS40MjE2NSAyMS43OTg1IDEuMzc4NzlMMTMuNDI1MiAwLjU4NTkzOEgxMy40MTQ1QzEzLjMyODggMC41ODU5MzggMTMuMjYxOCAwLjYxMjcyMyAxMy4yMTEgMC42NjM2MTZMMC42NjcyIDEzLjIwNzRDMC42NDIzNjkgMTMuMjMyMSAwLjYyMjY2OSAxMy4yNjE2IDAuNjA5MjI3IDEzLjI5NEMwLjU5NTc4NiAxMy4zMjY0IDAuNTg4ODY3IDEzLjM2MTEgMC41ODg4NjcgMTMuMzk2MkMwLjU4ODg2NyAxMy40MzEzIDAuNTk1Nzg2IDEzLjQ2NiAwLjYwOTIyNyAxMy40OTg0QzAuNjIyNjY5IDEzLjUzMDggMC42NDIzNjkgMTMuNTYwMyAwLjY2NzIgMTMuNTg1TDEwLjQxMTggMjMuMzI5N0MxMC40NjI3IDIzLjM4MDYgMTAuNTI5NyAyMy40MDc0IDEwLjYwMiAyMy40MDc0QzEwLjY3NDMgMjMuNDA3NCAxMC43NDEzIDIzLjM4MDYgMTAuNzkyMiAyMy4zMjk3TDIzLjMzNiAxMC43ODU5QzIzLjM4OTUgMTAuNzI5NyAyMy40MTYzIDEwLjY1MiAyMy40MTEgMTAuNTcxN1pNMTAuNTk5MyAyMC42NDA0TDMuMzU2NDkgMTMuMzk3NUwxNC4wNjI3IDIuNjkxM0wyMC42Nzg4IDMuMzE4MDhMMjEuMzA1NiA5LjkzNDE1TDEwLjU5OTMgMjAuNjQwNFpNMTYuNTAwMiA1LjEzOTUxQzE1LjIwMTEgNS4xMzk1MSAxNC4xNDMxIDYuMTk3NTUgMTQuMTQzMSA3LjQ5NjY1QzE0LjE0MzEgOC43OTU3NiAxNS4yMDExIDkuODUzOCAxNi41MDAyIDkuODUzOEMxNy43OTkzIDkuODUzOCAxOC44NTc0IDguNzk1NzYgMTguODU3NCA3LjQ5NjY1QzE4Ljg1NzQgNi4xOTc1NSAxNy43OTkzIDUuMTM5NTEgMTYuNTAwMiA1LjEzOTUxWk0xNi41MDAyIDguMzUzOEMxNi4wMjYxIDguMzUzOCAxNS42NDMxIDcuOTcwNzYgMTUuNjQzMSA3LjQ5NjY1QzE1LjY0MzEgNy4wMjI1NSAxNi4wMjYxIDYuNjM5NTEgMTYuNTAwMiA2LjYzOTUxQzE2Ljk3NDMgNi42Mzk1MSAxNy4zNTc0IDcuMDIyNTUgMTcuMzU3NCA3LjQ5NjY1QzE3LjM1NzQgNy45NzA3NiAxNi45NzQzIDguMzUzOCAxNi41MDAyIDguMzUzOFoiIGZpbGw9ImN1cnJlbnRDb2xvciIvPjwvZz48ZGVmcz48Y2xpcFBhdGggaWQ9ImNsaXAwXzE5NTNfMjQwMzQiPjxyZWN0IHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgZmlsbD0id2hpdGUiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=
    counter:
      type: "key"
      props:
        reqIndex: "0"
        # JSONPath to labels object for counter calculation
        jsonPathToObj: .items.0.metadata.labels
    activeType:
      type: "labels"
      props:
        reqIndex: "0"
        # JSONPath to labels for edit modal
        jsonPathToLabels: .items.0.metadata.labels
        notificationSuccessMessage: Updated successfully
        notificationSuccessMessageDescription: Labels have been updated
        modalTitle: Edit labels
        modalDescriptionText: ""
        inputLabel: ""
        maxEditTagTextLength: 35
        # API endpoint for PATCH/UPDATE
        endpoint: {{ .endpoint | quote }}
        # JSON Pointer path for patch operation
        pathToValue: /metadata/labels
        editModalWidth: 650
        paddingContainerEnd: 24px
        permissionContext:
          # RBAC/permission context for edit actions
          {{- toYaml .permissionContext | nindent 10 }}
{{- end -}}


{{- define "in-cloud.web.aggregatedCounterCard.annotations" -}}
- type: AggregatedCounterCard
  data:
    id: annotations-counter-card
    text: Annotations
    # Icon for Annotations card (Base64-encoded SVG)
    iconBase64Encoded: PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOSIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDE5IDI0IiBmaWxsPSJub25lIj48cGF0aCBkPSJNMTguNjA1NCA2LjAxNjA3TDEyLjg0MTEgMC4yNTE3ODZDMTIuNjgwNCAwLjA5MTA3MTUgMTIuNDYzNCAwIDEyLjIzNTcgMEgwLjg1NzE0M0MwLjM4MzAzNiAwIDAgMC4zODMwMzYgMCAwLjg1NzE0M1YyMy4xNDI5QzAgMjMuNjE3IDAuMzgzMDM2IDI0IDAuODU3MTQzIDI0SDE4QzE4LjQ3NDEgMjQgMTguODU3MSAyMy42MTcgMTguODU3MSAyMy4xNDI5VjYuNjI0MTFDMTguODU3MSA2LjM5NjQzIDE4Ljc2NjEgNi4xNzY3OSAxOC42MDU0IDYuMDE2MDdaTTE2Ljg4MDQgNy4wMTc4NkgxMS44MzkzVjEuOTc2NzlMMTYuODgwNCA3LjAxNzg2Wk0xNi45Mjg2IDIyLjA3MTRIMS45Mjg1N1YxLjkyODU3SDEwLjAxNzlWNy43MTQyOUMxMC4wMTc5IDguMDEyNjUgMTAuMTM2NCA4LjI5ODggMTAuMzQ3NCA4LjUwOTc4QzEwLjU1ODMgOC43MjA3NiAxMC44NDQ1IDguODM5MjkgMTEuMTQyOSA4LjgzOTI5SDE2LjkyODZWMjIuMDcxNFpNOS4yMTQyOSAxNC44MzkzSDQuMjg1NzJDNC4xNjc4NiAxNC44MzkzIDQuMDcxNDMgMTQuOTM1NyA0LjA3MTQzIDE1LjA1MzZWMTYuMzM5M0M0LjA3MTQzIDE2LjQ1NzEgNC4xNjc4NiAxNi41NTM2IDQuMjg1NzIgMTYuNTUzNkg5LjIxNDI5QzkuMzMyMTQgMTYuNTUzNiA5LjQyODU3IDE2LjQ1NzEgOS40Mjg1NyAxNi4zMzkzVjE1LjA1MzZDOS40Mjg1NyAxNC45MzU3IDkuMzMyMTQgMTQuODM5MyA5LjIxNDI5IDE0LjgzOTNaTTQuMDcxNDMgMTEuNDEwN1YxMi42OTY0QzQuMDcxNDMgMTIuODE0MyA0LjE2Nzg2IDEyLjkxMDcgNC4yODU3MiAxMi45MTA3SDE0LjU3MTRDMTQuNjg5MyAxMi45MTA3IDE0Ljc4NTcgMTIuODE0MyAxNC43ODU3IDEyLjY5NjRWMTEuNDEwN0MxNC43ODU3IDExLjI5MjkgMTQuNjg5MyAxMS4xOTY0IDE0LjU3MTQgMTEuMTk2NEg0LjI4NTcyQzQuMTY3ODYgMTEuMTk2NCA0LjA3MTQzIDExLjI5MjkgNC4wNzE0MyAxMS40MTA3WiIgZmlsbD0iY3VycmVudENvbG9yIi8+PC9zdmc+
    counter:
      type: "key"
      props:
        reqIndex: "0"
        # JSONPath to annotations object for counter calculation
        jsonPathToObj: .items.0.metadata.annotations
    activeType:
      type: "annotations"
      props:
        reqIndex: "0"
        # JSONPath to annotations for edit modal
        jsonPathToObj: .items.0.metadata.annotations
        notificationSuccessMessage: Updated successfully
        notificationSuccessMessageDescription: Annotations have been updated
        modalTitle: Edit annotations
        modalDescriptionText: ""
        inputLabel: ""
        # API endpoint for PATCH/UPDATE
        endpoint: {{ .endpoint | quote }}
        # JSON Pointer path for patch operation
        pathToValue: /metadata/annotations
        editModalWidth: 800px
        cols: [11, 11, 2]
        permissionContext:
          # RBAC/permission context for edit actions
          {{- toYaml .permissionContext | nindent 10 }}
{{- end -}}


{{- define "in-cloud.web.aggregatedCounterCard.taints" -}}
- type: AggregatedCounterCard
  data:
    id: taints-counter-card
    text: Taints
    # Icon for Taints card (Base64-encoded SVG)
    iconBase64Encoded: PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyMiIgaGVpZ2h0PSIyMyIgdmlld0JveD0iMCAwIDIyIDIzIiBmaWxsPSJub25lIj48cGF0aCBkPSJNMTcuNTI4NiAxNy43OTE4QzE4LjY5OTEgMTcuNzkxOCAxOS42NTU0IDE2LjgyMjEgMTkuNjU1NCAxNS42MzU1QzE5LjY1NTQgMTQuMjAyNSAxNy41Mjg2IDExLjg2NDEgMTcuNTI4NiAxMS44NjQxQzE3LjUyODYgMTEuODY0MSAxNS40MDE4IDE0LjIwMjUgMTUuNDAxOCAxNS42MzU1QzE1LjQwMTggMTYuODIyMSAxNi4zNTggMTcuNzkxOCAxNy41Mjg2IDE3Ljc5MThaTTcuNDI3NjggMTYuNjEwNUM3LjYxNzg2IDE2LjgwMDcgNy45MjU4OSAxNi44MDA3IDguMTEzMzkgMTYuNjEwNUwxNC45NzMyIDkuNzUzNEMxNS4xNjM0IDkuNTYzMjIgMTUuMTYzNCA5LjI1NTE4IDE0Ljk3MzIgOS4wNjc2OEw4LjExNjA3IDIuMjEwNTRDOC4xIDIuMTk0NDcgOC4wODEyNSAyLjE3ODQgOC4wNjI1IDIuMTY1TDUuOTY3ODYgMC4wNzAzNjAxQzUuOTIyMTkgMC4wMjUyNzggNS44NjA2IDAgNS43OTY0MyAwQzUuNzMyMjYgMCA1LjY3MDY3IDAuMDI1Mjc4IDUuNjI1IDAuMDcwMzYwMUw0LjMzOTI5IDEuMzU2MDdDNC4yOTQyIDEuNDAxNzQgNC4yNjg5MyAxLjQ2MzMzIDQuMjY4OTMgMS41Mjc1QzQuMjY4OTMgMS41OTE2NyA0LjI5NDIgMS42NTMyNiA0LjMzOTI5IDEuNjk4OTNMNi4xMzkyOSAzLjQ5ODkzTDAuNTczMjE0IDkuMDY3NjhDMC4zODMwMzYgOS4yNTc4NiAwLjM4MzAzNiA5LjU2NTkgMC41NzMyMTQgOS43NTM0TDcuNDI3NjggMTYuNjEwNVpNNy43NzMyMiA0LjU5NDQ3TDEyLjU2NTIgOS4zODY0M0gyLjk4MzkzTDcuNzczMjIgNC41OTQ0N1pNMjEuMjE0MyAxOS43MTIzSDAuMjE0Mjg2QzAuMDk2NDI4NiAxOS43MTIzIDAgMTkuODA4OCAwIDE5LjkyNjZWMjIuMDY5NUMwIDIyLjE4NzMgMC4wOTY0Mjg2IDIyLjI4MzggMC4yMTQyODYgMjIuMjgzOEgyMS4yMTQzQzIxLjMzMjEgMjIuMjgzOCAyMS40Mjg2IDIyLjE4NzMgMjEuNDI4NiAyMi4wNjk1VjE5LjkyNjZDMjEuNDI4NiAxOS44MDg4IDIxLjMzMjEgMTkuNzEyMyAyMS4yMTQzIDE5LjcxMjNaIiBmaWxsPSJjdXJyZW50Q29sb3IiLz48L3N2Zz4=
    counter:
      type: "item"
      props:
        reqIndex: "0"
        # JSONPath to taints array for counter calculation
        jsonPathToArray: .items.0.spec.taints
    activeType:
      type: "taints"
      props:
        reqIndex: "0"
        # JSONPath to taints array for edit modal
        jsonPathToArray: .items.0.spec.taints
        notificationSuccessMessage: Updated successfully
        notificationSuccessMessageDescription: Taints have been updated
        modalTitle: Edit taints
        modalDescriptionText: ""
        inputLabel: ""
        # API endpoint for PATCH/UPDATE
        endpoint: {{ .endpoint | quote }}
        # JSON Pointer path for patch operation
        pathToValue: /spec/taints
        editModalWidth: 800px
        cols: [8, 8, 6]
        permissionContext:
          # RBAC/permission context for edit actions
          {{- toYaml .permissionContext | nindent 10 }}
{{- end -}}


{{- define "in-cloud.web.aggregatedCounterCard.images" -}}
- type: AggregatedCounterCard
  data:
    id: images-counter-card
    text: Images
    # Icon for Images card (Base64-encoded SVG)
    iconBase64Encoded: PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIj48cGF0aCBkPSJNMjMuMTQyOSAyLjU2NjQxSDAuODU3MTQzQzAuMzgzMDM2IDIuNTY2NDEgMCAyLjk0OTQ0IDAgMy40MjM1NVYyMC41NjY0QzAgMjEuMDQwNSAwLjM4MzAzNiAyMS40MjM2IDAuODU3MTQzIDIxLjQyMzZIMjMuMTQyOUMyMy42MTcgMjEuNDIzNiAyNCAyMS4wNDA1IDI0IDIwLjU2NjVWMy40MjM1NUMyNCAyLjk0OTQ0IDIzLjYxNyAyLjU2NjQxIDIzLjE0MjkgMi41NjY0MVpNMjIuMDcxNCAxOS40OTVIMS45Mjg1N1YxOC40MjYyTDUuNjM4MzkgMTQuMDI1M0w5LjY1ODkzIDE4Ljc5MzJMMTUuOTEzNCAxMS4zNzg5TDIyLjA3MTQgMTguNjgwN1YxOS40OTVaTTIyLjA3MTQgMTYuMDE4MkwxNi4wNzY4IDguOTA5MjZDMTUuOTkxMSA4LjgwNzQ4IDE1LjgzNTcgOC44MDc0OCAxNS43NSA4LjkwOTI2TDkuNjU4OTMgMTYuMTMwN0w1LjgwMTc5IDExLjU1ODRDNS43MTYwNyAxMS40NTY2IDUuNTYwNzEgMTEuNDU2NiA1LjQ3NSAxMS41NTg0TDEuOTI4NTcgMTUuNzYzN1Y0LjQ5NDk4SDIyLjA3MTRWMTYuMDE4MlpNNi40Mjg1NyAxMC40OTVDNi43MzgxMiAxMC40OTUgNy4wNDQ2MyAxMC40MzQgNy4zMzA2MSAxMC4zMTU2QzcuNjE2NTkgMTAuMTk3MSA3Ljg3NjQ0IDEwLjAyMzUgOC4wOTUzMiA5LjgwNDU5QzguMzE0MiA5LjU4NTcxIDguNDg3ODMgOS4zMjU4NiA4LjYwNjI5IDkuMDM5ODhDOC43MjQ3NCA4Ljc1Mzg5IDguNzg1NzEgOC40NDczOCA4Ljc4NTcxIDguMTM3ODRDOC43ODU3MSA3LjgyODI5IDguNzI0NzQgNy41MjE3OCA4LjYwNjI5IDcuMjM1OEM4LjQ4NzgzIDYuOTQ5ODEgOC4zMTQyIDYuNjg5OTYgOC4wOTUzMiA2LjQ3MTA4QzcuODc2NDQgNi4yNTIyIDcuNjE2NTkgNi4wNzg1OCA3LjMzMDYxIDUuOTYwMTJDNy4wNDQ2MyA1Ljg0MTY2IDYuNzM4MTIgNS43ODA2OSA2LjQyODU3IDUuNzgwNjlDNS44MDM0MiA1Ljc4MDY5IDUuMjAzODcgNi4wMjkwMyA0Ljc2MTgyIDYuNDcxMDhDNC4zMTk3NyA2LjkxMzEzIDQuMDcxNDMgNy41MTI2OCA0LjA3MTQzIDguMTM3ODRDNC4wNzE0MyA4Ljc2Mjk5IDQuMzE5NzcgOS4zNjI1NCA0Ljc2MTgyIDkuODA0NTlDNS4yMDM4NyAxMC4yNDY2IDUuODAzNDIgMTAuNDk1IDYuNDI4NTcgMTAuNDk1Wk02LjQyODU3IDcuMzg3ODRDNi44NDM3NSA3LjM4Nzg0IDcuMTc4NTcgNy43MjI2NiA3LjE3ODU3IDguMTM3ODRDNy4xNzg1NyA4LjU1MzAxIDYuODQzNzUgOC44ODc4NCA2LjQyODU3IDguODg3ODRDNi4wMTMzOSA4Ljg4Nzg0IDUuNjc4NTcgOC41NTMwMSA1LjY3ODU3IDguMTM3ODRDNS42Nzg1NyA3LjcyMjY2IDYuMDEzMzkgNy4zODc4NCA2LjQyODU3IDcuMzg3ODRaIiBmaWxsPSJjdXJyZW50Q29sb3IiLz48L3N2Zz4=
    counter:
      type: "item"
      props:
        reqIndex: "0"
        # JSONPath to images array for counter calculation
        jsonPathToArray: .items.0.status.images
    activeType:
      type: "table"
      props:
        id: images-table
        modalTitle: "Images"
        editModalWidth: 80vw
        baseprefix: /openapi-ui
        cluster: "{2}"
        customizationId: factory-node-images
        # JSONPath to images array for table rendering
        pathToItems: .items.0.status.images
        # Key used as unique row identifier
        pathToKey: .names[0]
        fieldSelector:
          # Field selector for server-side filtering
          {{- toYaml .fieldSelector | nindent 10 }}
        k8sResourceToFetch:
          # K8s resource descriptor for table data source
          {{- toYaml .k8sResourceToFetch | nindent 10 }}
        permissionContext:
          # RBAC/permission context for read actions
          {{- toYaml .permissionContext | nindent 10 }}
{{- end -}}
