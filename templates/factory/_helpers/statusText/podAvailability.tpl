
{{- define "in-cloud.web.statusText.podAvailability" -}}
{{- $itemPath := ".items.0" -}}
{{- if hasKey . "itemPath" -}}
{{- $itemPath = .itemPath -}}
{{- end -}}
- type: StatusText
  data:
    id: pod-status

    # --- Collected values from Pod status -----------------------------------
    values:
      # Init containers
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.initContainerStatuses[*].state.waiting.reason']}"
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.initContainerStatuses[*].state.terminated.reason']}"
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.initContainerStatuses[*].lastState.terminated.reason']}"

      # Main containers
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.containerStatuses[*].state.waiting.reason']}"
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.containerStatuses[*].state.terminated.reason']}"
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.containerStatuses[*].lastState.terminated.reason']}"

      # Pod phase and general reason
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.phase']}"
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.reason']}"

      # Condition reasons (PodScheduled / Initialized / ContainersReady / Ready)
      - "{reqsJsonPath[0]['{{ $itemPath }}.status.conditions[*].reason']}"

    # --- Success criteria ---------------------------------------------------
    criteriaSuccess: notEquals
    strategySuccess: every
    valueToCompareSuccess:
      # Graceful or expected state transitions
      - "Preempted"
      - "Shutdown"
      - "NodeShutdown"
      - "DisruptionTarget"

      # Transitional states (may require timeout)
      - "Unschedulable"
      - "SchedulingGated"
      - "ContainersNotReady"
      - "ContainersNotInitialized"

      # Temporary failures
      - "BackOff"

      # Controlled shutdowns or benign errors
      - "PreStopHookError"
      - "KillError"
      - "ContainerStatusUnknown"

    # --- Error criteria -----------------------------------------------------
    criteriaError: equals
    strategyError: every
    valueToCompareError:
      # Pod-level fatal phases or errors
      - "Failed"
      - "Unknown"
      - "Evicted"
      - "NodeLost"
      - "UnexpectedAdmissionError"

      # Scheduler-related failures
      - "SchedulerError"
      - "FailedScheduling"

      # Container-level fatal errors
      - "CrashLoopBackOff"
      - "ImagePullBackOff"
      - "ErrImagePull"
      - "ErrImageNeverPull"
      - "InvalidImageName"
      - "ImageInspectError"
      - "CreateContainerConfigError"
      - "CreateContainerError"
      - "RunContainerError"
      - "StartError"
      - "PostStartHookError"
      - "ContainerCannotRun"
      - "OOMKilled"
      - "Error"
      - "DeadlineExceeded"
      - "CreatePodSandboxError"

    # --- Output text rendering ----------------------------------------------
    successText:  "{reqsJsonPath[0]['{{ $itemPath }}.status.phase']}"
    errorText:    "{reqsJsonPath[0]['{{ $itemPath }}.status.phase']}"
    fallbackText: "{reqsJsonPath[0]['{{ $itemPath }}.status.phase']}"
{{- end -}}
