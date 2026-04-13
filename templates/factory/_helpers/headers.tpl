{{- define "in-cloud.web.header.left" -}}
{{/*
  headers.tpl — left header strip for Factory pages (ResourceBadge, DropdownRedirect, CopyButton).
  Callers pass .k8sResourceToFetch and .redirectUrl. Output uses “#” YAML comments in the CR payload.
*/}}
# --- ResourceBadge: shows the resource Kind as a badge ---
- type: ResourceBadge
  data:
    id: factory-resource-badge
    # Ant Design: badge label font size
    style:
      fontSize: 20px
    value: '{reqsJsonPath[0][".items.0.kind"]["-"]}'

# --- DropdownRedirect: dropdown to switch between resources of the same type; navigates on select
# ---
- type: DropdownRedirect
  data:
    # k8sResourceToFetch: list request addressing (cluster, namespace, apiGroup, plural, endpoint,
    # …)
    {{ toYaml .k8sResourceToFetch | nindent 4 }}

    # currentValue: reqsJsonPath for the open resource’s name; bracket default is placeholder text
    # when missing
    currentValue: "{reqsJsonPath[0]['.items.0.metadata.name']['Select item...']}"
    id: resource-name-dropdown
    # jsonPath: path on each list item to read names for dropdown options
    jsonPath: .metadata.name
    # placeholder: fallback when no name is loaded yet
    placeholder: Select item...
    # Ant Design Select: popup width matches trigger (350px here)
    popupMatchSelectWidth: 350

    # redirectUrl: URL template after selection; {chosenEntryValue} is replaced with the chosen name
    redirectUrl: {{ .redirectUrl | quote }}

# --- CopyButton: copies resource name to clipboard ---
- type: CopyButton
  data:
    id: copy-resource-name
    copyText: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
    successMessage: Name copied to clipboard.
    tooltip: Copy {reqsJsonPath[0]['.items.0.kind']['-']} name
{{- end -}}
