{{/*
  Factory detail URL resolution for CCO: mappingKey identifies a factory template; Navigation CR baseFactoriesMapping
  maps keys to factoryDetails names; resolveFromLegacy rewrites legacy hrefs; factoryDetails builds canonical paths.
*/}}
{{- define "in-cloud.web.cco.factory.mappingKey" -}}
{{- $scope := default "namespaced" .scope -}}
{{- $source := default "api" .source -}}
{{- $apiVersion := default "v1" .apiVersion -}}
{{- $plural := .plural -}}
{{- printf "base-factory-%s-%s-%s-%s" $scope $source (replace "/" "-" $apiVersion) $plural -}}
{{- end -}}

{{/*
  Resolves factoryDetails (detail page factory name) from
  .root.Values.navigation.baseFactoriesMapping[mappingKey].
*/}}
{{- define "in-cloud.web.cco.factory.detailsName" -}}
{{- $root := .root -}}
{{- $mappingKey := .mappingKey -}}
{{- if not $mappingKey -}}
{{- $mappingKey = (include "in-cloud.web.cco.factory.mappingKey" . | trim) -}}
{{- end -}}
{{- $navigation := default (dict) $root.Values.navigation -}}
{{- $mapping := default (dict) $navigation.baseFactoriesMapping -}}
{{- $detailsName := default .factoryName (index $mapping $mappingKey) -}}
{{- if not $detailsName -}}
{{- fail (printf "factory details name is not defined for key '%s'" $mappingKey) -}}
{{- end -}}
{{- $detailsName -}}
{{- end -}}

{{/*
  Builds /openapi-ui/.../factory/{factoryDetails}/{apiVersion}/{plural}/{name} from mappingKey +
  path placeholders.
*/}}
{{- define "in-cloud.web.cco.href.factoryDetails" -}}
{{- $detailsName := include "in-cloud.web.cco.factory.detailsName" . | trim -}}
{{- $basePrefix := default "/openapi-ui" .basePrefix -}}
{{- $clusterPath := default "{2}" .clusterPath -}}
{{- $namespacePath := default "{reqsJsonPath[0]['.metadata.namespace']['-']}" .namespacePath -}}
{{- $namePath := default "{reqsJsonPath[0]['.metadata.name']['-']}" .namePath -}}
{{- $apiVersion := default "v1" .apiVersion -}}
{{- $plural := .plural -}}
{{- $namespaced := true -}}
{{- if hasKey . "namespaced" -}}
{{- $namespaced = .namespaced -}}
{{- end -}}
{{- if $namespaced -}}
{{- printf "%s/%s/%s/factory/%s/%s/%s/%s" $basePrefix $clusterPath $namespacePath $detailsName $apiVersion $plural $namePath -}}
{{- else -}}
{{- printf "%s/%s/factory/%s/%s/%s/%s" $basePrefix $clusterPath $detailsName $apiVersion $plural $namePath -}}
{{- end -}}
{{- end -}}

{{/*
  Parses a legacy /openapi-ui/.../factory/{oldName}/... href, derives mappingKey from scope/api/plural,
  then rebuilds the URL via factoryDetails so links follow Navigation baseFactoriesMapping.
*/}}
{{- define "in-cloud.web.cco.href.resolveFromLegacy" -}}
{{- $root := .root -}}
{{- $href := .href -}}
{{- if not (and $root $href) -}}
{{- $href -}}
{{- else -}}
{{- $parts := splitList "/" $href -}}
{{- $partsLen := len $parts -}}
{{- $factoryIdx := -1 -}}
{{- range $i, $v := $parts -}}
{{- if and (eq $v "factory") (lt $factoryIdx 0) -}}
{{- $factoryIdx = $i -}}
{{- end -}}
{{- end -}}
{{- if or (lt $factoryIdx 0) (lt $partsLen (add $factoryIdx 5)) -}}
{{- $href -}}
{{- else -}}
{{- $basePrefix := printf "/%s" (index $parts 1) -}}
{{- $clusterPath := index $parts 2 -}}
{{- $namespaced := eq $factoryIdx 4 -}}
{{- $namespacePath := "" -}}
{{- if $namespaced -}}
{{- $namespacePath = index $parts 3 -}}
{{- end -}}
{{- $legacyFactoryName := index $parts (add $factoryIdx 1) -}}
{{- $apiVersionParts := slice $parts (add $factoryIdx 2) (sub $partsLen 2) -}}
{{- $apiVersion := join "/" $apiVersionParts -}}
{{- $plural := index $parts (sub $partsLen 2) -}}
{{- $namePath := index $parts (sub $partsLen 1) -}}
{{- $source := "builtin" -}}
{{- if contains "/" $apiVersion -}}
{{- $source = "api" -}}
{{- end -}}
{{- $scope := "clusterscoped" -}}
{{- if $namespaced -}}
{{- $scope = "namespaced" -}}
{{- end -}}
{{- $mappingKey := include "in-cloud.web.cco.factory.mappingKey" (dict
    "scope" $scope
    "source" $source
    "apiVersion" $apiVersion
    "plural" $plural
  ) | trim -}}
{{ include "in-cloud.web.cco.href.factoryDetails" (dict
    "root" $root
    "mappingKey" $mappingKey
    "factoryName" $legacyFactoryName
    "basePrefix" $basePrefix
    "clusterPath" $clusterPath
    "namespacePath" $namespacePath
    "namespaced" $namespaced
    "apiVersion" $apiVersion
    "plural" $plural
    "namePath" $namePath
  )
}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* props.link: antdLink cell; disableEventBubbling avoids triggering the table row click. */}}
{{- define "in-cloud.web.columns.factory.link" -}}
customProps:
  disableEventBubbling: true
  items:
    {{- /* antdLink: external or in-app href */}}
    - type: antdLink
      data:
        id: "value-link"
        href: {{ .link | quote }}
        text: {{ .text | quote }}
{{- end -}}