{{- define "in-cloud.web.contentCard.yamlEditor" -}}
# YamlEditor card: edit resource YAML with API/builtin resolution, prefetched data, and RBAC for
# saves.
- type: ContentCard
  data:
    id: yaml-editor-card
    # AntD: card spacing
    style:
      marginBottom: 24px
  children:
    - type: YamlEditorSingleton
      data:
        id: yaml-editor

        # =========================
        # Base editor configuration
        # =========================

        # Request index in factory context (reqIndex) for prefill data
        prefillValuesRequestIndex: 0

        # Height subtracted from viewport to fit layout
        substractHeight: 350

        # JSONPath to resource root in API response (openapi-ui resource shape)
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
