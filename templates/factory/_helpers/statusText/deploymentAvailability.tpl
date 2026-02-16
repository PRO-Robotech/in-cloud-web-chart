
{{- define "in-cloud.web.statusText.deploymentAvailability" -}}
{{- $itemPath := ".items.0" -}}
{{- if hasKey . "itemPath" -}}
{{- $itemPath = .itemPath -}}
{{- end -}}
- type: StatusText
  data:
    id: header-status
    # 1) Collect all possible Deployment conditions
    values:
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.conditions[*].reason']['-']}"

    # 2) Criteria: positive / negative; neutral goes to fallback
    criteriaSuccess: equals
    valueToCompareSuccess:
      # Positive reasons
      - "MinimumReplicasAvailable"     # Available: all replicas are healthy
      - "NewReplicaSetAvailable"       # Progressing: new RS serves traffic
      - "ReplicaSetUpdated"            # Progressing: RS is updated/synced
      - "Complete"                     # Update completed successfully

    criteriaError: equals
    valueToCompareError:
      # Negative reasons
      - "DeploymentReplicaFailure"     # General replica failure
      - "FailedCreate"                 # Failed to create Pod/RS
      - "FailedDelete"                 # Failed to delete resource
      - "FailedScaleUp"                # Failed to scale up
      - "FailedScaleDown"              # Failed to scale down

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
