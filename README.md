# incloud-web-chart

Helm chart для разворачивания InCloud Web UI в Kubernetes.

## Что делает чарт

Чарт разворачивает UI-стек из нескольких контейнеров в одном `Deployment`:

- `web` - фронтенд (`prorobotech/openapi-ui`)
- `bff` - backend-for-frontend (`prorobotech/openapi-ui-k8s-bff`)
- `nginx` - reverse proxy (`nginxinc/nginx-unprivileged`)
- опционально `moduleExample` - пример плагина
- опционально сабчарты: `oauth2-proxy` и `dex`

Также чарт ставит:

- `ServiceAccount`, `Service`, `PodDisruptionBudget`, `ConfigMap`
- `Ingress` или `Istio Gateway/VirtualService` (если включен `expose.enabled`)
- `Certificate`/`Issuer` (если выбраны `certmanager`-режимы TLS)
- набор CR-ресурсов `front.in-cloud.io/*` (Navigation, Sidebar, Breadcrumb, Factory, CustomFormsOverride, CustomColumnsOverride, CFOMapping)
- агрегированные ClusterRole для `front.in-cloud.io` + `ClusterRoleBinding` на `system:authenticated`

## Требования

- Kubernetes: `>= 1.22`
- Helm: `>= 3.8`

## Быстрый старт

1. Подтянуть зависимости:

```bash
helm dependency update .
```

2. Проверить рендер:

```bash
helm lint .
helm template incloud-web . --namespace incloud --create-namespace > rendered.yaml
```

3. Установить:

```bash
helm install incloud-web . --namespace incloud --create-namespace
```

4. Обновить релиз:

```bash
helm upgrade incloud-web . --namespace incloud
```

## Схема трафика

По умолчанию `nginx` слушает `8081` и проксирует:

- `/<basePrefix>` -> `web:8080`
- `/openapi-bff` и `/openapi-bff-ws` -> `bff:8082` (только если `bff.enabled=true`)
- `/k8s` -> `https://kubernetes.default.svc:443`
- `/oauth2/*` -> `oauth2-proxy` (если включен)
- `/dex` -> `dex` (если включены `dex` и `oauth2-proxy`)

`Service` по умолчанию публикует порты `8080`, `8081`, `8082`.

## Базовый префикс UI

Чарт использует общий префикс маршрутов (`/openapi-ui` по умолчанию).

Приоритет источника префикса:

1. `web.env.BASEPREFIX`
2. `basePrefix`

Рекомендуется задавать **только один** источник (обычно `web.env.BASEPREFIX`) и держать его консистентным во всех интеграциях.

## Режимы аутентификации

### Без встроенной аутентификации

Оставьте:

- `oauth2-proxy.enabled=false`
- `dex.enabled=false`

### OAuth2 Proxy + Dex

Включите:

- `oauth2-proxy.enabled=true`
- `dex.enabled=true`

И обязательно переопределите:

- `oauth2-proxy.config.clientID`
- `oauth2-proxy.config.clientSecret`
- `oauth2-proxy.config.cookieSecret`
- `oauth2-proxy.extraArgs.redirect-url`
- `oauth2-proxy.extraArgs.oidc-issuer-url`

## Публикация наружу (`expose`)

`expose.enabled=true` включает внешний ресурс.

- `expose.resourceType=ingress` -> создается `Ingress`
- `expose.resourceType=istio` -> создаются `Gateway` + `VirtualService`

Ключевые параметры:

- `externalDomain`
- `expose.path` (должен оканчиваться на `/`)
- `expose.servicePort` (порт backend-сервиса, обычно `80` при проксировании через oauth2-proxy)

## TLS

### Внешний TLS (`expose.tls.certSource`)

- `none` - без TLS-секрета
- `secret` - существующий secret (`expose.tls.secret.secretName`)
- `certmanager` - сертификат через cert-manager

### Внутренний TLS (`internalTLS.certSource`)

Используется для связки `nginx <-> dex/oauth2-proxy`:

- `none`
- `secret` (секреты для `dex` и `oauth2-proxy`)
- `certmanager`

## Кастомизация UI-ресурсов

Чарт поставляет fallback-навигацию/сайдбары/breadcrumbs/factory-ресурсы.

Управление дефолтными наборами:

- `defaultWebResources.factory.default.*`
- `defaultWebResources.customcolumnsoverride.*`
- `defaultWebResources.breadcrumbs.default.*`

Примеры ключей breadcrumbs:

- `fallback-factory-clusterscoped`
- `fallback-factory-namespaced`
- `fallback-form-clusterscoped`
- `fallback-form-namespaced`
- `fallback-search`
- `fallback-table-clusterscoped`
- `fallback-table-namespaced`

Для дополнительной кастомизации:

- `sidebars.cluster.*` и `sidebars.namespaced.*`
- `sidebars.extrakeysAndTags`
- `extraObjects` (дополнительные манифесты через `tpl`)

## Важные значения `values.yaml`

| Параметр | По умолчанию | Назначение |
|---|---|---|
| `replicaCount` | `1` | Количество pod'ов |
| `service.type` | `ClusterIP` | Тип сервиса |
| `service.ports` | `8080/8081/8082` | Порты web/nginx/bff |
| `web.enabled` | `true` | Включение frontend контейнера |
| `bff.enabled` | `true` | Включение BFF контейнера |
| `nginx.enabled` | `true` | Включение nginx контейнера |
| `moduleExample.enabled` | `false` | Включение примерного плагина |
| `oauth2-proxy.enabled` | `false` | Включение oauth2-proxy сабчарта |
| `dex.enabled` | `false` | Включение dex сабчарта |
| `expose.enabled` | `false` | Внешняя публикация |
| `expose.resourceType` | `ingress` | Тип внешней публикации |
| `expose.tls.certSource` | `none` | Внешний TLS |
| `internalTLS.certSource` | `none` | Внутренний TLS между компонентами |
| `web.env.BASEPREFIX` | `/openapi-ui` | Базовый URL префикс |
| `basePrefix` | `openapi-ui` | Резервный источник префикса |
| `clusters` | `[{name: default, ...}]` | Список целевых кластеров для UI |
| `defaultWebResources.*` | `true` | Включение стандартных UI-ресурсов |
| `extraObjects` | `[]` | Дополнительные произвольные ресурсы |

## Примеры конфигурации

### 1) Минимальная установка без auth/expose

```yaml
oauth2-proxy:
  enabled: false
dex:
  enabled: false
expose:
  enabled: false
```

### 2) Ingress + TLS из существующего секрета

```yaml
externalDomain: ui.example.com

expose:
  enabled: true
  resourceType: ingress
  path: /
  servicePort: 80
  ingress:
    ingressClassName: nginx
  tls:
    certSource: secret
    secret:
      secretName: ui-example-com-tls
```

### 3) Отключить часть fallback breadcrumbs

```yaml
defaultWebResources:
  breadcrumbs:
    default:
      fallback-search: false
      fallback-table-namespaced: false
```

### 4) Изменить базовый префикс UI

```yaml
web:
  env:
    BASEPREFIX: /ui
basePrefix: ui
```

## Безопасность и прод-замечания

- Дефолтные значения `oauth2-proxy`/`dex` в `values.yaml` подходят для демо, не для production.
- Перед production обязательно замените demo-секреты и пароли.
- Проверьте `oauth2-proxy.extraArgs.cookie-secure` (должно быть `true` за HTTPS).
- Проверьте необходимость `ClusterRoleBinding` `front-in-cloud-view-authenticated` для вашей модели доступа.
- Helm не обновляет CRD автоматически при `upgrade`; обновление CRD делайте отдельно при смене схемы.

## Отладка

```bash
# Рендер с конкретным values
helm template incloud-web . -f values.yaml

# Проверка только проблемных секций
helm template incloud-web . --set bff.enabled=false
helm template incloud-web . --set defaultWebResources.breadcrumbs.default.fallback-search=false
helm template incloud-web . --set web.env.BASEPREFIX=/ui
```

