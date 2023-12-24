package y

res: namespace: "coder-amanibhavam-district-cluster-buildkite": cluster: buildkite: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "buildkite"
}
res: serviceaccount: "coder-amanibhavam-district-cluster-buildkite": buildkite: "buildkite-controller": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "buildkite-controller"
		namespace: "buildkite"
	}
}
res: role: "coder-amanibhavam-district-cluster-buildkite": buildkite: "buildkite-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		name:      "buildkite-controller"
		namespace: "buildkite"
	}
	rules: [{
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
		]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}
res: rolebinding: "coder-amanibhavam-district-cluster-buildkite": buildkite: buildkite: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		name:      "buildkite"
		namespace: "buildkite"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "buildkite-controller"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "buildkite-controller"
		namespace: "buildkite"
	}]
}
res: configmap: "coder-amanibhavam-district-cluster-buildkite": buildkite: "buildkite-config": {
	apiVersion: "v1"
	data: "config.yaml": """
		agent-token-secret: buildkite
		namespace: buildkite
		cluster-uuid: bd52647a-d3d5-4c15-9b3f-3b5f566ce6e3
		debug: true
		image: cache.defn.run:5000/dfd:buildkite
		max-in-flight: 0
		org: defn
		tags:
		- queue=default

		"""

	kind: "ConfigMap"
	metadata: {
		name:      "buildkite-config"
		namespace: "buildkite"
	}
}
res: deployment: "coder-amanibhavam-district-cluster-buildkite": buildkite: buildkite: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "buildkite"
		namespace: "buildkite"
	}
	spec: {
		selector: matchLabels: app: "buildkite"
		template: {
			metadata: {
				annotations: {
					"checksum/config":  "f633041f3ad3925d97c294b71cbac4ebef63eaec5636bc763d9effc035510d8b"
					"checksum/secrets": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
				}
				labels: app: "buildkite"
			}
			spec: {
				containers: [{
					env: [{
						name:  "CONFIG"
						value: "/etc/config.yaml"
					}]
					envFrom: [{
						secretRef: name: "buildkite"
					}]
					image: "ghcr.io/buildkite/agent-stack-k8s/controller:0.7.0@sha256:6d747da4f3898b092010fcdc382fc59dc3d90c5478d41e0a01eb9b6f53a9d91f"
					name:  "controller"
					resources: requests: {
						cpu:    "100m"
						memory: "100Mi"
					}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						seccompProfile: type: "RuntimeDefault"
					}
					terminationMessagePolicy: "FallbackToLogsOnError"
					volumeMounts: [{
						mountPath: "/etc/config.yaml"
						name:      "config"
						subPath:   "config.yaml"
					}]
				}]
				nodeSelector: {}
				serviceAccountName: "buildkite-controller"
				tolerations: []
				volumes: [{
					configMap: name: "buildkite-config"
					name: "config"
				}]
			}
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-buildkite": buildkite: buildkite: {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "buildkite"
		namespace: "buildkite"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "BUILDKITE_TOKEN"
			}
			secretKey: "BUILDKITE_TOKEN"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "BUILDKITE_AGENT_TOKEN"
			}
			secretKey: "BUILDKITE_AGENT_TOKEN"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
	}
}