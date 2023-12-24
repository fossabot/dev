package y

res: namespace: "coder-amanibhavam-school-cluster-external-dns": cluster: "external-dns": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "external-dns"
}
res: serviceaccount: "coder-amanibhavam-school-cluster-external-dns": "external-dns": "external-dns": {
	apiVersion:                   "v1"
	automountServiceAccountToken: true
	kind:                         "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "external-dns"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "external-dns"
			"app.kubernetes.io/version":    "0.14.0"
			"helm.sh/chart":                "external-dns-6.28.6"
		}
		name:      "external-dns"
		namespace: "external-dns"
	}
}
res: clusterrole: "coder-amanibhavam-school-cluster-external-dns": cluster: "external-dns-external-dns": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "external-dns"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "external-dns"
			"app.kubernetes.io/version":    "0.14.0"
			"helm.sh/chart":                "external-dns-6.28.6"
		}
		name: "external-dns-external-dns"
	}
	rules: [{
		apiGroups: [""]
		resources: [
			"services",
			"pods",
			"nodes",
			"endpoints",
			"namespaces",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [
			"extensions",
			"networking.k8s.io",
			"getambassador.io",
		]
		resources: [
			"ingresses",
			"hosts",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["route.openshift.io"]
		resources: ["routes"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["networking.istio.io"]
		resources: [
			"gateways",
			"virtualservices",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["zalando.org"]
		resources: ["routegroups"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["zalando.org"]
		resources: ["routegroups/status"]
		verbs: [
			"patch",
			"update",
		]
	}, {
		apiGroups: ["projectcontour.io"]
		resources: ["httpproxies"]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: [
			"gloo.solo.io",
			"gateway.solo.io",
		]
		resources: [
			"proxies",
			"virtualservices",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["configuration.konghq.com"]
		resources: ["tcpingresses"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["gateway.networking.k8s.io"]
		resources: [
			"gateways",
			"httproutes",
			"tlsroutes",
			"tcproutes",
			"udproutes",
			"grpcroutes",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["cis.f5.com"]
		resources: ["virtualservers"]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}]
}
res: clusterrolebinding: "coder-amanibhavam-school-cluster-external-dns": cluster: "external-dns-external-dns": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "external-dns"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "external-dns"
			"app.kubernetes.io/version":    "0.14.0"
			"helm.sh/chart":                "external-dns-6.28.6"
		}
		name: "external-dns-external-dns"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "external-dns-external-dns"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "external-dns"
		namespace: "external-dns"
	}]
}
res: service: "coder-amanibhavam-school-cluster-external-dns": "external-dns": "external-dns": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "external-dns"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "external-dns"
			"app.kubernetes.io/version":    "0.14.0"
			"helm.sh/chart":                "external-dns-6.28.6"
		}
		name:      "external-dns"
		namespace: "external-dns"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       7979
			protocol:   "TCP"
			targetPort: "http"
		}]
		selector: {
			"app.kubernetes.io/instance": "external-dns"
			"app.kubernetes.io/name":     "external-dns"
		}
		sessionAffinity: "None"
		type:            "ClusterIP"
	}
}
res: deployment: "coder-amanibhavam-school-cluster-external-dns": "external-dns": "external-dns": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "external-dns"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "external-dns"
			"app.kubernetes.io/version":    "0.14.0"
			"helm.sh/chart":                "external-dns-6.28.6"
		}
		name:      "external-dns"
		namespace: "external-dns"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/instance": "external-dns"
			"app.kubernetes.io/name":     "external-dns"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/instance":   "external-dns"
				"app.kubernetes.io/managed-by": "Helm"
				"app.kubernetes.io/name":       "external-dns"
				"app.kubernetes.io/version":    "0.14.0"
				"helm.sh/chart":                "external-dns-6.28.6"
			}
			spec: {
				affinity: {
					podAntiAffinity: preferredDuringSchedulingIgnoredDuringExecution: [{
						podAffinityTerm: {
							labelSelector: matchLabels: {
								"app.kubernetes.io/instance": "external-dns"
								"app.kubernetes.io/name":     "external-dns"
							}
							topologyKey: "kubernetes.io/hostname"
						}
						weight: 1
					}]
				}
				containers: [{
					args: [
						"--metrics-address=:7979",
						"--log-level=debug",
						"--log-format=text",
						"--publish-internal-services",
						"--service-type-filter=ClusterIP",
						"--service-type-filter=NodePort",
						"--service-type-filter=LoadBalancer",
						"--service-type-filter=ExternalName",
						"--domain-filter=defn.run",
						"--policy=upsert-only",
						"--provider=cloudflare",
						"--registry=txt",
						"--interval=1m",
						"--source=service",
						"--source=ingress",
					]
					env: [{
						name: "CF_API_TOKEN"
						valueFrom: secretKeyRef: {
							key:      "cloudflare_api_token"
							name:     "external-dns"
							optional: true
						}
					}, {
						name: "CF_API_KEY"
						valueFrom: secretKeyRef: {
							key:      "cloudflare_api_key"
							name:     "external-dns"
							optional: true
						}
					}, {
						name:  "CF_API_EMAIL"
						value: "cloudflare@defn.us"
					}]
					image:           "docker.io/bitnami/external-dns:0.14.0-debian-11-r2"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 2
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      5
					}
					name: "external-dns"
					ports: [{
						containerPort: 7979
						name:          "http"
					}]
					readinessProbe: {
						failureThreshold: 6
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      5
					}
					resources: {
						limits: {}
						requests: {}
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						privileged:             false
						readOnlyRootFilesystem: false
						runAsNonRoot:           true
						runAsUser:              1001
						seccompProfile: type: "RuntimeDefault"
					}
				}]
				securityContext: fsGroup: 1001
				serviceAccountName: "external-dns"
			}
		}
	}
}
res: externalsecret: "coder-amanibhavam-school-cluster-external-dns": "external-dns": "external-dns": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "external-dns"
		namespace: "external-dns"
	}
	spec: {
		dataFrom: [{
			extract: key: "coder-amanibhavam-school-cluster"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-school"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-dns"
		}
	}
}