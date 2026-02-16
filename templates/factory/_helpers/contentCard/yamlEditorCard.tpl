{{- define "in-cloud.web.contentCard.yamlEditor" -}}
- type: ContentCard
  data:
    id: yaml-editor-card
    style:
      marginBottom: 24px
  children:
    - type: YamlEditorSingleton
      data:
        id: yaml-editor

        # =========================
        # Base editor configuration
        # =========================

        # Request index used to prefill editor with fetched resource
        prefillValuesRequestIndex: 0

        # Height subtracted from viewport to fit layout
        substractHeight: 350

        # JSONPath to resource root in API response
        pathToData: .items.0

        # Indicates whether resource is namespaced or cluster-scoped
        isNameSpaced: {{ .isNameSpaced | default false }}

        # Editor mode/type (e.g. "api", "builtin")
        type: {{ .type | default "api" }}

        # =========================
        # API target (resource addressing)
        # =========================
        # Defines Kubernetes API location for resource CRUD
        {{ toYaml .k8sResourceToFetch | nindent 8 }}

        # =========================
        # Permission context
        # =========================
        # Used by UI to validate RBAC permissions for edit actions
        permissionContext:
          {{ toYaml .permissionContext | nindent 10 }}
{{- end -}}
