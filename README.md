# in-Cloud Web Chart

Helm chart for deploying **in-Cloud Web UI** to Kubernetes.

## Overview

The chart deploys up to four containers in a single Pod:

| Container | Purpose | Default port |
|-----------|---------|--------------|
| **web** | Frontend UI (OpenAPI UI) | 8080 |
| **nginx** | Reverse proxy, routing requests to clusters | 8081 |
| **bff** | Backend-for-Frontend — proxy to the Kubernetes API | 8082 |
| **moduleExample** | Example plugin (optional, disabled by default) | 8083 |
| **moduleRbac** | RBAC plugin (optional) | 8084 |
| **moduleSgroups** | Security groups plugin (optional) | 8085 |

**oauth2-proxy** and **Dex** can optionally be enabled for OIDC authentication.

The chart installs **CRDs** in the `front.in-cloud.io/v1alpha1` group for UI customization — navigation, factories, sidebars, custom columns/forms, and more.

## Architecture

```
                         ┌─────────┐
                         │ Ingress/│
                         │ Istio GW│
                         └────┬────┘
                              │
┌─────────────────────────────┼────────────────────────────────────┐
│  Pod: incloud-web           │                                    │
│                             ▼                                    │
│  ┌──────────┐  ◄───  ┌──────────┐  ───►  ┌──────────┐            │
│  │   web    │        │  nginx   │        │   bff    │            │
│  │  :8080   │        │  :8081   │        │  :8082   │            │
│  │  (UI)    │        │ (proxy)  │        │(k8s API) │            │
│  └──────────┘        └──────────┘        └────┬─────┘            │
│                         │    │                │                  │
│                         │    │                │                  │
│                         │    ▼                │                  │
│                         │ ┌───────────┐       │                  │
│                         │ │  module   │       │                  │
│                         │ │  :8083    │       │                  │
│                         │ │(optional) │       │                  │
│                         │ └───────────┘       │                  │
│                         │                     │                  │
└─────────────────────────┼─────────────────────┼───────────────── ┘
                          │                     │
                          │                ┌────▼────────── ┐
                          │                │ Kubernetes API │
                          │                └─────────────── ┘
                          ▼
                   ┌──────────────┐
                   │   external   │
                   │Kubernetes API│
                   └──────────────┘
```

### nginx routing

| Path | Purpose |
|------|---------|
| `/clusterlist`, `/api/clusters` | JSON list of clusters |
| `/api/clusters/<name>/*` | Proxying to the specified cluster API |
| `/k8s/*` | Proxying to `kubernetes.default.svc:443` (WebSocket) |
| `/openapi-bff/*` | Proxying to the BFF container |
| `/openapi-bff-ws/*` | WebSocket proxying to BFF |
| `/openapi-ui/*` | Proxying to the Web container (SPA) |
| `/openapi-ui-plugin/*` | Proxying to the example plugin (if enabled) |
| `/openapi-ui-plugin-rbac/*` | Proxying to the RBAC plugin (if enabled) |
| `/openapi-ui-plugin-sgroups/*` | Proxying to the sgroups plugin (if enabled) |
| `/dex/*` | Proxying to Dex (if enabled) |
| `/oauth2/*` | Proxying to oauth2-proxy (if enabled) |
| `/healthcheck` | Health-check endpoint |

## Requirements

- Kubernetes `>= 1.22`
- Helm `>= 3.8`
- (Optional) access to a private container registry via `imagePullSecrets`

## Quick start

### Installation from OCI registry

```bash
helm upgrade --install incloud-web oci://registry-1.docker.io/prorobotech/incloud-web-chart --version 0.0.0-feature-CLOUD-484-440fb5a \
  --namespace incloud --create-namespace
```

### Installation from a local directory

```bash
helm dependency update .
helm install incloud-web . --namespace incloud --create-namespace
```

### Render manifests without installing

```bash
helm template incloud-web . --namespace incloud
```

### Upgrade release

```bash
helm upgrade incloud-web . --namespace incloud
```

### With authentication enabled (oauth2-proxy + Dex)

```bash
helm install incloud-web . \
  --namespace incloud --create-namespace \
  --set oauth2-proxy.enabled=true \
  --set dex.enabled=true
```

## Dependencies

| Chart | Version | Repository | Condition |
|-------|---------|------------|-----------|
| oauth2-proxy | 7.18.0 | https://oauth2-proxy.github.io/manifests | `oauth2-proxy.enabled` |
| dex | 0.23.1 | https://charts.dexidp.io | `dex.enabled` |

Dependency archives are included under `charts/`. To update them if needed:

```bash
helm dependency update .
```

## Configuration

Full configuration is defined in `values.yaml` (~1186 lines). Below are the main parameters.

### Global parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `nameOverride` | string | `""` | Override chart name |
| `fullnameOverride` | string | `""` | Override full release name |
| `replicaCount` | int | `1` | Number of Pod replicas |
| `imagePullSecrets` | list | `[]` | Secrets for private registries |
| `priorityClassName` | string | `"system-cluster-critical"` | Priority class for the Pod |
| `basePrefix` | string | `"openapi-ui"` | Base URL prefix for the application |

### ServiceAccount

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `serviceAccount.create` | bool | `true` | Whether to create a ServiceAccount |
| `serviceAccount.name` | string | `""` | ServiceAccount name (default: `<release>-<chart>`) |
| `serviceAccount.annotations` | object | `{}` | ServiceAccount annotations |

### Pod

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `podAnnotations` | object | `{}` | Pod annotations |
| `podLabels` | object | `{}` | Additional Pod labels |
| `podSecurityContext.enabled` | bool | `true` | Enable pod-level security context |
| `podSecurityContext.fsGroup` | int | `101` | Group ID for mounted volumes |
| `nodeSelector` | object | `{}` | Node selector |
| `tolerations` | list | `[]` | Pod tolerations |
| `topologySpreadConstraints` | list | `[]` | Topology spread constraints |
| `podDisruptionBudget.minAvailable` | int | `1` | Minimum available Pods (PDB) |
| `strategy.rollingUpdate.maxUnavailable` | int | `1` | Update strategy |
| `strategy.rollingUpdate.maxSurge` | int | `1` | Update strategy |

### Service

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `service.enabled` | bool | `true` | Whether to create a Service |
| `service.type` | string | `"ClusterIP"` | Service type |
| `service.ports` | list | (see values.yaml) | Ports: web-http:8080, nginx-http:8081, bff-http:8082 |

### Expose (Ingress / Istio)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `expose.enabled` | bool | `false` | Enable external access |
| `expose.resourceType` | string | `"ingress"` | Resource type: `ingress` or `istio` |
| `expose.tls.certSource` | string | `"none"` | TLS source: `certmanager`, `secret`, `none` |
| `externalDomain` | string | `"127.0.0.1"` | External domain for Ingress/Istio |

### Container: bff

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `bff.enabled` | bool | `true` | Enable BFF container |
| `bff.image.repository` | string | `"prorobotech/openapi-ui-k8s-bff"` | Image repository |
| `bff.image.tag` | string | `"release-1.4.0-d4bbcaa2"` | Image tag |
| `bff.containerPort` | int | `8082` | Container port |
| `bff.resources` | object | (see values.yaml) | Requests: 100m CPU / 128Mi; Limits: 1 CPU / 1Gi |
| `bff.securityContext.enabled` | bool | `true` | Enable security context |
| `bff.livenessProbe.enabled` | bool | `true` | Enable liveness probe |
| `bff.readinessProbe.enabled` | bool | `false` | Enable readiness probe |

### Container: web

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `web.enabled` | bool | `true` | Enable web container |
| `web.image.repository` | string | `"prorobotech/openapi-ui"` | Image repository |
| `web.image.tag` | string | `"release-1.4.0-06f1ede4"` | Image tag |
| `web.containerPort` | int | `8080` | Container port |
| `web.resources` | object | (see values.yaml) | Requests: 100m CPU / 128Mi; Limits: 200m CPU / 256Mi |
| `web.securityContext.enabled` | bool | `true` | Enable security context |
| `web.livenessProbe.enabled` | bool | `true` | Enable liveness probe |

### Container: nginx

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `nginx.enabled` | bool | `true` | Enable nginx container |
| `nginx.image.repository` | string | `"nginxinc/nginx-unprivileged"` | Image repository |
| `nginx.image.tag` | string | `"1.29-alpine"` | Image tag |
| `nginx.containerPort` | int | `8081` | Container port |
| `nginx.resources` | object | (see values.yaml) | Requests: 50m CPU / 64Mi; Limits: 200m CPU / 256Mi |

### Container: moduleExample (plugin)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `moduleExample.enabled` | bool | `false` | Enable example plugin |
| `moduleExample.image.repository` | string | `"prorobotech/openapi-ui-plugin-example"` | Image repository |
| `moduleExample.image.tag` | string | `"master-a1a1bddb"` | Image tag |
| `moduleExample.containerPort` | int | `8083` | Container port |

### Container: moduleRbac (plugin)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `moduleRbac.enabled` | bool | `true` | Enable RBAC plugin |
| `moduleRbac.image.repository` | string | `"prorobotech/openapi-ui-plugin-rbac"` | Image repository |
| `moduleRbac.image.tag` | string | `"master-9bbda9e2"` | Image tag |
| `moduleRbac.containerPort` | int | `8084` | Container port |

### Container: moduleSgroups (plugin)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `moduleSgroups.enabled` | bool | `true` | Enable security groups plugin |
| `moduleSgroups.image.repository` | string | `"prorobotech/sgroups-ui"` | Image repository |
| `moduleSgroups.image.tag` | string | `"main-ab1de19d"` | Image tag |
| `moduleSgroups.containerPort` | int | `8085` | Container port |

### Clusters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `clusters` | list | (see below) | List of Kubernetes clusters for the UI |

```yaml
clusters:
  - name: default
    description: default
    tenant: dev
    scheme: http
    api: 127.0.0.1
```

### Navigation

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `navigation.name` | string | `"navigation"` | Navigation CR name |
| `navigation.baseFactoriesMappingEnabled` | bool | `true` | Enable factory mapping |
| `navigation.baseFactoriesMapping` | object | (see values.yaml) | Mapping base-factory → detail factories |
| `navigation.instances.enabled` | bool | `true` | Instances selector |
| `navigation.namespaces.enabled` | bool | `true` | Namespaces selector |
| `navigation.projects.enabled` | bool | `true` | Projects selector |

### Sidebars

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `sidebars.cluster` | object | (see values.yaml) | Cluster-level sidebar: Home, Workloads, Networking, Storage, Compute, User Management, Administration |
| `sidebars.namespaced` | object | (see values.yaml) | Namespace-level sidebar (similar structure) |
| `sidebars.cluster.customItems` | list | `[]` | Custom menu items for cluster sidebar |
| `sidebars.namespaced.customItems` | list | `[]` | Custom menu items for namespaced sidebar |
| `sidebars.keysAndTags` | object | (see values.yaml) | Mapping K8s resources to API endpoints |
| `sidebars.extrakeysAndTags` | object | `{}` | Additional resource mapping |

Each sidebar section (workloads, networking, storage, compute, usermanagement, administration) supports:
- `enabled: true/false` — enable/disable the section
- `items` — object with enabled/disabled resources (e.g. `pods: true`)
- `extraItems` — list of additional menu items

### Stock resource management

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `defaultWebResources.breadcrumbs.default.*` | bool | `true` | Enable/disable stock breadcrumbs |
| `defaultWebResources.customcolumnsoverride.*` | bool | `true` | Enable/disable stock CCO |
| `defaultWebResources.factory.default.*` | bool | `true` | Enable/disable stock factories |
| `customWebResources.customcolumnsoverride` | object | `{}` | Custom CCO overrides |
| `customWebResources.navigation` | object | `{}` | Custom navigation overrides |
| `customWebResources.factory` | object | (see values.yaml) | Custom factory overrides |

### Monitoring

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `monitoring.promqlUrl` | string | (see values.yaml) | PromQL API URL |
| `monitoring.grafanaDatasource` | string | (see values.yaml) | Grafana datasource ID |
| `monitoring.grafanaBaseUrl` | string | (see values.yaml) | Grafana base URL |
| `monitoring.grafanaDashboardPaths` | object | (see values.yaml) | Dashboard paths (podDetails, nodeDetails) |

### Authentication (oauth2-proxy)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `oauth2-proxy.enabled` | bool | `false` | Enable oauth2-proxy |
| `oauth2-proxy.config.clientID` | string | `"clientid"` | OAuth Client ID |
| `oauth2-proxy.config.clientSecret` | string | `"clientsecret"` | OAuth Client Secret |
| `oauth2-proxy.config.cookieSecret` | string | (see values.yaml) | Cookie encryption secret |

> **Note:** Default values for `clientID`, `clientSecret`, and `cookieSecret` are examples. In production, replace them with real secrets.

### Authentication (Dex)

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `dex.enabled` | bool | `false` | Enable Dex IdP |
| `dex.config.issuer` | string | (see values.yaml) | Issuer URL |
| `dex.config.staticClients` | list | (see values.yaml) | Static OIDC clients |
| `dex.config.staticPasswords` | list | (see values.yaml) | Static users (dev only) |

## CRD

The chart installs Custom Resource Definitions in the `front.in-cloud.io/v1alpha1` group:

| CRD | Description |
|-----|-------------|
| `breadcrumbs` | Navigation breadcrumbs |
| `breadcrumbsinsides` | Nested breadcrumbs |
| `cfomappings` | Custom form mapping |
| `clusters` | Cluster configuration |
| `customcolumnsoverrides` | Table column customization |
| `customformsoverrides` | Form customization |
| `customformsprefills` | Form prefills |
| `factories` | Resource factories (UI templates for create/view) |
| `marketplacepanels` | Marketplace panels |
| `navigations` | Navigation menus |
| `sidebars` | Sidebars |
| `tableurimappings` | Table URI mapping |

## RBAC

The chart creates the following ClusterRoles (when `rbac.create: true`):

| Role | Label aggregation | Description |
|------|-------------------|-------------|
| `front-in-cloud-admin` | `aggregate-to-admin: "true"` | Full access to `front.in-cloud.io` resources |
| `front-in-cloud-edit` | `aggregate-to-edit: "true"` | Read/write `front.in-cloud.io` resources |
| `front-in-cloud-view` | `aggregate-to-view: "true"` | Read `front.in-cloud.io` resources |

A `ClusterRoleBinding` is also created, binding `front-in-cloud-view` to `system:authenticated`.

## Project structure

```
in-cloud-web-chart/
├── Chart.yaml                          # Chart metadata v1.4.0 and dependencies
├── values.yaml                         # Default configuration (~1186 lines)
├── LICENSE                             # MIT
├── .helmignore                         # Packaging exclusions
├── charts/                             # Dependency archives
│   ├── dex-0.23.1.tgz
│   └── oauth2-proxy-7.18.0.tgz
├── .github/workflows/
│   └── helm-release.yaml               # CI: lint, package, push to OCI registry
├── crds/                               # 12 Custom Resource Definitions
│   ├── breadcrumbs.front.in-cloud.io.yaml
│   ├── clusters.front.in-cloud.io.yaml
│   ├── cfomappings.front.in-cloud.io.yaml
│   ├── factories.front.in-cloud.io.yaml
│   ├── navigations.front.in-cloud.io.yaml
│   ├── sidebars.front.in-cloud.io.yaml
│   └── ...
├── docs/
│   └── PROJECT.md                      # Project documentation
└── templates/
    ├── NOTES.txt                       # Post-install message
    ├── _helpers.tpl                    # Helper templates
    ├── deployment.yaml                 # Deployment (bff + web + nginx + optional plugin containers)
    ├── configmap.yaml                  # nginx configuration
    ├── service.yaml                    # Service
    ├── serviceaccount.yaml             # ServiceAccount
    ├── poddisruptionbudget.yaml        # PodDisruptionBudget
    ├── expose.yaml                     # Ingress / Istio Gateway + VirtualService
    ├── certificate-expose.yaml         # TLS certificate for external access
    ├── certificate-internal.yaml       # TLS certificate for internal components
    ├── extra-manifests.yaml            # Extra objects from extraObjects
    ├── clusters/
    │   └── infra.yaml                  # Cluster CR
    ├── rbac/                           # ClusterRole and ClusterRoleBinding
    ├── navigations/                    # Navigation and Fallback Navigation CR
    ├── sidebars/                       # Sidebar CR (cluster + namespaced) and .tpl helpers
    ├── breadcrumbs/fallback/           # Fallback templates (factory, form, search, table)
    ├── factory/
    │   ├── _helpers/                   # ~40 .tpl helpers for factories
    │   ├── base/                       # Base factories (5 templates)
    │   └── default/                    # Resource detail factories (~20 templates)
    ├── customcolumnsoverride/
    │   ├── _helpers/                   # ~10 .tpl helpers for CCO
    │   ├── default/                    # Stock CCO (~30 templates)
    │   └── factory/                    # Factory CCO (~20 templates)
    ├── customformoverride/             # Form customization
    └── customformprefill/              # Form prefills
```

## CI/CD

GitHub Actions workflow (`.github/workflows/helm-release.yaml`):

| Event | Behavior |
|-------|----------|
| Push to `release/*` | Chart version: `<release-name>-<short-sha>` |
| Push to `feature/*` | Chart version: `0.0.0-feature-<name>-<short-sha>` |
| Push to `hotfix/*` | Same as feature |
| Push tag `v*.*.*` | Version from Chart.yaml |

Pipeline steps:
1. Checkout
2. Compute version from branch name (yq rewrites `Chart.yaml`)
3. `helm lint`
4. `helm package` + `helm push` to `oci://registry-1.docker.io/prorobotech`

## License

[MIT](LICENSE) — PRO Robotech, 2026.

## Links

- [OpenAPI UI](https://github.com/PRO-Robotech/openapi-ui)
- [OpenAPI UI K8s BFF](https://github.com/PRO-Robotech/openapi-ui-k8s-bff)
- [in-Cloud Web Chart](https://github.com/PRO-Robotech/incloud-web-chart)
- [Documentation](https://in-cloud.io/docs/tech-docs/introduction/)
- [Telegram](https://t.me/in_cloud_en)
