{{- define "in-cloud.web.contentCard.events" -}}
- type: ContentCard
  data:
    id: details-card
    style:
      marginBottom: 24px
  children:
    - type: Events
      data:
        id: events

        # =========================
        # Base configuration
        # =========================

        # Base UI prefix for resource links
        baseprefix: "/openapi-ui"

        # Target cluster identifier
        cluster: "{2}"

        # WebSocket endpoint for live events stream
        wsUrl: "/api/clusters/{2}/openapi-bff-ws/events/eventsWs"

        # Pagination and layout tuning
        pageSize: 50
        limit: 40
        substractHeight: 315

        # =========================
        # Field selector: bind events to current resource
        # =========================
        fieldSelector:
        {{- if .fieldSelector }}
        {{ toYaml .fieldSelector | nindent 10 }}
        {{- else }}
          regarding.kind: "{reqsJsonPath[0]['.items.0.kind']['-']}"
          regarding.name: "{reqsJsonPath[0]['.items.0.metadata.name']['-']}"
          regarding.namespace: "{reqsJsonPath[0]['.items.0.metadata.namespace']['-']}"
          regarding.apiVersion: "{reqsJsonPath[0]['.items.0.apiVersion']['-']}"
        {{- end }}
        # =========================
        # Factory routing keys
        # =========================
        # Used to navigate from Event objects to resource details pages
        baseFactoryNamespacedAPIKey: base-factory-namespaced-api
        baseFactoryClusterSceopedAPIKey: base-factory-clusterscoped-api
        baseFactoryNamespacedBuiltinKey: base-factory-namespaced-builtin
        baseFactoryClusterSceopedBuiltinKey: base-factory-clusterscoped-builtin
        baseNamespaceFactoryKey: namespace-details
        baseNavigationPlural: navigations
        baseNavigationName: navigation
{{- end -}}
