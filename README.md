# in-Cloud Web Chart

Helm chart для развёртывания **in-Cloud Web UI** в Kubernetes.

## Обзор

Chart разворачивает до четырёх контейнеров в одном Pod:

| Контейнер | Назначение | Порт по умолчанию |
|-----------|------------|-------------------|
| **web** | Frontend UI (OpenAPI UI) | 8080 |
| **nginx** | Обратный прокси, маршрутизация запросов к кластерам | 8081 |
| **bff** | Backend-for-Frontend — прокси к Kubernetes API | 8082 |
| **moduleExample** | Пример плагина (опционально, отключён по умолчанию) | 8083 |

Опционально подключаются **oauth2-proxy** и **Dex** для аутентификации через OIDC.

Chart устанавливает **CRD** группы `front.in-cloud.io/v1alpha1` для кастомизации UI — навигация, фабрики, боковые панели, кастомные колонки/формы и др.

## Архитектура

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

### Маршрутизация nginx

| Путь | Назначение |
|------|------------|
| `/clusterlist`, `/api/clusters` | JSON-список кластеров |
| `/api/clusters/<name>/*` | Проксирование к API указанного кластера |
| `/k8s/*` | Проксирование к `kubernetes.default.svc:443` (WebSocket) |
| `/openapi-bff/*` | Проксирование к BFF-контейнеру |
| `/openapi-bff-ws/*` | WebSocket-проксирование к BFF |
| `/openapi-ui/*` | Проксирование к Web-контейнеру (SPA) |
| `/openapi-ui-plugin/*` | Проксирование к плагину (если включён) |
| `/dex/*` | Проксирование к Dex (если включён) |
| `/oauth2/*` | Проксирование к oauth2-proxy (если включён) |
| `/healthcheck` | Health-check endpoint |

## Требования

- Kubernetes `>= 1.22`
- Helm `>= 3.8`
- (Опционально) доступ к приватному container registry через `imagePullSecrets`

## Быстрый старт

### Установка из OCI-реестра

```bash
helm upgrade --install incloud-web oci://registry-1.docker.io/prorobotech/incloud-web-chart --version 0.0.0-feature-CLOUD-484-440fb5a \
  --namespace incloud --create-namespace
```

### Установка из локальной директории

```bash
helm dependency update .
helm install incloud-web . --namespace incloud --create-namespace
```

### Рендер манифестов без установки

```bash
helm template incloud-web . --namespace incloud
```

### Обновление релиза

```bash
helm upgrade incloud-web . --namespace incloud
```

### С включённой аутентификацией (oauth2-proxy + Dex)

```bash
helm install incloud-web . \
  --namespace incloud --create-namespace \
  --set oauth2-proxy.enabled=true \
  --set dex.enabled=true
```

## Зависимости

| Chart | Версия | Репозиторий | Условие |
|-------|--------|-------------|---------|
| oauth2-proxy | 7.18.0 | https://oauth2-proxy.github.io/manifests | `oauth2-proxy.enabled` |
| dex | 0.23.1 | https://charts.dexidp.io | `dex.enabled` |

Архивы зависимостей включены в `charts/`. При необходимости обновить:

```bash
helm dependency update .
```

## Конфигурация

Полная конфигурация задаётся через `values.yaml` (~1186 строк). Ниже приведены основные параметры.

### Глобальные параметры

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `nameOverride` | string | `""` | Переопределение имени chart |
| `fullnameOverride` | string | `""` | Переопределение полного имени релиза |
| `replicaCount` | int | `1` | Количество реплик Pod |
| `imagePullSecrets` | list | `[]` | Секреты для доступа к приватным registry |
| `priorityClassName` | string | `"system-cluster-critical"` | Priority class для Pod |
| `basePrefix` | string | `"openapi-ui"` | Базовый URL-префикс приложения |

### ServiceAccount

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `serviceAccount.create` | bool | `true` | Создавать ли ServiceAccount |
| `serviceAccount.name` | string | `""` | Имя ServiceAccount (по умолчанию: `<release>-<chart>`) |
| `serviceAccount.annotations` | object | `{}` | Аннотации ServiceAccount |

### Pod

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `podAnnotations` | object | `{}` | Аннотации Pod |
| `podLabels` | object | `{}` | Дополнительные лейблы Pod |
| `podSecurityContext.enabled` | bool | `true` | Включить pod-level security context |
| `podSecurityContext.fsGroup` | int | `101` | Group ID для монтируемых томов |
| `nodeSelector` | object | `{}` | Селектор узлов |
| `tolerations` | list | `[]` | Tolerations для Pod |
| `topologySpreadConstraints` | list | `[]` | Ограничения распределения по топологии |
| `podDisruptionBudget.minAvailable` | int | `1` | Минимум доступных Pod (PDB) |
| `strategy.rollingUpdate.maxUnavailable` | int | `1` | Стратегия обновления |
| `strategy.rollingUpdate.maxSurge` | int | `1` | Стратегия обновления |

### Service

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `service.enabled` | bool | `true` | Создавать ли Service |
| `service.type` | string | `"ClusterIP"` | Тип Service |
| `service.ports` | list | (см. values.yaml) | Порты: web-http:8080, nginx-http:8081, bff-http:8082 |

### Expose (Ingress / Istio)

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `expose.enabled` | bool | `false` | Включить внешний доступ |
| `expose.resourceType` | string | `"ingress"` | Тип ресурса: `ingress` или `istio` |
| `expose.tls.certSource` | string | `"none"` | Источник TLS: `certmanager`, `secret`, `none` |
| `externalDomain` | string | `"127.0.0.1"` | Внешний домен для Ingress/Istio |

### Контейнер: bff

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `bff.enabled` | bool | `true` | Включить BFF-контейнер |
| `bff.image.repository` | string | `"prorobotech/openapi-ui-k8s-bff"` | Репозиторий образа |
| `bff.image.tag` | string | `"release-1.4.0-d4bbcaa2"` | Тег образа |
| `bff.containerPort` | int | `8082` | Порт контейнера |
| `bff.resources` | object | (см. values.yaml) | Requests: 100m CPU / 128Mi; Limits: 1 CPU / 1Gi |
| `bff.securityContext.enabled` | bool | `true` | Включить security context |
| `bff.livenessProbe.enabled` | bool | `true` | Включить liveness probe |
| `bff.readinessProbe.enabled` | bool | `false` | Включить readiness probe |

### Контейнер: web

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `web.enabled` | bool | `true` | Включить web-контейнер |
| `web.image.repository` | string | `"prorobotech/openapi-ui"` | Репозиторий образа |
| `web.image.tag` | string | `"release-1.4.0-06f1ede4"` | Тег образа |
| `web.containerPort` | int | `8080` | Порт контейнера |
| `web.resources` | object | (см. values.yaml) | Requests: 100m CPU / 128Mi; Limits: 200m CPU / 256Mi |
| `web.securityContext.enabled` | bool | `true` | Включить security context |
| `web.livenessProbe.enabled` | bool | `true` | Включить liveness probe |

### Контейнер: nginx

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `nginx.enabled` | bool | `true` | Включить nginx-контейнер |
| `nginx.image.repository` | string | `"nginxinc/nginx-unprivileged"` | Репозиторий образа |
| `nginx.image.tag` | string | `"1.29-alpine"` | Тег образа |
| `nginx.containerPort` | int | `8081` | Порт контейнера |
| `nginx.resources` | object | (см. values.yaml) | Requests: 50m CPU / 64Mi; Limits: 200m CPU / 256Mi |

### Контейнер: moduleExample (плагин)

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `moduleExample.enabled` | bool | `false` | Включить пример плагина |
| `moduleExample.image.repository` | string | `"prorobotech/openapi-ui-plugin-example"` | Репозиторий образа |
| `moduleExample.image.tag` | string | `"master-a1a1bddb"` | Тег образа |
| `moduleExample.containerPort` | int | `8083` | Порт контейнера |

### Кластеры

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `clusters` | list | (см. ниже) | Список Kubernetes-кластеров для UI |

```yaml
clusters:
  - name: default
    description: default
    tenant: dev
    scheme: http
    api: 127.0.0.1
```

### Навигация

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `navigation.name` | string | `"navigation"` | Имя Navigation CR |
| `navigation.baseFactoriesMappingEnabled` | bool | `true` | Включить маппинг фабрик |
| `navigation.baseFactoriesMapping` | object | (см. values.yaml) | Маппинг base-factory → детальные фабрики |
| `navigation.instances.enabled` | bool | `true` | Селектор instances |
| `navigation.namespaces.enabled` | bool | `true` | Селектор namespaces |
| `navigation.projects.enabled` | bool | `true` | Селектор projects |

### Боковые панели (Sidebars)

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `sidebars.cluster` | object | (см. values.yaml) | Cluster-level sidebar: Home, Workloads, Networking, Storage, Compute, User Management, Administration |
| `sidebars.namespaced` | object | (см. values.yaml) | Namespace-level sidebar (аналогичная структура) |
| `sidebars.cluster.customItems` | list | `[]` | Кастомные пункты меню для cluster sidebar |
| `sidebars.namespaced.customItems` | list | `[]` | Кастомные пункты меню для namespaced sidebar |
| `sidebars.keysAndTags` | object | (см. values.yaml) | Маппинг ресурсов K8s на API endpoints |
| `sidebars.extrakeysAndTags` | object | `{}` | Дополнительный маппинг ресурсов |

Каждая секция sidebar (workloads, networking, storage, compute, usermanagement, administration) поддерживает:
- `enabled: true/false` — включение/отключение секции
- `items` — объект с включённым/отключённым ресурсом (напр. `pods: true`)
- `extraItems` — список дополнительных пунктов меню

### Управление стоковыми ресурсами

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `defaultWebResources.breadcrumbs.default.*` | bool | `true` | Включение/отключение стоковых breadcrumbs |
| `defaultWebResources.customcolumnsoverride.*` | bool | `true` | Включение/отключение стоковых CCO |
| `defaultWebResources.factory.default.*` | bool | `true` | Включение/отключение стоковых фабрик |
| `customWebResources.customcolumnsoverride` | object | `{}` | Переопределения кастомных CCO |
| `customWebResources.navigation` | object | `{}` | Переопределения кастомной навигации |
| `customWebResources.factory` | object | (см. values.yaml) | Переопределения кастомных фабрик |

### Мониторинг

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `monitoring.promqlUrl` | string | (см. values.yaml) | URL PromQL API |
| `monitoring.grafanaDatasource` | string | (см. values.yaml) | ID datasource в Grafana |
| `monitoring.grafanaBaseUrl` | string | (см. values.yaml) | Базовый URL Grafana |
| `monitoring.grafanaDashboardPaths` | object | (см. values.yaml) | Пути к дашбордам (podDetails, nodeDetails) |

### Аутентификация (oauth2-proxy)

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `oauth2-proxy.enabled` | bool | `false` | Включить oauth2-proxy |
| `oauth2-proxy.config.clientID` | string | `"clientid"` | OAuth Client ID |
| `oauth2-proxy.config.clientSecret` | string | `"clientsecret"` | OAuth Client Secret |
| `oauth2-proxy.config.cookieSecret` | string | (см. values.yaml) | Секрет шифрования cookie |

> **Внимание:** Значения `clientID`, `clientSecret` и `cookieSecret` по умолчанию являются примерами. В production-среде обязательно замените их на реальные секреты.

### Аутентификация (Dex)

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `dex.enabled` | bool | `false` | Включить Dex IdP |
| `dex.config.issuer` | string | (см. values.yaml) | URL издателя |
| `dex.config.staticClients` | list | (см. values.yaml) | Статические клиенты OIDC |
| `dex.config.staticPasswords` | list | (см. values.yaml) | Статические пользователи (только для dev) |

## CRD

Chart устанавливает Custom Resource Definitions группы `front.in-cloud.io/v1alpha1`:

| CRD | Описание |
|-----|----------|
| `breadcrumbs` | Хлебные крошки навигации |
| `breadcrumbsinsides` | Вложенные хлебные крошки |
| `cfomappings` | Маппинг кастомных форм |
| `clusters` | Конфигурация кластеров |
| `customcolumnsoverrides` | Кастомизация колонок таблиц |
| `customformsoverrides` | Кастомизация форм |
| `customformsprefills` | Предзаполнение форм |
| `factories` | Фабрики ресурсов (шаблоны UI для создания/просмотра) |
| `marketplacepanels` | Панели маркетплейса |
| `navigations` | Навигационные меню |
| `sidebars` | Боковые панели |
| `tableurimappings` | Маппинг URI таблиц |

## RBAC

Chart создаёт следующие ClusterRole (при `rbac.create: true`):

| Role | Label aggregation | Описание |
|------|-------------------|----------|
| `front-in-cloud-admin` | `aggregate-to-admin: "true"` | Полный доступ к ресурсам `front.in-cloud.io` |
| `front-in-cloud-edit` | `aggregate-to-edit: "true"` | Чтение и запись ресурсов `front.in-cloud.io` |
| `front-in-cloud-view` | `aggregate-to-view: "true"` | Чтение ресурсов `front.in-cloud.io` |

Также создаётся `ClusterRoleBinding`, привязывающий `front-in-cloud-view` к `system:authenticated`.

## Структура проекта

```
in-cloud-web-chart/
├── Chart.yaml                          # Метаданные chart v1.4.0 и зависимости
├── values.yaml                         # Конфигурация по умолчанию (~1186 строк)
├── LICENSE                             # MIT
├── .helmignore                         # Исключения при упаковке
├── charts/                             # Архивы зависимостей
│   ├── dex-0.23.1.tgz
│   └── oauth2-proxy-7.18.0.tgz
├── .github/workflows/
│   └── helm-release.yaml               # CI: lint, package, push в OCI registry
├── crds/                               # 12 Custom Resource Definitions
│   ├── breadcrumbs.front.in-cloud.io.yaml
│   ├── clusters.front.in-cloud.io.yaml
│   ├── cfomappings.front.in-cloud.io.yaml
│   ├── factories.front.in-cloud.io.yaml
│   ├── navigations.front.in-cloud.io.yaml
│   ├── sidebars.front.in-cloud.io.yaml
│   └── ...
├── docs/
│   └── PROJECT.md                      # Документация проекта
└── templates/
    ├── NOTES.txt                       # Сообщение после helm install
    ├── _helpers.tpl                    # Вспомогательные шаблоны
    ├── deployment.yaml                 # Deployment (bff + web + nginx + moduleExample)
    ├── configmap.yaml                  # Конфигурация nginx
    ├── service.yaml                    # Service
    ├── serviceaccount.yaml             # ServiceAccount
    ├── poddisruptionbudget.yaml        # PodDisruptionBudget
    ├── expose.yaml                     # Ingress / Istio Gateway + VirtualService
    ├── certificate-expose.yaml         # TLS-сертификат для внешнего доступа
    ├── certificate-internal.yaml       # TLS-сертификат для внутренних компонентов
    ├── extra-manifests.yaml            # Дополнительные объекты из extraObjects
    ├── clusters/
    │   └── infra.yaml                  # Cluster CR
    ├── rbac/                           # ClusterRole и ClusterRoleBinding
    ├── navigations/                    # Navigation и Fallback Navigation CR
    ├── sidebars/                       # Sidebar CR (cluster + namespaced) и .tpl хелперы
    ├── breadcrumbs/fallback/           # Fallback-шаблоны (factory, form, search, table)
    ├── factory/
    │   ├── _helpers/                   # ~40 .tpl хелперов для фабрик
    │   ├── base/                       # Базовые фабрики (5 шаблонов)
    │   └── default/                    # Детальные фабрики ресурсов (~20 шаблонов)
    ├── customcolumnsoverride/
    │   ├── _helpers/                   # ~10 .tpl хелперов для CCO
    │   ├── default/                    # Стоковые CCO (~30 шаблонов)
    │   └── factory/                    # CCO для фабрик (~20 шаблонов)
    ├── customformoverride/             # Кастомизация форм
    └── customformprefill/              # Предзаполнение форм
```

## CI/CD

GitHub Actions workflow (`.github/workflows/helm-release.yaml`):

| Событие | Поведение |
|---------|-----------|
| Push в `release/*` | Версия chart: `<release-name>-<short-sha>` |
| Push в `feature/*` | Версия chart: `0.0.0-feature-<name>-<short-sha>` |
| Push в `hotfix/*` | Аналогично feature |
| Push тега `v*.*.*` | Версия из Chart.yaml |

Шаги pipeline:
1. Checkout
2. Вычисление версии из имени ветки (yq перезаписывает `Chart.yaml`)
3. `helm lint`
4. `helm package` + `helm push` в `oci://registry-1.docker.io/prorobotech`

## Лицензия

[MIT](LICENSE) — PRO Robotech, 2026.

## Ссылки

- [OpenAPI UI](https://github.com/PRO-Robotech/openapi-ui)
- [OpenAPI UI K8s BFF](https://github.com/PRO-Robotech/openapi-ui-k8s-bff)
- [in-Cloud Web Chart](https://github.com/PRO-Robotech/incloud-web-chart)
- [Документация](https://in-cloud.io/docs/tech-docs/introduction/)
- [Telegram](https://t.me/in_cloud_en)
