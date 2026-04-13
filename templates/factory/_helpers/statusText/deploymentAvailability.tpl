{{/*
  StatusText for Deployment row: derives Available / Error / Progressing from condition reasons.
*/}}
{{- define "in-cloud.web.statusText.deploymentAvailability" -}}
{{- $itemPath := ".items.0" -}}
{{- if hasKey . "itemPath" -}}
{{- $itemPath = .itemPath -}}
{{- end -}}
- type: StatusText
  data:
    id: header-status
    # values: JSONPath expressions whose results are matched by the criteria* rules (here: all
    # condition reasons).
    values:
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.conditions[*].reason']['-']}"

    # criteria* / valueToCompare* / strategy*: rules that classify collected values into success,
    # error, or fallback labels.
    criteriaSuccess: equals
    valueToCompareSuccess:
      # Positive reasons
      # Available: all replicas are healthy
      - "MinimumReplicasAvailable"
      # Progressing: new RS serves traffic
      - "NewReplicaSetAvailable"
      # Progressing: RS is updated/synced
      - "ReplicaSetUpdated"
      # Update completed successfully
      - "Complete"

    criteriaError: equals
    valueToCompareError:
      # Negative reasons
      # General replica failure
      - "DeploymentReplicaFailure"
      # Failed to create Pod/RS
      - "FailedCreate"
      # Failed to delete resource
      - "FailedDelete"
      # Failed to scale up
      - "FailedScaleUp"
      # Failed to scale down
      - "FailedScaleDown"

    # 3) Texts to display
    successText:  "Available"
    errorText:    "Error"
    fallbackText: "Progressing"

    # Notes on neutral/fallback cases:
    # - ReplicaSetUpdated        → neutral/positive (update in progress)
    # - ScalingReplicaSet        → neutral (normal scale up/down)
    # - Paused / DeploymentPaused→ neutral (manually paused by admin)
    # - NewReplicaSetCreated     → neutral (new RS created, not yet serving)
    # - FoundNewReplicaSet       → neutral (RS found, syncing)
    # - MinimumReplicasUnavailable → neutral (some replicas not ready yet)
    # - ProgressDeadlineExceeded → error-like, stuck in progress
{{- end -}}
