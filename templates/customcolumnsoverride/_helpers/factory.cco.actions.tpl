{{/*
  ============================================================
  CCO Actions Column Props Helpers
  ------------------------------------------------------------
  Each helper outputs jsonPath + customProps for an "Actions"
  column. Usage in CCO files (analogous to other column props):

    - name: Actions
      type: factory
      {{ include "in-cloud.web.cco.props.actions.X" . | nindent 6 }}

  In CCO (table) context each row IS the resource object:
    name      → {reqsJsonPath[0]['.metadata.name']['-']}
    namespace → {reqsJsonPath[0]['.metadata.namespace']['-']}
  {2} — cluster id segment in UI paths (e.g. /openapi-ui/{2}/... and /api/clusters/{2}/k8s/...).
  reqsJsonPath[0] — first parallel fetch result = the row resource (placeholders in jsonPath/actions resolve against it).
  ============================================================
*/}}

{{/*
  -------------------------------------------------------
  GENERIC: namespaced API resource — edit + delete only
  Params: .apiGroup  .apiVersion  .plural
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.namespacedApi" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/%s/%s/namespaces/%s/%s/%s" .apiGroup .apiVersion $ns .plural $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "apiGroup" .apiGroup "plural" .plural -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}"
                "namespace" $ns
                "apiGroup" .apiGroup
                "apiVersion" .apiVersion
                "plural" .plural
                "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep
              "name" $name
              "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  GENERIC: namespaced builtin resource — edit + delete only
  Params: .apiVersion  .plural
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.namespacedBuiltin" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/api/%s/namespaces/%s/%s/%s" .apiVersion $ns .plural $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "plural" .plural -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}"
                "namespace" $ns
                "apiVersion" .apiVersion
                "plural" .plural
                "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep
              "name" $name
              "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  GENERIC: cluster-scoped API resource — edit + delete only
  Params: .apiGroup  .apiVersion  .plural
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.clusterScopedApi" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/%s/%s/%s/%s" .apiGroup .apiVersion .plural $name -}}
{{- $perm := dict "cluster" "{2}" "apiGroup" .apiGroup "plural" .plural -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}"
                "apiGroup" .apiGroup
                "apiVersion" .apiVersion
                "plural" .plural
                "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep
              "name" $name
              "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  GENERIC: cluster-scoped builtin resource — edit + delete only
  Params: .apiVersion  .plural
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.clusterScopedBuiltin" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/api/%s/%s/%s" .apiVersion .plural $name -}}
{{- $perm := dict "cluster" "{2}" "plural" .plural -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}"
                "apiVersion" .apiVersion
                "plural" .plural
                "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep
              "name" $name
              "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  Deployment — edit + scale + suspend + resume + rolloutRestart + delete
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.deployment" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/apps/v1/namespaces/%s/deployments/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "apiGroup" "apps" "plural" "deployments" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiGroup" "apps" "apiVersion" "v1"
                "plural" "deployments" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.scale" (dict
              "endpoint" (printf "%s/scale" $ep)
              "name" $name "namespace" $ns
              "currentReplicas" "{reqsJsonPath[0]['.spec.replicas']['-']}"
              "permissionContext" (merge (dict "subresource" "scale") $perm)
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.suspend" (dict
              "endpoint" $ep "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.resume" (dict
              "endpoint" $ep "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.rolloutRestart" (dict
              "endpoint" $ep "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  StatefulSet — edit + scale + rolloutRestart + delete
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.statefulset" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/apps/v1/namespaces/%s/statefulsets/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "apiGroup" "apps" "plural" "statefulsets" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiGroup" "apps" "apiVersion" "v1"
                "plural" "statefulsets" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.scale" (dict
              "endpoint" (printf "%s/scale" $ep)
              "name" $name "namespace" $ns
              "currentReplicas" "{reqsJsonPath[0]['.spec.replicas']['-']}"
              "permissionContext" (merge (dict "subresource" "scale") $perm)
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.rolloutRestart" (dict
              "endpoint" $ep "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  DaemonSet — edit + rolloutRestart + delete
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.daemonset" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/apps/v1/namespaces/%s/daemonsets/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "apiGroup" "apps" "plural" "daemonsets" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiGroup" "apps" "apiVersion" "v1"
                "plural" "daemonsets" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.rolloutRestart" (dict
              "endpoint" $ep "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  ReplicaSet — edit + scale + rolloutRestart + delete
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.replicaset" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/apps/v1/namespaces/%s/replicasets/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "apiGroup" "apps" "plural" "replicasets" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiGroup" "apps" "apiVersion" "v1"
                "plural" "replicasets" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.scale" (dict
              "endpoint" (printf "%s/scale" $ep)
              "name" $name "namespace" $ns
              "currentReplicas" "{reqsJsonPath[0]['.spec.replicas']['-']}"
              "permissionContext" (merge (dict "subresource" "scale") $perm)
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.rolloutRestart" (dict
              "endpoint" $ep "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  ReplicationController — edit + scale + delete  (v1 builtin)
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.replicationcontroller" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/api/v1/namespaces/%s/replicationcontrollers/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "plural" "replicationcontrollers" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiVersion" "v1"
                "plural" "replicationcontrollers" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.scale" (dict
              "endpoint" (printf "%s/scale" $ep)
              "name" $name "namespace" $ns
              "currentReplicas" "{reqsJsonPath[0]['.spec.replicas']['-']}"
              "permissionContext" (merge (dict "subresource" "scale") $perm)
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  CronJob — edit + suspend(spec.suspend) + resume(spec.suspend) + delete
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.cronjob" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/batch/v1/namespaces/%s/cronjobs/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "apiGroup" "batch" "plural" "cronjobs" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiGroup" "batch" "apiVersion" "v1"
                "plural" "cronjobs" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.suspend" (dict
              "endpoint" $ep "pathToValue" "/spec/suspend"
              "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.resume" (dict
              "endpoint" $ep "pathToValue" "/spec/suspend"
              "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  Job — edit + suspend(spec.suspend) + resume(spec.suspend) + delete
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.job" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/apis/batch/v1/namespaces/%s/jobs/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "apiGroup" "batch" "plural" "jobs" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiGroup" "batch" "apiVersion" "v1"
                "plural" "jobs" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.suspend" (dict
              "endpoint" $ep "pathToValue" "/spec/suspend"
              "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.resume" (dict
              "endpoint" $ep "pathToValue" "/spec/suspend"
              "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  Pod — edit + evict + delete  (namespace from row data)
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.pod" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ns   := "{reqsJsonPath[0]['.metadata.namespace']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/api/v1/namespaces/%s/pods/%s" $ns $name -}}
{{- $perm := dict "cluster" "{2}" "namespace" $ns "plural" "pods" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}" "namespace" $ns
                "apiVersion" "v1" "plural" "pods" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.evict" (dict
              "endpoint" (printf "%s/eviction" $ep)
              "name" $name "namespace" $ns
              "permissionContext" (merge (dict "subresource" "eviction") $perm)
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}


{{/*
  -------------------------------------------------------
  Node — edit + cordon + uncordon + delete  (cluster-scoped)
  -------------------------------------------------------
*/}}
{{- define "in-cloud.web.cco.props.actions.node" -}}
{{- $name := "{reqsJsonPath[0]['.metadata.name']['-']}" -}}
{{- $ep   := printf "/api/clusters/{2}/k8s/api/v1/nodes/%s" $name -}}
{{- $perm := dict "cluster" "{2}" "plural" "nodes" -}}
jsonPath: .metadata.name
customProps:
  disableEventBubbling: true
  items:
    - type: ActionsDropdown
      data:
        id: row-actions
        buttonVariant: icon
        actions:
          {{ include "in-cloud.web.action.edit" (dict
              "k8sResourceToFetch" (dict
                "cluster" "{2}"
                "apiVersion" "v1" "plural" "nodes" "name" $name
              )
              "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.cordon" (dict
              "endpoint" $ep "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{- include "in-cloud.web.action.uncordon" (dict
              "endpoint" $ep "itemsPath" "" "permissionContext" $perm
            ) | nindent 10 }}
          {{ include "in-cloud.web.action.delete" (dict
              "endpoint" $ep "name" $name "permissionContext" $perm
            ) | nindent 10 }}
{{- end -}}
