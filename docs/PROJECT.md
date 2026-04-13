# InCloud Web — Helm chart documentation

## Purpose

This repository contains the **incloud-web-chart** Helm chart for deploying the InCloud web interface to Kubernetes: three containers in one Pod — **nginx** (entry point and reverse proxy), **web** (SPA/UI), **bff** (backend-for-frontend to the cluster API and `front.in-cloud.io` CRDs).

Chart version: see `Chart.yaml` (`version`). Application version: `appVersion` and image tags in `values.yaml`.

## Requirements

| Component | Version |
|-----------|--------|
| Kubernetes | ≥ 1.22 (`kubeVersion` in `Chart.yaml`) |
| Helm | ≥ 3.8 |

Optional: secrets for a private registry (`imagePullSecrets`), Cert-Manager for TLS (`expose.tls`, `internalTLS`), Istio or an Ingress controller for external access.

## Architecture

### Traffic flow

1. External client → Service (ports 8080 web, 8081 nginx, 8082 bff) or Ingress/Istio when `expose.enabled`.
2. **nginx** listens on the main external application port (default 8081 in the Pod; Service mapping — see `service.ports`).
3. Routing is defined in `templates/configmap.yaml` (ConfigMap data `*-nginx-config`):
   - `/clusterlist`, `/api/clusters` — JSON with the cluster list from `values.clusters`;
   - `/api/clusters/<name>` — proxy to the selected cluster’s API;
   - `/k8s` — proxy to `https://kubernetes.default.svc:443` (with optional verification via oauth2-proxy);
   - `/openapi-bff`, `/openapi-bff-ws/` — BFF;
   - `BASEPREFIX` (default `/openapi-ui`) — static assets and UI via the **web** container.

### Helm dependencies (optional)

Subcharts are declared in `Chart.yaml`:

- **oauth2-proxy** — authentication in front of the UI and BFF (`condition: oauth2-proxy.enabled`);
- **dex** — OIDC provider (`condition: dex.enabled`).

Before installing with dependencies enabled, run:

```bash
helm dependency build
```

### CRDs

The `crds/` directory holds CustomResourceDefinition manifests for the `front.in-cloud.io` domain (navigation, factories, breadcrumbs, marketplace, column/form overrides, etc.). Whether CRDs are installed on `helm install` depends on Helm policy (`--skip-crds` when needed).

### RBAC

Templates under `templates/rbac/` define a ClusterRole with aggregation to standard roles and permissions on the `front.in-cloud.io` API group. Details are in `admin.yaml`, `edit.yaml`, `view.yaml`, `crb.yaml`.

### Extra objects

`values.extraObjects` — a list of arbitrary YAML objects rendered with `tpl` (`templates/extra-manifests.yaml`).

## Installation

### Local chart

```bash
helm dependency build   # if oauth2-proxy / dex are needed
helm install incloud-web . -n <namespace> -f my-values.yaml
```

### Dry run (no install)

```bash
helm template incloud-web . -n default --set oauth2-proxy.enabled=false --set dex.enabled=false
```

### Images

Defaults in `values.yaml`: `prorobotech/openapi-ui`, `prorobotech/openapi-ui-k8s-bff`, `nginxinc/nginx-unprivileged`. Tags and registry should align with your environment’s policy.

## Key configuration parameters

| Area | Parameters |
|---------|-----------|
| Replicas and scheduling | `replicaCount`, `nodeSelector`, `tolerations`, `affinity`, `topologySpreadConstraints`, `priorityClassName` |
| Service | `service.*` — ports and type |
| External access | `expose.*` — Ingress or Istio, TLS |
| Clusters for UI | `clusters` — names and API endpoints |
| External URL | `externalDomain`, `externalDomainPort` — redirect from `/` and schemes in nginx |
| Containers | `bff`, `web`, `nginx` — images, `env`, resources, probes |
| TLS between components | `internalTLS` — cert-manager, secrets, or disabled |

A detailed values table is in the root `README.md` (if it diverges from `values.yaml`, treat the current `values.yaml` as source of truth).

## CI/CD

Workflow `.github/workflows/helm-release.yaml`: on push to branches and tags matching `v*.*.*`, `helm package` runs and an OCI artifact is published to `registry-1.docker.io` (organization `prorobotech`).

## Security (operational recommendations)

- In `values.yaml`, oauth2-proxy/dex defaults use **sample** secrets and passwords — replace before production.
- For production, enable `cookie-secure`, disable `ssl-insecure-skip-verify` on oauth2-proxy, configure HTTPS and correct `redirect-url` / `issuer`.
- Readiness probes for containers are **off** by default — for correct load balancing, enable them where the `/ready` endpoint is implemented.

---

*This document reflects the state of the repository; when the chart changes, verify against `Chart.yaml` and `values.yaml`.*
