### incloud-web — Helm chart for Kubernetes Web UI InCloud

**Summary:**  
The chart deploys two containers — `bff` and `web` — for the InCloud Web UI.  
It supports flexible configuration via `values.yaml`, ships CRDs from the `crds/` directory, and includes production-ready settings such as probes, `securityContext`, and `affinity`/topology spread.  
All templates are structured with Helm best practices and helpers.

#### Requirements

- Kubernetes `>= 1.22`  
- Helm `>= 3.8`  
- (Optional) Access to a private container registry via `imagePullSecrets`

#### Quick start

```bash
# Install locally from the chart directory
helm install incloud-web ./incloud-web -n default

# Preview rendered manifests
helm template incloud-web ./incloud-web --namespace default

# Upgrade
helm upgrade incloud-web ./incloud-web -n default
```

### Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `nameOverride` | string | `""` | Override chart name (empty = default name) |
| `fullnameOverride` | string | `""` | Override full release name (empty = default) |
| `replicaCount` | int | `1` | Number of Pod replicas |
| `imagePullSecrets` | list | `[]` | Secrets for pulling images from private registries |
| `priorityClassName` | string | `"system-cluster-critical"` | Priority class for the pod |
| `serviceAccount.create` | bool | `true` | Create ServiceAccount |
| `serviceAccount.name` | string | `""` | ServiceAccount name (defaults to `<release>-<chart>`) |
| `serviceAccount.annotations` | object | `{}` | Additional annotations for ServiceAccount |
| `podAnnotations` | object | `{}` | Annotations for Pod |
| `podLabels` | object | `{}` | Extra labels for Pod |
| `podSecurityContext.enabled` | bool | `true` | Enable Pod-level security context |
| `podSecurityContext.fsGroup` | int | `101` | Group ID for mounted volumes |
| `podSecurityContext.fsGroupChangePolicy` | string | `"OnRootMismatch"` | Policy for changing fsGroup |
| `nodeSelector` | object | `{}` | Node selector for scheduling |
| `tolerations` | list | `[]` | Tolerations for scheduling |
| `affinity` | object | `{}` | Pod affinity rules (overridden if explicitly set) |
| `topologySpreadConstraints` | list | `[]` | Raw topology spread constraints |
| `dnsPolicy` | string | `"ClusterFirst"` | DNS policy for Pod |
| `hostNetwork` | bool | `false` | Use host network namespace |
| `hostPID` | bool | `false` | Use host PID namespace |
| `hostIPC` | bool | `false` | Use host IPC namespace |
| `schedulerName` | string | `"default-scheduler"` | Scheduler to use |
| `runtimeClassName` | string | `""` | RuntimeClass for Pod |
| `enableServiceLinks` | bool | `false` | Inject service links into Pod |
| `preemptionPolicy` | string | `""` | Pod preemption policy |
| `volumes` | list | `[]` | Additional volumes |
| `service.enabled` | bool | `true` | Create Service resource |
| `service.type` | string | `"ClusterIP"` | Kubernetes Service type |
| `service.annotations` | object | `{}` | Additional Service annotations |
| `service.labels` | object | `{}` | Additional Service labels |
| `service.ports` | list | See default | List of Service ports |
| `bff.enabled` | bool | `true` | Deploy `bff` container |
| `bff.name` | string | `"bff"` | Container name |
| `bff.image.repository` | string | `"sgroups/openapi-ui-k8s-bff"` | BFF image repository |
| `bff.image.tag` | string | `"main-d5191413"` | BFF image tag |
| `bff.image.pullPolicy` | string | `"IfNotPresent"` | Image pull policy |
| `bff.containerPort` | int | `64231` | Container port for BFF |
| `bff.extraContainerPorts` | list | `[]` | Additional container ports |
| `bff.env` | object | See default | Environment variables for BFF |
| `bff.envFrom` | list | `[]` | ConfigMap/Secret references |
| `bff.resources` | object | See default | Resource requests/limits |
| `bff.securityContext.enabled` | bool | `true` | Enable security context |
| `bff.livenessProbe.enabled` | bool | `true` | Enable liveness probe |
| `bff.readinessProbe.enabled` | bool | `false` | Enable readiness probe |
| `bff.volumeMounts` | list | `[]` | Additional volume mounts |
| `bff.terminationMessagePath` | string | `"/dev/termination-log"` | Path for termination message |
| `bff.terminationMessagePolicy` | string | `"File"` | Termination message policy |
| `web.enabled` | bool | `true` | Deploy `web` container |
| `web.name` | string | `"web"` | Container name |
| `web.image.repository` | string | `"sgroups/openapi-ui"` | Web image repository |
| `web.image.tag` | string | `"main-0b206491"` | Web image tag |
| `web.image.pullPolicy` | string | `"IfNotPresent"` | Image pull policy |
| `web.containerPort` | int | `8080` | Container port for Web UI |
| `web.extraContainerPorts` | list | `[]` | Additional container ports |
| `web.env` | object | See default | Environment variables for Web |
| `web.envFrom` | list | `[]` | ConfigMap/Secret references |
| `web.resources` | object | See default | Resource requests/limits |
| `web.securityContext.enabled` | bool | `true` | Enable security context |
| `web.livenessProbe.enabled` | bool | `true` | Enable liveness probe |
| `web.readinessProbe.enabled` | bool | `false` | Enable readiness probe |
| `web.volumeMounts` | list | `[]` | Additional volume mounts |
| `web.terminationMessagePath` | string | `"/dev/termination-log"` | Path for termination message |
| `web.terminationMessagePolicy` | string | `"File"` | Termination message policy |
| `selectorLabels` | object | See default | Default selector labels |
| `extraPodSpec` | object | `{}` | Raw extra PodSpec additions |
| `extraTemplateMetadata.annotations` | object | `{}` | Extra template annotations |
| `extraTemplateMetadata.labels` | object | `{}` | Extra template labels |
