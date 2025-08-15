### incloud-web

Helm chart for deploying the InCloud Web UI in Kubernetes.

**Summary**  
This chart provisions three containers: `bff` (backend-for-frontend), `web` (frontend UI), and `nginx` (reverse proxy), providing a complete web UI stack for InCloud.  
It offers flexible configuration via `values.yaml`, supports CRDs from the `crds/` directory, and includes production-ready defaults for probes, security context, and scheduling.  
All templates are structured according to Helm best practices and use helper templates.

#### Requirements

- Kubernetes `>= 1.22`
- Helm `>= 3.8`
- (Optional) Access to a private container registry via `imagePullSecrets`

#### Quick start

```bash
# Install from local chart directory
helm install incloud-web ./incloud-web -n default

# Render manifests without installing
helm template incloud-web ./incloud-web --namespace default

# Upgrade an existing release
helm upgrade incloud-web ./incloud-web -n default
```

### Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `nameOverride` | string | `""` | Override the chart name. |
| `fullnameOverride` | string | `""` | Override the full release name. |
| `replicaCount` | int | `1` | Number of Pod replicas. |
| `imagePullSecrets` | list | `[]` | List of secrets for pulling images from private registries. |
| `priorityClassName` | string | `"system-cluster-critical"` | Priority class name for the Pod. |
| `serviceAccount.create` | bool | `true` | Whether to create a ServiceAccount. |
| `serviceAccount.name` | string | `""` | Name of the ServiceAccount (defaults to `<release>-<chart>` if not set). |
| `serviceAccount.annotations` | object | `{}` | Annotations to add to the ServiceAccount. |
| `podAnnotations` | object | `{}` | Annotations to add to the Pod. |
| `podLabels` | object | `{}` | Additional labels to add to the Pod. |
| `podSecurityContext.enabled` | bool | `true` | Enable pod-level security context. |
| `podSecurityContext.fsGroup` | int | `101` | Group ID for mounted volumes. |
| `podSecurityContext.fsGroupChangePolicy` | string | `"OnRootMismatch"` | Policy for changing the fsGroup. |
| `nodeSelector` | object | `{}` | Node selector for scheduling Pods. |
| `tolerations` | list | `[]` | Tolerations for scheduling Pods. |
| `affinity` | object | `{}` | Affinity rules for Pods (explicitly overrides defaults if set). |
| `topologySpreadConstraints` | list | `[]` | Topology spread constraints for Pods. |
| `dnsPolicy` | string | `"ClusterFirst"` | DNS policy for the Pod. |
| `hostNetwork` | bool | `false` | Use the host's network namespace. |
| `hostPID` | bool | `false` | Use the host's PID namespace. |
| `hostIPC` | bool | `false` | Use the host's IPC namespace. |
| `schedulerName` | string | `"default-scheduler"` | Scheduler name for the Pod. |
| `runtimeClassName` | string | `""` | RuntimeClass for the Pod. |
| `enableServiceLinks` | bool | `false` | Enable service links in the Pod. |
| `preemptionPolicy` | string | `""` | Preemption policy for the Pod. |
| `volumes` | list | `[]` | Additional volumes for the Pod. |
| `service.enabled` | bool | `true` | Whether to create a Kubernetes Service resource. |
| `service.type` | string | `"ClusterIP"` | Type of Kubernetes Service. |
| `service.annotations` | object | `{}` | Annotations to add to the Service. |
| `service.labels` | object | `{}` | Labels to add to the Service. |
| `service.ports` | list | <!-- See default in values.yaml --> | List of ports for the Service. <!-- See default --> |
| `bff.enabled` | bool | `true` | Enable the `bff` container. |
| `bff.name` | string | `"bff"` | Name of the bff container. |
| `bff.image.repository` | string | `"sgroups/openapi-ui-k8s-bff"` | bff image repository. |
| `bff.image.tag` | string | `"main-d5191413"` | bff image tag. |
| `bff.image.pullPolicy` | string | `"IfNotPresent"` | bff image pull policy. |
| `bff.containerPort` | int | `64231` | Main port for the bff container. |
| `bff.extraContainerPorts` | list | `[]` | Additional ports for the bff container. |
| `bff.env` | object | <!-- See default in values.yaml --> | Environment variables for the bff container. <!-- See default --> |
| `bff.envFrom` | list | `[]` | Environment variable sources (ConfigMap/Secret) for bff. |
| `bff.resources` | object | <!-- See default in values.yaml --> | Resource requests and limits for the bff container. <!-- See default --> |
| `bff.securityContext.enabled` | bool | `true` | Enable security context for the bff container. |
| `bff.livenessProbe.enabled` | bool | `true` | Enable liveness probe for the bff container. |
| `bff.readinessProbe.enabled` | bool | `false` | Enable readiness probe for the bff container. |
| `bff.volumeMounts` | list | `[]` | Additional volume mounts for the bff container. |
| `bff.terminationMessagePath` | string | `"/dev/termination-log"` | Path for the bff container's termination message. |
| `bff.terminationMessagePolicy` | string | `"File"` | Termination message policy for the bff container. |
| `web.enabled` | bool | `true` | Enable the `web` container. |
| `web.name` | string | `"web"` | Name of the web container. |
| `web.image.repository` | string | `"sgroups/openapi-ui"` | web image repository. |
| `web.image.tag` | string | `"main-0b206491"` | web image tag. |
| `web.image.pullPolicy` | string | `"IfNotPresent"` | web image pull policy. |
| `web.containerPort` | int | `8080` | Main port for the web container. |
| `web.extraContainerPorts` | list | `[]` | Additional ports for the web container. |
| `web.env` | object | <!-- See default in values.yaml --> | Environment variables for the web container. <!-- See default --> |
| `web.envFrom` | list | `[]` | Environment variable sources (ConfigMap/Secret) for web. |
| `web.resources` | object | <!-- See default in values.yaml --> | Resource requests and limits for the web container. <!-- See default --> |
| `web.securityContext.enabled` | bool | `true` | Enable security context for the web container. |
| `web.livenessProbe.enabled` | bool | `true` | Enable liveness probe for the web container. |
| `web.readinessProbe.enabled` | bool | `false` | Enable readiness probe for the web container. |
| `web.volumeMounts` | list | `[]` | Additional volume mounts for the web container. |
| `web.terminationMessagePath` | string | `"/dev/termination-log"` | Path for the web container's termination message. |
| `web.terminationMessagePolicy` | string | `"File"` | Termination message policy for the web container. |
| `nginx.enabled` | bool | `true` | Enable the `nginx` container. |
| `nginx.name` | string | `"nginx"` | Name of the nginx container. |
| `nginx.image.repository` | string |  | nginx image repository. <!-- See default --> |
| `nginx.image.tag` | string |  | nginx image tag. <!-- See default --> |
| `nginx.image.pullPolicy` | string |  | nginx image pull policy. <!-- See default --> |
| `nginx.containerPort` | int |  | Main port for the nginx container. <!-- See default --> |
| `nginx.extraContainerPorts` | list | `[]` | Additional ports for the nginx container. |
| `nginx.env` | object | <!-- See default in values.yaml --> | Environment variables for the nginx container. <!-- See default --> |
| `nginx.envFrom` | list | `[]` | Environment variable sources (ConfigMap/Secret) for nginx. |
| `nginx.resources` | object | <!-- See default in values.yaml --> | Resource requests and limits for the nginx container. <!-- See default --> |
| `nginx.securityContext.enabled` | bool | `true` | Enable security context for the nginx container. |
| `nginx.livenessProbe.enabled` | bool | `true` | Enable liveness probe for the nginx container. |
| `nginx.readinessProbe.enabled` | bool | `false` | Enable readiness probe for the nginx container. |
| `nginx.volumeMounts` | list | `[]` | Additional volume mounts for the nginx container. |
| `nginx.terminationMessagePath` | string |  | Path for the nginx container's termination message. <!-- See default --> |
| `nginx.terminationMessagePolicy` | string |  | Termination message policy for the nginx container. <!-- See default --> |
| `selectorLabels` | object | <!-- See default in values.yaml --> | Selector labels for the Pod. <!-- See default --> |
| `extraPodSpec` | object | `{}` | Additional fields for the PodSpec. |
| `extraTemplateMetadata.annotations` | object | `{}` | Additional annotations for the Pod template. |
| `extraTemplateMetadata.labels` | object | `{}` | Additional labels for the Pod template. |
