{{- define "in-cloud.web.usageGraph.pod.cpu" -}}
- type: UsageGraphCard
  data:
    title: CPU, cores
    # Base URL of Prometheus-compatible API (overridable via values)
    baseUrl: {{ .baseUrl | default "https://demo.in-cloud.io/monitoring/api/v1/" | quote }}
    containerStyle:
      # Card container height
      height: 250px
    # Strategy used by UI to interpret values
    valueStrategy: cpu
    # Time range for the graph
    range: 15m
    # Auto refresh interval in ms
    refetchInterval: 10000
    # Conversion settings: raw values -> CPU cores
    converterCoresProps:
      id: cpu
      precision: 2
      format: true
      toUnit: core
      showUnit: false
    # Gradient colors for usage visualization
    minColor: "#2A7B9B"
    midColor: "#57C785"
    maxColor: "#EDDD53"
    # Main query: actual CPU usage per node instance
    query: |
      sum by (instance) (
        rate(
          node_cpu_seconds_total{
            mode!~"idle|iowait|steal"
          }[$__rate_interval]
        )
      )
      * on(instance)
      label_replace(
        kube_node_info{node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"},
        "instance", "$1:9100", "internal_ip", "(.*)"
      )
    # Used resources query (same as main query)
    usedQuery: |
      sum by (instance) (
        rate(
          node_cpu_seconds_total{
            mode!~"idle|iowait|steal"
          }[$__rate_interval]
        )
      )
      * on(instance)
      label_replace(
        kube_node_info{node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"},
        "instance", "$1:9100", "internal_ip", "(.*)"
      )
    # Requested CPU by pods scheduled on this node
    requestedQuery: |
      sum(
        kube_pod_container_resource_requests{
          resource="cpu",
          node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        }
      )
    # CPU capacity of the node (limits baseline)
    limitQuery: |
      machine_cpu_cores{
        node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
      }
{{- end -}}


{{- define "in-cloud.web.usageGraph.pod.memory" -}}
- type: UsageGraphCard
  data:
    title: Memory, GB
    # Base URL of Prometheus-compatible API (overridable via values)
    baseUrl: {{ .baseUrl | default "https://demo.in-cloud.io/monitoring/api/v1/" | quote }}
    # Strategy used by UI to interpret values
    valueStrategy: memory
    # Time range for the graph
    range: 15m
    # Auto refresh interval in ms
    refetchInterval: 10000
    containerStyle:
      # Card container height
      height: 250px
    # Conversion settings: bytes -> GiB (IEC)
    converterBytesProps:
      toUnit: "gi"
      format: true
      showUnit: false
      precision: 1
      standard: iec
    # Gradient colors for usage visualization
    minColor: "#2A7B9B"
    midColor: "#57C785"
    maxColor: "#EDDD53"
    # Main query: used memory on node
    query: |
      (
        sum by (instance) (node_memory_MemTotal_bytes)
      -
        sum by (instance) (node_memory_MemAvailable_bytes)
      )
      * on(instance) group_left(node)
      label_replace(
        kube_node_info{node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"},
        "instance", "$1:9100", "internal_ip", "(.*)"
      )
    # Used resources query (same as main query)
    usedQuery: |
      (
        sum by (instance) (node_memory_MemTotal_bytes)
      -
        sum by (instance) (node_memory_MemAvailable_bytes)
      )
      * on(instance) group_left(node)
      label_replace(
        kube_node_info{node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"},
        "instance", "$1:9100", "internal_ip", "(.*)"
      )
    # Requested memory by running pods on this node
    requestedQuery: |
      sum by (node)(
        kube_pod_container_resource_requests{
          resource="memory",
          node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        }
        *
        on(namespace, pod)
        group_left()
        (
          kube_pod_status_phase{phase="Running"} == 1
        )
      )
    # Memory capacity of the node (limits baseline)
    limitQuery: |
      machine_memory_bytes{
        node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
      }
{{- end -}}


{{- define "in-cloud.web.usageGraph.pod.storage" -}}
- type: UsageGraphCard
  data:
    title: Storage, bytes
    # Base URL of Prometheus-compatible API (overridable via values)
    baseUrl: {{ .baseUrl | default "https://demo.in-cloud.io/monitoring/api/v1/" | quote }}
    # Strategy used by UI to interpret values
    valueStrategy: storage
    # Time range for the graph
    range: 15m
    # Auto refresh interval in ms
    refetchInterval: 10000
    containerStyle:
      # Card container height
      height: 250px
    # Conversion settings: bytes -> GiB (IEC)
    converterBytesProps:
      toUnit: "gi"
      format: true
      showUnit: false
      precision: 1
    # Gradient colors for usage visualization
    minColor: "#2A7B9B"
    midColor: "#57C785"
    maxColor: "#EDDD53"
    # Main query: raw container FS usage (coarse usage signal)
    query: |
      sum(
        container_fs_usage_bytes{
          node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        }
      )
    # Used resources query: filesystem used on root mount
    usedQuery: |
      (
        node_filesystem_size_bytes{mountpoint="/", fstype!~"tmpfs|overlay|squashfs"}
      -
        node_filesystem_avail_bytes{mountpoint="/", fstype!~"tmpfs|overlay|squashfs"}
      )
      * on(instance) group_left(node)
      label_replace(
        kube_node_info{node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"},
        "instance", "$1:9100", "internal_ip", "(.*)"
      )
    # Requested ephemeral storage by running pods on this node
    requestedQuery: |
      sum by (node)(
        sum by (namespace, pod) (
          kube_pod_container_resource_requests{
            resource="ephemeral_storage"
          }
        )
        *
        on(namespace, pod)
        group_left(node)
        kube_pod_info{
          node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        }
        *
        on(namespace, pod)
        (
          kube_pod_status_phase{phase="Running"} == 1
        )
      )
    # Total filesystem capacity on root mount (limits baseline)
    limitQuery: |
      node_filesystem_size_bytes{
        mountpoint="/",
        fstype!~"tmpfs|overlay|squashfs"
      }
      * on(instance) group_left(node)
      label_replace(
        kube_node_info{
          node="{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
        },
        "instance",
        "$1:9100",
        "internal_ip",
        "(.*)"
      )
{{- end -}}
