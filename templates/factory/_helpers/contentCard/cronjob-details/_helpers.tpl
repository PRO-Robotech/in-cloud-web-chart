{{/*
  CronJob-specific detail cards: schedule, job template, and container lists (via shared table
  helper).
*/}}
{{- define "in-cloud.web.contentCard.cronjobRuntimeFacts" -}}
# Content card with CronJob runtime facts (two columns)
- type: ContentCard
  data:
    id: cronjob-runtime-facts-card
  children:

    - type: antdRow
      data:
        gutter: [24, 12]
        id: cronjob-runtime-grid
      children:


        # LEFT COLUMN — Base info
        - type: antdCol
          data:
            id: cronjob-col-left
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: cronjob-info-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: cronjob-info-icon
                    iconName: InfoCircleOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: cronjob-info-title-text
                    text: "Schedule"
                    style:
                      fontSize: 16px
                      lineHeight: 24px
            - type: DefaultDiv
              data:
                id: cronjob-col-left-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:
                - type: DefaultDiv
                  data:
                    id: cronjob-col-left-scheduling-grid
                    style:
                      display: grid
                      gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                      columnGap: 24px
                      rowGap: 12px
                  children:
                    - type: antdFlex
                      data:
                        gap: 12
                        id: cronjob-col-left-scheduling-stack-a
                        vertical: true
                      children:
                        - type: antdFlex
                          data:
                            gap: 4
                            id: schedule-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: schedule-label
                                strong: true
                                text: Schedule
                            - type: parsedText
                              data:
                                id: schedule-value
                                text: "{reqsJsonPath[0]['.items.0.spec.schedule']['Not configured']}"

                        - type: antdFlex
                          data:
                            gap: 4
                            id: suspend-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: suspend-label
                                strong: true
                                text: Suspend
                            - type: parsedText
                              data:
                                id: suspend-value
                                text: "{reqsJsonPath[0]['.items.0.spec.suspend']['false']}"

                    - type: antdFlex
                      data:
                        gap: 12
                        id: cronjob-col-left-scheduling-stack-b
                        vertical: true
                      children:
                        - type: antdFlex
                          data:
                            gap: 4
                            id: concurrency-policy-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: concurrency-policy-label
                                strong: true
                                text: Concurrency policy
                            - type: parsedText
                              data:
                                id: concurrency-policy-value
                                text: "{reqsJsonPath[0]['.items.0.spec.concurrencyPolicy']['Allow (default)']}"

                        - type: antdFlex
                          data:
                            gap: 4
                            id: starting-deadline-seconds-block
                            vertical: true
                          children:
                            - type: antdText
                              data:
                                id: starting-deadline-seconds-label
                                strong: true
                                text: Start deadline
                            - type: parsedText
                              data:
                                id: starting-deadline-seconds-value
                                text: "{reqsJsonPath[0]['.items.0.spec.startingDeadlineSeconds']['Not configured']}"

                - type: antdFlex
                  data:
                    gap: 12
                    id: cronjob-col-left-history-stack
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: last-schedule-time-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: last-schedule-time-label
                            strong: true
                            text: Last schedule time
                        - type: parsedText
                          data:
                            id: last-schedule-time-value
                            text: "{reqsJsonPath[0]['.items.0.status.lastScheduleTime']['No runs yet']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: last-successful-time-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: last-successful-time-label
                            strong: true
                            text: Last successful time
                        - type: parsedText
                          data:
                            id: last-successful-time-value
                            text: "{reqsJsonPath[0]['.items.0.status.lastSuccessfulTime']['No successful runs yet']}"
        # RIGHT COLUMN — Job template
        - type: antdCol
          data:
            id: cronjob-col-right
            span: 12
            xs: 24
            xl: 12
          children:
            - type: DefaultDiv
              data:
                id: cronjob-job-card-title
                style:
                  display: flex
                  gap: 12px
                  marginBottom: 12px
                  alignItems: center
              children:
                - type: antdIcons
                  data:
                    id: cronjob-job-icon
                    iconName: BranchesOutlined
                    iconProps:
                      size: 24
                      style:
                        fontSize: 24
                        color: token.colorInfo
                - type: antdText
                  data:
                    id: cronjob-job-title-text
                    text: "Job Template"
                    style:
                      fontSize: 16px
                      lineHeight: 24px
            - type: DefaultDiv
              data:
                id: cronjob-col-right-grid
                style:
                  display: grid
                  gridTemplateColumns: repeat(auto-fit, minmax(320px, 1fr))
                  columnGap: 24px
                  rowGap: 12px
              children:
                - type: antdFlex
                  data:
                    gap: 12
                    id: cronjob-col-right-template-stack
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: desired-completions-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: desired-completions-label
                            strong: true
                            text: "Desired completions"
                        - type: parsedText
                          data:
                            id: desired-completions-value
                            text: "{reqsJsonPath[0]['.items.0.spec.jobTemplate.spec.completions']['1 (default)']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: parallelism-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: parallelism-label
                            strong: true
                            text: Parallelism
                        - type: parsedText
                          data:
                            id: parallelism-value
                            text: "{reqsJsonPath[0]['.items.0.spec.jobTemplate.spec.parallelism']['1 (default)']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: active-deadline-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: active-deadline-label
                            strong: true
                            text: "Active deadline"
                        - type: parsedText
                          data:
                            id: active-deadline-value
                            text: "{reqsJsonPath[0]['.items.0.spec.jobTemplate.spec.activeDeadlineSeconds']['Not configured']}"

                - type: antdFlex
                  data:
                    gap: 12
                    id: cronjob-col-right-retention-stack
                    vertical: true
                  children:
                    - type: antdFlex
                      data:
                        gap: 4
                        id: successful-jobs-history-limit-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: successful-jobs-history-limit-label
                            strong: true
                            text: Success history
                        - type: parsedText
                          data:
                            id: successful-jobs-history-limit-value
                            text: "{reqsJsonPath[0]['.items.0.spec.successfulJobsHistoryLimit']['3 (default)']}"

                    - type: antdFlex
                      data:
                        gap: 4
                        id: failed-jobs-history-limit-block
                        vertical: true
                      children:
                        - type: antdText
                          data:
                            id: failed-jobs-history-limit-label
                            strong: true
                            text: Fail history
                        - type: parsedText
                          data:
                            id: failed-jobs-history-limit-value
                            text: "{reqsJsonPath[0]['.items.0.spec.failedJobsHistoryLimit']['1 (default)']}"



{{- end -}}

{{- define "in-cloud.web.contentCard.cronjob.template.initContainersList" -}}
# Content card with CronJob JobTemplate init containers spec
{{/*
  customizationId: UI table override; k8sResourceToFetch: list API for parent CronJob;
  nameFieldSelector: current resource name token
*/}}
{{ include "in-cloud.web.contentCard.genericContainersTableCard" (dict
    "cardId" "init-containers-card"
    "title" "Init Containers"
    "titleRowId" "init-containers-card-title"
    "iconId" "init-containers-info-icon"
    "titleTextId" "init-containers-title-text"
    "tableId" "init-containers-table"
    "customizationId" "container-spec-init-containers-list"
    "pathToItems" ".items.0.spec.jobTemplate.spec.template.spec.initContainers"
    "k8sResourceToFetch" (dict
      "apiGroup" "{6}"
      "apiVersion" "{7}"
      "namespace" "{3}"
      "plural" "{8}"
    )
    "nameFieldSelector" "{9}"
  )
}}
{{- end -}}

{{- define "in-cloud.web.contentCard.cronjob.template.containersList" -}}
# Content card with CronJob JobTemplate containers spec
{{/*
  customizationId: UI table override; k8sResourceToFetch: list API for parent CronJob;
  nameFieldSelector: current resource name token
*/}}
{{ include "in-cloud.web.contentCard.genericContainersTableCard" (dict
    "cardId" "containers-card"
    "title" "Containers"
    "titleRowId" "containers-card-title"
    "iconId" "containers-info-icon"
    "titleTextId" "containers-title-text"
    "tableId" "containers-table"
    "customizationId" "container-spec-containers-list"
    "pathToItems" ".items.0.spec.jobTemplate.spec.template.spec.containers"
    "k8sResourceToFetch" (dict
      "apiGroup" "{6}"
      "apiVersion" "{7}"
      "namespace" "{3}"
      "plural" "{8}"
    )
    "nameFieldSelector" "{9}"
  )
}}
{{- end -}}
