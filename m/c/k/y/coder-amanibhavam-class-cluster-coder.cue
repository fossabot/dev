package y

res: namespace: "coder-amanibhavam-class-cluster-coder": cluster: coder: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "coder"
}
res: serviceaccount: "coder-amanibhavam-class-cluster-coder": coder: coder: {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "coder"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "coder"
			"app.kubernetes.io/part-of":    "coder"
			"app.kubernetes.io/version":    "2.6.0"
			"helm.sh/chart":                "coder-2.6.0"
		}
		name:      "coder"
		namespace: "coder"
	}
}
res: role: "coder-amanibhavam-class-cluster-coder": coder: "coder-workspace-perms": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name:      "coder-workspace-perms"
		namespace: "coder"
	}
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: ["apps"]
		resources: ["deployments"]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}]
}
res: rolebinding: "coder-amanibhavam-class-cluster-coder": coder: coder: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name:      "coder"
		namespace: "coder"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "coder-workspace-perms"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "coder"
		namespace: "coder"
	}]
}
res: clusterrolebinding: "coder-amanibhavam-class-cluster-coder": cluster: coder: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "coder"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "cluster-admin"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "coder"
		namespace: "coder"
	}]
}
res: service: "coder-amanibhavam-class-cluster-coder": coder: coder: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "coder"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "coder"
			"app.kubernetes.io/part-of":    "coder"
			"app.kubernetes.io/version":    "2.6.0"
			"helm.sh/chart":                "coder-2.6.0"
		}
		name:      "coder"
		namespace: "coder"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			protocol:   "TCP"
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/instance": "coder"
			"app.kubernetes.io/name":     "coder"
		}
		sessionAffinity: "None"
		type:            "ClusterIP"
	}
}
res: deployment: "coder-amanibhavam-class-cluster-coder": coder: coder: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "coder"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "coder"
			"app.kubernetes.io/part-of":    "coder"
			"app.kubernetes.io/version":    "2.6.0"
			"helm.sh/chart":                "coder-2.6.0"
		}
		name:      "coder"
		namespace: "coder"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/instance": "coder"
			"app.kubernetes.io/name":     "coder"
		}
		template: {
			metadata: {
				annotations: {}
				labels: {
					"app.kubernetes.io/instance":   "coder"
					"app.kubernetes.io/managed-by": "Helm"
					"app.kubernetes.io/name":       "coder"
					"app.kubernetes.io/part-of":    "coder"
					"app.kubernetes.io/version":    "2.6.0"
					"helm.sh/chart":                "coder-2.6.0"
				}
			}
			spec: {
				affinity: podAntiAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
					podAffinityTerm: {
						labelSelector: matchExpressions: [{
							key:      "app.kubernetes.io/instance"
							operator: "In"
							values: ["coder"]
						}]
						topologyKey: "kubernetes.io/hostname"
					}
					weight: 1
				}]
				containers: [{
					args: ["server"]
					command: ["/opt/coder"]
					env: [{
						name:  "CODER_HTTP_ADDRESS"
						value: "0.0.0.0:8080"
					}, {
						name:  "CODER_PROMETHEUS_ADDRESS"
						value: "0.0.0.0:2112"
					}, {
						name: "KUBE_POD_IP"
						valueFrom: fieldRef: fieldPath: "status.podIP"
					}, {
						name:  "CODER_DERP_SERVER_RELAY_URL"
						value: "http://$(KUBE_POD_IP):8080"
					}, {
						name:  "CODER_ACCESS_URL"
						value: "https://coder.class.amanibhavam.defn.run"
					}, {
						name:  "CODER_WILDCARD_ACCESS_URL"
						value: "*.coder.class.amanibhavam.defn.run"
					}, {
						name:  "CODER_REDIRECT_TO_ACCESS_URL"
						value: "false"
					}, {
						name:  "CODER_UPDATE_CHECK"
						value: "false"
					}, {
						name:  "CODER_TELEMETRY_ENABLE"
						value: "false"
					}, {
						name:  "CODER_TELEMETRY_TRACE"
						value: "false"
					}, {
						name:  "CODER_DERP_SERVER_ENABLE"
						value: "true"
					}, {
						name:  "CODER_DISABLE_PASSWORD_AUTH"
						value: "false"
					}, {
						name:  "CODER_STRICT_TRANSPORT_SECURITY"
						value: "60"
					}, {
						name:  "CODER_EXPERIMENTS"
						value: "dashboard_theme"
					}, {
						name:  "CODER_SCALETEST_JOB_TIMEOUT"
						value: "10m"
					}, {
						name:  "CODER_ENABLE_TERRAFORM_DEBUG_MODE"
						value: "true"
					}, {
						name:  "CODER_SECURE_AUTH_COOKIE"
						value: "true"
					}, {
						name:  "CODER_OAUTH2_GITHUB_ALLOW_SIGNUPS"
						value: "true"
					}, {
						name:  "CODER_OAUTH2_GITHUB_ALLOWED_ORGS"
						value: "defn"
					}, {
						name:  "CODER_OAUTH2_GITHUB_ALLOWED_TEAMS"
						value: "defn/class"
					}, {
						name: "CODER_OAUTH2_GITHUB_CLIENT_ID"
						valueFrom: secretKeyRef: {
							key:  "coder_oauth2_github_client_id"
							name: "coder"
						}
					}, {
						name: "CODER_OAUTH2_GITHUB_CLIENT_SECRET"
						valueFrom: secretKeyRef: {
							key:  "coder_oauth2_github_client_secret"
							name: "coder"
						}
					}, {
						name: "CODER_PG_CONNECTION_URL"
						valueFrom: secretKeyRef: {
							key:  "coder_pg_connection_url"
							name: "coder.coder-db.connection-url"
						}
					}]
					image:           "ghcr.io/coder/coder:v2.6.0"
					imagePullPolicy: "IfNotPresent"
					lifecycle: {}
					livenessProbe: httpGet: {
						path:   "/healthz"
						port:   "http"
						scheme: "HTTP"
					}
					name: "coder"
					ports: [{
						containerPort: 8080
						name:          "http"
						protocol:      "TCP"
					}]
					readinessProbe: httpGet: {
						path:   "/healthz"
						port:   "http"
						scheme: "HTTP"
					}
					resources: {}
					securityContext: {
						allowPrivilegeEscalation: false
						runAsGroup:               1000
						runAsNonRoot:             true
						runAsUser:                1000
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: []
				}]
				restartPolicy:                 "Always"
				serviceAccountName:            "coder"
				terminationGracePeriodSeconds: 60
				volumes: []
			}
		}
	}
}
res: postgresql: "coder-amanibhavam-class-cluster-coder": coder: "coder-db": {
	apiVersion: "acid.zalan.do/v1"
	kind:       "postgresql"
	metadata: {
		name:      "coder-db"
		namespace: "coder"
	}
	spec: {
		databases: coder: "coder"
		numberOfInstances: 1
		postgresql: version: "15"
		teamId: "coder"
		users: coder: [
			"superuser",
			"createdb",
		]
		volume: size: "10Gi"
	}
}
res: externalsecret: "coder-amanibhavam-class-cluster-coder": coder: coder: {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "coder"
		namespace: "coder"
	}
	spec: {
		dataFrom: [{
			extract: key: "coder-amanibhavam-class-cluster"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-class"
		}
		target: {
			creationPolicy: "Owner"
			name:           "coder"
		}
	}
}
res: clusterpolicy: "coder-amanibhavam-class-cluster-coder": coder: "coder-connection-url": {
	apiVersion: "kyverno.io/v1"
	kind:       "ClusterPolicy"
	metadata: {
		name:      "coder-connection-url"
		namespace: "coder"
	}
	spec: {
		generateExistingOnPolicyUpdate: true
		rules: [{
			generate: {
				apiVersion: "v1"
				data: {
					stringData: coder_pg_connection_url: "postgresql://{{request.object.data.username | base64_decode(@)}}:{{request.object.data.password | base64_decode(@)}}@coder-db:5432/coder?sslmode=require"

					type: "Opaque"
				}
				kind:        "Secret"
				name:        "coder.coder-db.connection-url"
				namespace:   "coder"
				synchronize: true
			}
			match: any: [{
				resources: {
					kinds: ["Secret"]
					names: ["coder.coder-db.credentials.postgresql.acid.zalan.do"]
					namespaces: ["coder"]
				}
			}]
			name: "create-secret-coder-connection-url"
		}]
	}
}
res: ingress: "coder-amanibhavam-class-cluster-coder": coder: coder: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: {
			"traefik.ingress.kubernetes.io/router.entrypoints": "websecure"
			"traefik.ingress.kubernetes.io/router.tls":         "true"
		}
		name:      "coder"
		namespace: "coder"
	}
	spec: {
		ingressClassName: "traefik"
		rules: [{
			host: "coder.class.amanibhavam.defn.run"
			http: paths: [{
				backend: service: {
					name: "coder"
					port: number: 80
				}
				path:     "/"
				pathType: "Prefix"
			}]
		}]
	}
}
res: ingressroute: "coder-amanibhavam-class-cluster-coder": coder: "coder-wildcard": {
	apiVersion: "traefik.containo.us/v1alpha1"
	kind:       "IngressRoute"
	metadata: {
		name:      "coder-wildcard"
		namespace: "coder"
	}
	spec: {
		entryPoints: ["websecure"]
		routes: [{
			kind:  "Rule"
			match: "HostRegexp(`{subdomain:[a-z0-9-]+}.coder.class.amanibhavam.defn.run`)"
			services: [{
				kind:      "Service"
				name:      "coder"
				namespace: "coder"
				port:      80
				scheme:    "http"
			}]
		}]
	}
}