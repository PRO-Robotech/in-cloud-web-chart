{{- define "in-cloud.web.header.left" -}}
# =========================
# Resource kind badge
# =========================
- type: ResourceBadge
  data:
    id: factory-resource-badge
    style:
      fontSize: 20px
    value: '{reqsJsonPath[0][".items.0.kind"]["-"]}'

# =========================
# Resource name dropdown with redirect
# =========================
- type: DropdownRedirect
  data:
    # K8s resource addressing (parameterized)
    {{ toYaml .k8sResourceToFetch | nindent 4 }}

    currentValue: "{reqsJsonPath[0]['.items.0.metadata.name']['Select item...']}"
    id: resource-name-dropdown
    jsonPath: .metadata.name
    placeholder: Select item...
    popupMatchSelectWidth: 350

    # Redirect URL template (parameterized)
    redirectUrl: {{ .redirectUrl | quote }}

# =========================
# Copy resource name action
# =========================
- type: CopyButton
  data:
    id: copy-resource-name
    copyText: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
    successMessage: Name copied to clipboard.
    tooltip: Copy {reqsJsonPath[0]['.items.0.kind']['-']} name
{{- end -}}
