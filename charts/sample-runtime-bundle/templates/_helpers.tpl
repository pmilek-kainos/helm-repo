{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create default pull secrets
*/}}
{{- define "common.registry-pull-secrets" -}}
{{- $common := dict "Values" .Values.common -}} 
{{- $noCommon := omit .Values "common" -}} 
{{- $overrides := dict "Values" $noCommon -}} 
{{- $noValues := omit . "Values" -}} 
{{- $values := merge $noValues $overrides $common -}} 
{{- with $values -}}
{{- range $value := .Values.global.registryPullSecrets }}
- name: {{ tpl (printf "%s" $value) $values | quote }}
{{- end }}
{{- range $value := .Values.registryPullSecrets }}
- name: {{ tpl (printf "%s" $value) $values | quote }}
{{- end }}

{{- end }}
{{- end -}}


{{- define "common.keycloak-enabled" -}}
{{- default "" .Values.global.keycloak.enabled -}}
{{- end -}}

{{/*
Create a default keycloak realm
*/}}
{{- define "common.keycloak-realm" -}}
	{{- $common := dict "Values" .Values.common -}} 
	{{- $noCommon := omit .Values "common" -}} 
	{{- $overrides := dict "Values" $noCommon -}} 
	{{- $noValues := omit . "Values" -}} 
	{{- with merge $noValues $overrides $common -}}
		{{- $value := .Values.global.keycloak.realm -}}
		{{- tpl (printf "%s" $value) . -}}
	{{- end -}}
{{- end -}}

{{/*
Create a default keycloak resource
*/}}
{{- define "common.keycloak-resource" -}}
	{{- $common := dict "Values" .Values.common -}} 
	{{- $noCommon := omit .Values "common" -}} 
	{{- $overrides := dict "Values" $noCommon -}} 
	{{- $noValues := omit . "Values" -}} 
	{{- with merge $noValues $overrides $common -}}
		{{- $value := .Values.global.keycloak.resource -}}
		{{- tpl (printf "%s" $value) . -}}
	{{- end -}}
{{- end -}}

{{/*
Create a default extra env templated values 
*/}}
{{- define "common.extra-env" -}}
{{- $common := dict "Values" .Values.common -}} 
{{- $noCommon := omit .Values "common" -}} 
{{- $overrides := dict "Values" $noCommon -}} 
{{- $noValues := omit . "Values" -}} 
{{- with merge $noValues $overrides $common -}}
{{- tpl .Values.global.keycloak.extraEnv . -}}
{{- tpl .Values.global.extraEnv . -}}
{{- tpl .Values.extraEnv . -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
