# InCloud Web — документация Helm-чарта

## Назначение

Репозиторий содержит Helm chart **incloud-web-chart** для развёртывания веб-интерфейса InCloud в Kubernetes: три контейнера в одном Pod — **nginx** (точка входа и reverse proxy), **web** (SPA/UI), **bff** (backend-for-frontend к API кластера и CRD `front.in-cloud.io`).

Версия chart: см. `Chart.yaml` (`version`). Версия приложения: `appVersion` и теги образов в `values.yaml`.

## Требования

| Компонент | Версия |
|-----------|--------|
| Kubernetes | ≥ 1.22 (`kubeVersion` в `Chart.yaml`) |
| Helm | ≥ 3.8 |

Опционально: секреты для приватного registry (`imagePullSecrets`), Cert-Manager для TLS (`expose.tls`, `internalTLS`), Istio или Ingress-контроллер для внешнего доступа.

## Архитектура

### Поток трафика

1. Внешний клиент → Service (порты 8080 web, 8081 nginx, 8082 bff) или Ingress/Istio при `expose.enabled`.
2. **nginx** слушает основной внешний порт приложения (по умолчанию 8081 в Pod, маппинг в Service — см. `service.ports`).
3. Маршрутизация задаётся в `templates/configmap.yaml` (данные ConfigMap `*-nginx-config`):
   - `/clusterlist`, `/api/clusters` — JSON со списком кластеров из `values.clusters`;
   - `/api/clusters/<name>` — прокси к API выбранного кластера;
   - `/k8s` — прокси к `https://kubernetes.default.svc:443` (с опциональной проверкой через oauth2-proxy);
   - `/openapi-bff`, `/openapi-bff-ws/` — BFF;
   - `BASEPREFIX` (по умолчанию `/openapi-ui`) — статика и UI через контейнер **web**.

### Зависимости Helm (опционально)

В `Chart.yaml` объявлены сабчарты:

- **oauth2-proxy** — аутентификация перед UI и BFF (`condition: oauth2-proxy.enabled`);
- **dex** — OIDC-провайдер (`condition: dex.enabled`).

Перед установкой с включёнными зависимостями выполните:

```bash
helm dependency build
```

### CRD

Каталог `crds/` содержит манифесты CustomResourceDefinition для домена `front.in-cloud.io` (навигация, фабрики, breadcrumbs, marketplace, переопределения колонок/форм и т.д.). Установка CRD при `helm install` зависит от политики Helm (`--skip-crds` при необходимости).

### RBAC

Шаблоны в `templates/rbac/` задают ClusterRole с агрегацией к стандартным ролям и правами на API-группу `front.in-cloud.io`. Детали — в файлах `admin.yaml`, `edit.yaml`, `view.yaml`, `crb.yaml`.

### Дополнительные объекты

`values.extraObjects` — список произвольных YAML-объектов с подстановкой через `tpl` (`templates/extra-manifests.yaml`).

## Установка

### Локальный chart

```bash
helm dependency build   # если нужны oauth2-proxy / dex
helm install incloud-web . -n <namespace> -f my-values.yaml
```

### Проверка без установки

```bash
helm template incloud-web . -n default --set oauth2-proxy.enabled=false --set dex.enabled=false
```

### Образы

По умолчанию в `values.yaml`: `prorobotech/openapi-ui`, `prorobotech/openapi-ui-k8s-bff`, `nginxinc/nginx-unprivileged`. Теги и registry нужно согласовать с политикой окружения.

## Ключевые параметры конфигурации

| Область | Параметры |
|---------|-----------|
| Реплики и планирование | `replicaCount`, `nodeSelector`, `tolerations`, `affinity`, `topologySpreadConstraints`, `priorityClassName` |
| Сервис | `service.*` — порты и тип |
| Внешний доступ | `expose.*` — Ingress или Istio, TLS |
| Кластеры для UI | `clusters` — список имён и endpoints API |
| Внешний URL | `externalDomain`, `externalDomainPort` — редирект с `/` и схемы в nginx |
| Контейнеры | `bff`, `web`, `nginx` — образы, `env`, ресурсы, пробы |
| TLS между компонентами | `internalTLS` — cert-manager, секреты или отключено |

Подробная таблица значений — в корневом `README.md` (при расхождении с `values.yaml` ориентируйтесь на актуальный `values.yaml`).

## CI/CD

Workflow `.github/workflows/helm-release.yaml`: при push в ветки и теги вида `v*.*.*` выполняется `helm package` и публикация OCI-артефакта в `registry-1.docker.io` (организация `prorobotech`).

## Безопасность (рекомендации эксплуатации)

- В `values.yaml` для oauth2-proxy/dex по умолчанию заданы **учебные** секреты и пароли — заменить перед продакшеном.
- Для продакшена включить `cookie-secure`, отключить `ssl-insecure-skip-verify` у oauth2-proxy, настроить HTTPS и корректные `redirect-url` / `issuer`.
- Readiness-пробы у контейнеров по умолчанию **выключены** — для корректной работы балансировки имеет смысл включить там, где endpoint `/ready` реализован.

---

*Документ сгенерирован по состоянию репозитория; при изменении chart сверяйте с `Chart.yaml` и `values.yaml`.*
