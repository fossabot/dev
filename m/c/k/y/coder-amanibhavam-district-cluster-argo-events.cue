package y

res: namespace: "coder-amanibhavam-district-cluster-argo-events": cluster: "argo-events": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "argo-events"
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-events": cluster: "eventbus.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "eventbus.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "EventBus"
			listKind: "EventBusList"
			plural:   "eventbus"
			shortNames: ["eb"]
			singular: "eventbus"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
					status: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-events": cluster: "eventsources.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "eventsources.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "EventSource"
			listKind: "EventSourceList"
			plural:   "eventsources"
			shortNames: ["es"]
			singular: "eventsource"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
					status: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-events": cluster: "sensors.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "sensors.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "Sensor"
			listKind: "SensorList"
			plural:   "sensors"
			shortNames: ["sn"]
			singular: "sensor"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
					status: {
						type:                                   "object"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: serviceaccount: "coder-amanibhavam-district-cluster-argo-events": "argo-events": "argo-events-controller-manager": {
	apiVersion:                   "v1"
	automountServiceAccountToken: true
	kind:                         "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "controller-manager"
			"app.kubernetes.io/instance":   "argo-events"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-events-controller-manager"
			"app.kubernetes.io/part-of":    "argo-events"
			"helm.sh/chart":                "argo-events-2.4.1"
		}
		name:      "argo-events-controller-manager"
		namespace: "argo-events"
	}
}
res: serviceaccount: "coder-amanibhavam-district-cluster-argo-events": "argo-events": "argo-events-events-webhook": {
	apiVersion:                   "v1"
	automountServiceAccountToken: true
	kind:                         "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "events-webhook"
			"app.kubernetes.io/instance":   "argo-events"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-events-events-webhook"
			"app.kubernetes.io/part-of":    "argo-events"
			"helm.sh/chart":                "argo-events-2.4.1"
		}
		name:      "argo-events-events-webhook"
		namespace: "argo-events"
	}
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-events": cluster: "argo-events-controller-manager": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "controller-manager"
			"app.kubernetes.io/instance":   "argo-events"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-events-controller-manager"
			"app.kubernetes.io/part-of":    "argo-events"
			"helm.sh/chart":                "argo-events-2.4.1"
		}
		name: "argo-events-controller-manager"
	}
	rules: [{
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"sensors",
			"sensors/finalizers",
			"sensors/status",
			"eventsources",
			"eventsources/finalizers",
			"eventsources/status",
			"eventbus",
			"eventbus/finalizers",
			"eventbus/status",
		]
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
		resources: [
			"pods",
			"pods/exec",
			"configmaps",
			"services",
			"persistentvolumeclaims",
		]
		verbs: [
			"create",
			"get",
			"list",
			"watch",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: [
			"create",
			"get",
			"list",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: ["apps"]
		resources: [
			"deployments",
			"statefulsets",
		]
		verbs: [
			"create",
			"get",
			"list",
			"watch",
			"update",
			"patch",
			"delete",
		]
	}]
}
res: clusterrolebinding: "coder-amanibhavam-district-cluster-argo-events": cluster: "argo-events-controller-manager": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "controller-manager"
			"app.kubernetes.io/instance":   "argo-events"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-events-controller-manager"
			"app.kubernetes.io/part-of":    "argo-events"
			"helm.sh/chart":                "argo-events-2.4.1"
		}
		name: "argo-events-controller-manager"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "argo-events-controller-manager"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argo-events-controller-manager"
		namespace: "argo-events"
	}]
}
res: configmap: "coder-amanibhavam-district-cluster-argo-events": "argo-events": "argo-events-controller-manager": {
	apiVersion: "v1"
	data: "controller-config.yaml": """
		eventBus:
		  nats:
		    versions:
		    - version: latest
		      natsStreamingImage: nats-streaming:latest
		      metricsExporterImage: natsio/prometheus-nats-exporter:latest
		    - version: 0.22.1
		      natsStreamingImage: nats-streaming:0.22.1
		      metricsExporterImage: natsio/prometheus-nats-exporter:0.8.0
		  jetstream:
		    # Default JetStream settings, could be overridden by EventBus JetStream specs
		    settings: |
		      # https://docs.nats.io/running-a-nats-service/configuration#jetstream
		      # Only configure \"max_memory_store\" or \"max_file_store\", do not set \"store_dir\" as it has been hardcoded.
		      max_memory_store: -1
		      max_file_store: -1
		    # The default properties of the streams to be created in this JetStream service
		    streamConfig: |
		      maxMsgs: 1e+06
		      maxAge: 72h
		      maxBytes: 1GB
		      replicas: 3
		      duplicates: 300s
		    versions:
		    - version: latest
		      natsImage: nats:latest
		      metricsExporterImage: natsio/prometheus-nats-exporter:latest
		      configReloaderImage: natsio/nats-server-config-reloader:latest
		      startCommand: /nats-server

		"""

	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "argo-events"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-events-controller-manager"
			"app.kubernetes.io/part-of":    "argo-events"
			"helm.sh/chart":                "argo-events-2.4.1"
		}
		name:      "argo-events-controller-manager"
		namespace: "argo-events"
	}
}
res: deployment: "coder-amanibhavam-district-cluster-argo-events": "argo-events": "argo-events-controller-manager": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "controller-manager"
			"app.kubernetes.io/instance":   "argo-events"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-events-controller-manager"
			"app.kubernetes.io/part-of":    "argo-events"
			"app.kubernetes.io/version":    "v1.8.1"
			"helm.sh/chart":                "argo-events-2.4.1"
		}
		name:      "argo-events-controller-manager"
		namespace: "argo-events"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 5
		selector: matchLabels: {
			"app.kubernetes.io/instance": "argo-events"
			"app.kubernetes.io/name":     "argo-events-controller-manager"
		}
		template: {
			metadata: {
				annotations: "checksum/config": "f22cec35653203f2e57cc11e93092b67dd16e53f2acdd736b6497015a54f0d9b"
				labels: {
					"app.kubernetes.io/component":  "controller-manager"
					"app.kubernetes.io/instance":   "argo-events"
					"app.kubernetes.io/managed-by": "Helm"
					"app.kubernetes.io/name":       "argo-events-controller-manager"
					"app.kubernetes.io/part-of":    "argo-events"
					"app.kubernetes.io/version":    "v1.8.1"
					"helm.sh/chart":                "argo-events-2.4.1"
				}
			}
			spec: {
				containers: [{
					args: ["controller"]
					env: [{
						name:  "ARGO_EVENTS_IMAGE"
						value: "quay.io/argoproj/argo-events:v1.8.1"
					}, {
						name: "NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
					image:           "quay.io/argoproj/argo-events:v1.8.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 3
						httpGet: {
							path: "/healthz"
							port: "probe"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      1
					}
					name: "controller-manager"
					ports: [{
						containerPort: 7777
						name:          "metrics"
						protocol:      "TCP"
					}, {
						containerPort: 8081
						name:          "probe"
						protocol:      "TCP"
					}]
					readinessProbe: {
						failureThreshold: 3
						httpGet: {
							path: "/readyz"
							port: "probe"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
						successThreshold:    1
						timeoutSeconds:      1
					}
					volumeMounts: [{
						mountPath: "/etc/argo-events"
						name:      "config"
					}]
				}]
				serviceAccountName: "argo-events-controller-manager"
				volumes: [{
					configMap: name: "argo-events-controller-manager"
					name: "config"
				}]
			}
		}
	}
}