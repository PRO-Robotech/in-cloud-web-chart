{{/*
============================================================================
CustomFormsOverride: shared helpers (hidden.metadata.tpl)
----------------------------------------------------------------------------
Shared path lists for spec.hidden: hide system, read-only, and redundant
fields so they are not shown in the generated form. Included via `include`
in CFO manifests; there is no separate toggle — they are used only where
the CFO template includes them.
============================================================================
*/}}

{{/*
define: incloud-web-chart.customformoverride.hidden.metadata.system
Hides top-level metadata.*: creationTimestamp, uid, resourceVersion,
managedFields, ownerReferences, finalizers, etc. — fields managed by the
API server; users should not edit them in the form.
*/}}
{{- define "incloud-web-chart.customformoverride.hidden.metadata.system" -}}
- - metadata
  - creationTimestamp
- - metadata
  - deletionGracePeriodSeconds
- - metadata
  - deletionTimestamp
- - metadata
  - finalizers
- - metadata
  - generateName
- - metadata
  - generation
- - metadata
  - managedFields
- - metadata
  - ownerReferences
- - metadata
  - resourceVersion
- - metadata
  - selfLink
- - metadata
  - uid
{{- end -}}


{{/*
define: incloud-web-chart.customformoverride.hidden.job-template.metadata.system
The same system metadata fields, but under spec.jobTemplate.metadata for CronJob
(embedded Job template): timestamps, uid, managedFields, namespace in the template,
etc. — not for manual entry in the form.
*/}}
{{- define "incloud-web-chart.customformoverride.hidden.job-template.metadata.system" -}}
- - spec
  - jobTemplate
  - metadata
  - creationTimestamp
- - spec
  - jobTemplate
  - metadata
  - namespace
- - spec
  - jobTemplate
  - metadata
  - deletionGracePeriodSeconds
- - spec
  - jobTemplate
  - metadata
  - deletionTimestamp
- - spec
  - jobTemplate
  - metadata
  - finalizers
- - spec
  - jobTemplate
  - metadata
  - generateName
- - spec
  - jobTemplate
  - metadata
  - generation
- - spec
  - jobTemplate
  - metadata
  - managedFields
- - spec
  - jobTemplate
  - metadata
  - ownerReferences
- - spec
  - jobTemplate
  - metadata
  - resourceVersion
- - spec
  - jobTemplate
  - metadata
  - selfLink
- - spec
  - jobTemplate
  - metadata
  - uid
{{- end -}}

{{/*
define: incloud-web-chart.customformoverride.hidden.template.metadata.system
metadata of the embedded Pod template (spec.template.metadata) for workloads: the same
system fields as root metadata (uid, managedFields, …), plus
namespace in the template — to avoid duplicating editing of operational fields.
*/}}
{{- define "incloud-web-chart.customformoverride.hidden.template.metadata.system" -}}
- - spec
  - template
  - metadata
  - creationTimestamp
- - spec
  - template
  - metadata
  - namespace
- - spec
  - template
  - metadata
  - deletionGracePeriodSeconds
- - spec
  - template
  - metadata
  - deletionTimestamp
- - spec
  - template
  - metadata
  - finalizers
- - spec
  - template
  - metadata
  - generateName
- - spec
  - template
  - metadata
  - generation
- - spec
  - template
  - metadata
  - managedFields
- - spec
  - template
  - metadata
  - ownerReferences
- - spec
  - template
  - metadata
  - resourceVersion
- - spec
  - template
  - metadata
  - selfLink
- - spec
  - template
  - metadata
  - uid
{{- end -}}

{{/*
define: incloud-web-chart.customformoverride.hidden.metadata.api
kind and apiVersion are determined by the resource type; hide from the form as non-editable.
*/}}
{{- define "incloud-web-chart.customformoverride.hidden.metadata.api" -}}
- - kind
- - apiVersion
{{- end -}}

{{/*
define: incloud-web-chart.customformoverride.hidden.status
status is populated by controllers; not edited in create/edit forms.
*/}}
{{- define "incloud-web-chart.customformoverride.hidden.status" -}}
- - status
{{- end -}}
