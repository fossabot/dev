package c

import (
	core "k8s.io/api/core/v1"
	batch "k8s.io/api/batch/v1"
	apps "k8s.io/api/apps/v1"
	rbac "k8s.io/api/rbac/v1"
)

_issuer: "zerossl-production"

kustomize: (#Transform & {
	transformer: #TransformChicken

	inputs: {
		rocky: {}
		rosie: {}
	}
}).outputs

kustomize: "hello": #Kustomize & {
	namespace: "default"

	_funcs: ["hello", "bye"]
	_domain: "default.defn.run"

	resource: "ingressroute-\(_domain)": {
		apiVersion: "traefik.containo.us/v1alpha1"
		kind:       "IngressRoute"
		metadata: {
			name:      _domain
			namespace: "default"
		}
		spec: entryPoints: ["websecure"]
		spec: routes: [{
			match: "HostRegexp(`{subdomain:[a-z0-9-]+}.\(_domain)`)"
			kind:  "Rule"
			services: [{
				name:      "kourier-internal"
				namespace: "kourier-system"
				kind:      "Service"
				port:      80
				scheme:    "http"
			}]
		}]
	}

	for f in _funcs {
		resource: "kservice-\(f)": {
			apiVersion: "serving.knative.dev/v1"
			kind:       "Service"
			metadata: {
				//labels: "networking.knative.dev/visibility": "cluster-local"
				name:      f
				namespace: "default"
			}
			spec: {
				template: spec: {
					containerConcurrency: 0
					containers: [{
						name:  "whoami"
						image: "containous/whoami:latest"
						ports: [{
							containerPort: 80
						}]
					}]
				}
				traffic: [{
					latestRevision: true
					percent:        100
				}]
			}
		}
	}
}

//kustomize: "events": #Kustomize & {
//	namespace: "default"
//
//	resource: "events": {
//		url: "events.yaml"
//	}
//}
//
//kustomize: "demo1": #Kustomize & {
//	resource: "demo": {
//		url: "https://bit.ly/demokuma"
//	}
//}
//
//kustomize: "demo2": #Kustomize & {
//	resource: "demo": {
//		url: "https://raw.githubusercontent.com/kumahq/kuma-counter-demo/master/demo.yaml"
//	}
//}

kustomize: "coredns": #Kustomize & {
	resource: "configmap-coredns": core.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: name:      "coredns-custom"
		metadata: namespace: "kube-system"
		data: "ts.net.server": """
			  ts.net {
			    forward . 100.100.100.100
			   }
			"""
	}
}

kustomize: "argo-cd": #Kustomize & {
	namespace: "argocd"

	resource: "namespace-argocd": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "argocd"
		}
	}

	resource: "argo-cd": {
		url: "https://raw.githubusercontent.com/argoproj/argo-cd/v2.7.10/manifests/install.yaml"
	}

	_host: "argocd.defn.run"

	resource: "ingress-argo-cd": {
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
		metadata: {
			name: "argo-cd"
			annotations: {
				"external-dns.alpha.kubernetes.io/hostname":        _host
				"traefik.ingress.kubernetes.io/router.tls":         "true"
				"traefik.ingress.kubernetes.io/router.entrypoints": "websecure"
			}
		}

		spec: {
			ingressClassName: "traefik"
			rules: [{
				host: _host
				http: paths: [{
					path:     "/"
					pathType: "Prefix"
					backend: service: {
						name: "argocd-server"
						port: number: 443
					}
				}]
			}]
		}
	}

	psm: "service-argocd-server": {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			name: "argocd-server"
			annotations: {
				"traefik.ingress.kubernetes.io/service.serverstransport": "traefik-insecure@kubernetescrd"
			}
		}
	}

	psm: "configmap-argocd-cmd-params-cm": core.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: name: "argocd-cmd-params-cm"
		data: {
			"server.insecure": "true"
		}
	}

	psm: "configmap-argocd-cm": core.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: name: "argocd-cm"
		data: {
			"kustomize.buildOptions": "--enable-helm"

			"application.resourceTrackingMethod": "annotation"

			"resource.customizations.health.networking.k8s.io_Ingress": """
				hs = {}
				hs.status = "Healthy"
				return hs
				"""

			"resource.customizations.health.tf.isaaguilar.com_Terraform": """
				hs = {}
				hs.status = "Progressing"
				hs.message = ""
				if obj.status ~= nil then
				    if obj.status.phase ~= nil then
				          if obj.status.phase == "completed" then
				               hs.status = "Healthy"
				         end

				          if obj.status.stage ~= nil then
				            if obj.status.stage.reason ~= nil then
				                  hs.message = obj.status.stage.reason
				            end
				          end
				    end
				end
				return hs
				"""

			"resource.customizations.health.argoproj.io_Application": """
				hs = {}
				hs.status = "Progressing"
				hs.message = ""
				if obj.status ~= nil then
				    if obj.status.health ~= nil then
				    hs.status = obj.status.health.status
				    if obj.status.health.message ~= nil then
				        hs.message = obj.status.health.message
				    end
				    end
				end
				return hs
				"""

			"resource.customizations.ignoreDifferences.admissionregistration.k8s.io_MutatingWebhookConfiguration": """
				jsonPointers:
				  - /webhooks/0/clientConfig/caBundle
				  - /webhooks/0/rules

				"""

			"resource.customizations.ignoreDifferences.admissionregistration.k8s.io_ValidatingWebhookConfiguration": """
				jsonPointers:
				  - /webhooks/0/rules

				"""

			"resource.customizations.ignoreDifferences.apps_Deployment": """
				jsonPointers:
				  - /spec/template/spec/tolerations

				"""

			"resource.customizations.ignoreDifferences.kyverno.io_ClusterPolicy": """
				jqPathExpressions:
				  - .spec.rules[] | select(.name|test("autogen-."))

				"""
		}
	}
}

kustomize: "argo-events": #KustomizeHelm & {
	namespace: "argo-events"

	helm: {
		release: "argo-events"
		name:    "argo-events"
		version: "2.0.6"
		repo:    "https://argoproj.github.io/argo-helm"
	}

	resource: "namespace-argo-events": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "argo-events"
		}
	}
}

// https://artifacthub.io/packages/helm/argo/argo-workflows
kustomize: "argo-workflows": #KustomizeHelm & {
	helm: {
		release:   "argo-workflows"
		name:      "argo-workflows"
		namespace: "argo-workflows"
		version:   "0.32.2"
		repo:      "https://argoproj.github.io/argo-helm"
		values: {
			controller: workflowNamespaces: [
				"argo-workflows",
				"defn",
			]
		}
	}

	resource: "namespace-argo-workflows": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "argo-workflows"
		}
	}
}

// https://artifacthub.io/packages/helm/coder-v2/coder
kustomize: "coder": #KustomizeHelm & {
	namespace: "coder"

	_host: "coder.defn.run"

	helm: {
		release:   "coder"
		name:      "coder"
		namespace: "coder"
		version:   "2.0.2"
		repo:      "https://helm.coder.com/v2"
		values: {
			coder: {
				service: type: "ClusterIP"

				env: [{
					name: "CODER_ACCESS_URL"
					valueFrom: secretKeyRef: {
						name: "coder"
						key:  "CODER_ACCESS_URL"
					}
				}]
			}
		}
	}

	resource: "namespace-coder": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "coder"
		}
	}

	resource: "ingress-coder": {
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
		metadata: {
			name: "coder"
			annotations: {
				"external-dns.alpha.kubernetes.io/hostname":        _host
				"traefik.ingress.kubernetes.io/router.tls":         "true"
				"traefik.ingress.kubernetes.io/router.entrypoints": "websecure"
			}
		}

		spec: {
			ingressClassName: "traefik"
			rules: [{
				host: _host
				http: paths: [{
					path:     "/"
					pathType: "Prefix"
					backend: service: {
						name: "coder"
						port: number: 80
					}
				}]
			}]
		}
	}

	resource: "externalsecret-coder": {
		apiVersion: "external-secrets.io/v1beta1"
		kind:       "ExternalSecret"
		metadata: {
			name:      "coder"
			namespace: "coder"
		}
		spec: {
			refreshInterval: "1h"
			secretStoreRef: {
				kind: "ClusterSecretStore"
				name: "dev"
			}
			dataFrom: [{
				extract: key: "dev/amanibhavam-global-coder"
			}]
			target: {
				name:           "coder"
				creationPolicy: "Owner"
			}
		}
	}

}

// https://artifacthub.io/packages/helm/kyverno/kyverno
kustomize: "kyverno": #KustomizeHelm & {
	namespace: "kyverno"

	helm: {
		release: "kyverno"
		name:    "kyverno"
		version: "3.0.5"
		repo:    "https://kyverno.github.io/kyverno"
		values: {
			replicaCount: 1
		}
	}

	resource: "namespace-kyverno": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "kyverno"
		}
	}

	resource: "clusterrole-create-clusterissuers": {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRole"
		metadata: name: "kyverno:generate-clusterissuers"
		metadata: labels: {
			"app.kubernetes.io/instance": "kyverno"
			"app.kubernetes.io/name":     "kyverno"
		}
		rules: [{
			apiGroups: ["cert-manager.io"]
			resources: ["clusterissuers"]
			verbs: [ "create", "update", "patch", "delete"]
		}]
	}
}

kustomize: "keda": #KustomizeHelm & {
	namespace: "keda"

	helm: {
		release: "keda"
		name:    "keda"
		version: "2.8.2"
		repo:    "https://kedacore.github.io/charts"
	}

	resource: "namespace-keda": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "keda"
		}
	}
}

// https://artifacthub.io/packages/helm/bitnami/external-dns
kustomize: "external-dns": #KustomizeHelm & {
	namespace: "external-dns"

	helm: {
		release: "external-dns"
		name:    "external-dns"
		version: "6.23.0"
		repo:    "https://charts.bitnami.com/bitnami"
		values: {
			logLevel: "debug"
			sources: [
				"service",
				"ingress",
			]
			provider: "cloudflare"
			cloudflare: {
				email:   "cloudflare@defn.us"
				proxied: false
			}
			domainFilters: [
				"defn.run",
			]
		}
	}

	resource: "namespace-external-dns": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "external-dns"
		}
	}
}

// https://github.com/knative-sandbox/net-kourier/releases
kustomize: "kourier": #Kustomize & {
	resource: "kourier": {
		url: "https://github.com/knative-sandbox/net-kourier/releases/download/knative-v1.10.0/kourier.yaml"
	}

	psm: "service-kourier-set-cluster-ip": {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			name:      "kourier"
			namespace: "kourier-system"
		}
		spec: type: "ClusterIP"
	}

	resource: "ingress-default-wildcard": {
		apiVersion: "networking.k8s.io/v1"
		kind:       "Ingress"
		metadata: {
			name:      "default-wildcard"
			namespace: "kourier-system"
			annotations: {
				"external-dns.alpha.kubernetes.io/hostname": "*.default.defn.run"
			}
		}

		spec: {
			ingressClassName: "traefik"
			rules: [{
				host: "wildcard.default.defn.run"
				http: paths: [{
					path:     "/"
					pathType: "Prefix"
					backend: service: {
						name: "kourier-internal"
						port: number: 80
					}
				}]
			}]
		}
	}
}

kustomize: "dev": #Kustomize & {
	namespace: "default"

	resource: "statefulset-dev": apps.#StatefulSet & {
		apiVersion: "apps/v1"
		kind:       "StatefulSet"
		metadata: {
			name:      "dev"
			namespace: "default"
		}
		spec: {
			serviceName: "dev"
			replicas:    1
			selector: matchLabels: app: "dev"
			template: {
				metadata: labels: app: "dev"
				spec: {
					volumes: [{
						name: "work"
						emptyDir: {}
					}]
					containers: [{
						name:            "code-server"
						image:           "169.254.32.1:5000/workspace"
						imagePullPolicy: "Always"
						command: [
							"/usr/bin/tini",
							"--",
						]
						args: [
							"bash",
							"-c",
							"exec ~/bin/e code-server --bind-addr 0.0.0.0:8888 --disable-telemetry",
						]
						tty: true
						env: [{
							name:  "PASSWORD"
							value: "admin"
						}]
						securityContext: privileged: true
						volumeMounts: [{
							mountPath: "/work"
							name:      "work"
						}]
					}]
				}
			}
		}
	}

	resource: "service-dev": core.#Service & {
		apiVersion: "v1"
		kind:       "Service"
		metadata: {
			name:      "dev"
			namespace: "default"
		}
		spec: {
			ports: [{
				port:       80
				protocol:   "TCP"
				targetPort: 8888
			}]
			selector: app: "dev"
			type: "ClusterIP"
		}
	}

	resource: "cluster-role-binding-admin": rbac.#ClusterRoleBinding & {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: name: "dev-admin"
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "cluster-admin"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "default"
			namespace: "default"
		}]
	}

	resource: "cluster-role-binding-delegator": rbac.#ClusterRoleBinding & {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: name: "dev-delegator"
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "system:auth-delegator"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "default"
			namespace: "default"
		}]
	}
}

// https://artifacthub.io/packages/helm/external-secrets-operator/external-secrets
kustomize: "external-secrets-operator": #KustomizeHelm & {
	namespace: "external-secrets"

	helm: {
		release: "external-secrets"
		name:    "external-secrets"
		version: "0.9.2"
		repo:    "https://charts.external-secrets.io"
		values: {
			webhook: create:        false
			certController: create: false
		}
	}

	resource: "namespace-external-secrets": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "external-secrets"
		}
	}

	resource: "cluster-role-binding-delegator": rbac.#ClusterRoleBinding & {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: name: "external-secrets-delegator"
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "system:auth-delegator"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "external-secrets"
			namespace: "external-secrets"
		}]
	}
}

// https://artifacthub.io/packages/helm/jkroepke/amazon-eks-pod-identity-webhook
kustomize: "pod-identity-webhook": #KustomizeHelm & {
	namespace: "default"

	helm: {
		release: "pod-identity-webhook"
		name:    "amazon-eks-pod-identity-webhook"
		version: "1.2.0"
		repo:    "https://jkroepke.github.io/helm-charts"
		values: {
			pki: certManager: certificate: duration:    "2160h0m0s"
			pki: certManager: certificate: renewBefore: "360h0m0s"
		}
	}
}

// gen_karpenter.sh
kustomize: "karpenter": #Kustomize & {
	namespace: "karpenter"

	resource: "karpenter": {
		url: "karpenter.yaml"
	}

	resource: "namespace-karpenter": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "karpenter"
		}
	}

	resource: (#Transform & {
		transformer: #TransformKarpenterProvisioner

		inputs: {
			for _env_name, _env in env {
				if (_env & #VCluster) != _|_ {
					if len(_env.instance_types) > 0 {
						"\(_env_name)": {}
					}
				}
			}

			[N=string]: {
				label:          "provisioner-\(N)"
				instance_types: env[N].instance_types
			}
		}
	}).outputs
}

// https://github.com/knative/serving/releases
kustomize: "knative": #Kustomize & {
	resource: "knative-serving": {
		url: "https://github.com/knative/serving/releases/download/knative-v1.10.0/serving-core.yaml"
	}

	psm: "namespace-knative-serving": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "knative-serving"
		}
	}

	psm: "deployment-webhook": apps.#Deployment & {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "webhook"
			namespace: "knative-serving"
		}
	}

	psm: "deployment-domainmappingwebhook": apps.#Deployment & {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "domainmapping-webhook"
			namespace: "knative-serving"
		}
	}

	psm: "deployment-domain-mapping": apps.#Deployment & {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "domain-mapping"
			namespace: "knative-serving"
		}
	}

	psm: "deployment-controller": apps.#Deployment & {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "controller"
			namespace: "knative-serving"
		}
	}

	psm: "deployment-autoscaler": apps.#Deployment & {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "autoscaler"
			namespace: "knative-serving"
		}
	}

	psm: "deployment-activator": apps.#Deployment & {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: {
			name:      "activator"
			namespace: "knative-serving"
		}
	}

	psm: "config-map-config-defaults": core.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "config-defaults"
			namespace: "knative-serving"
		}
		data: {
			"revision-timeout-seconds":     "1800"
			"max-revision-timeout-seconds": "1800"
		}
	}

	psm: "config-map-config-domain": core.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "config-domain"
			namespace: "knative-serving"
		}
		data: "defn.run": ""
	}

	psm: "config-map-config-features": core.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "config-features"
			namespace: "knative-serving"
		}
		data: {
			"kubernetes.podspec-affinity":    "enabled"
			"kubernetes.podspec-tolerations": "enabled"
		}
	}

	psm: "config-map-config-network": core.#ConfigMap & {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "config-network"
			namespace: "knative-serving"
		}
		data: "ingress.class": "kourier.ingress.networking.knative.dev"
	}
}

// https://artifacthub.io/packages/helm/cert-manager/cert-manager
kustomize: "cert-manager-crds": #Kustomize & {
	resource: "cert-manager-crds": {
		url: "https://github.com/cert-manager/cert-manager/releases/download/v1.12.3/cert-manager.crds.yaml"
	}
}

kustomize: "cert-manager": #KustomizeHelm & {
	helm: {
		release:   "cert-manager"
		name:      "cert-manager"
		namespace: "cert-manager"
		version:   "1.12.3"
		repo:      "https://charts.jetstack.io"
		values: {
			ingressShim: {
				defaultIssuerName: _issuer
				defaultIssuerKind: "ClusterIssuer"
			}

			global: logLevel: 4
		}
	}

	resource: "namespace-cert-manager": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: name: "cert-manager"
	}

	resource: "clusterissuer-cilium": {
		apiVersion: "cert-manager.io/v1"
		kind:       "ClusterIssuer"
		metadata: name: "cilium-ca"
		spec: ca: secretName: "cilium-ca"
	}
}

// https://artifacthub.io/packages/helm/loft/vcluster
#TransformKustomizeVCluster: {
	from: {
		#Input
		vc_name:    string | *from.name
		vc_machine: string | *from.name
		vc_index: int | *0
	}

	to: #KustomizeVCluster
}

#KustomizeVCluster: {
	_in: #TransformKustomizeVCluster.from

	#KustomizeHelm

	namespace: _in.name

	helm: {
		release: "vcluster"
		name:    "vcluster"
		version: "0.15.5"
		repo:    "https://charts.loft.sh"

		values: {
			vcluster: image: "rancher/k3s:v1.26.7-k3s1"

			syncer: extraArgs: [
				"--tls-san=vcluster.\(_in.vc_name).svc.cluster.local",
				//"--enforce-toleration=env=\(_in.vc_name):NoSchedule",
			]

			sync: {
				pods: ephemeralContainers:  true
				persistentvolumes: enabled: true
				ingresses: enabled:         true
				nodes: enabled:             true
			}

			//sync: nodes: nodeSelector: "env=\(_in.vc_machine)"

			//tolerations: [{
			//	key:      "env"
			//	value:    _in.vc_machine
			//	operator: "Equal"
			//}]

			//affinity: nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution: nodeSelectorTerms: [{
			//	matchExpressions: [{
			//		key:      "env"
			//		operator: "In"
			//		values: [_in.vc_machine]
			//	}]
			//}]

			fallbackHostDns: true
			multiNamespaceMode: enabled: false

			service: type: "LoadBalancer"
			//service: loadBalancerClass: "tailscale"
		}
	}

	resource: "namespace-vcluster": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: _in.vc_name
		}
	}

	jsp: "service-vcluster-lb": {
		target: {
			group: ""
			version: "v1"
			kind: "Service"
			name: "vcluster-lb"
			namespace: _in.vc_name
		}

		patches: [{
			op: "replace"
			path: "/spec/ports/0/port"
			value: 8443 + _in.vc_index
		}]
	}
}

// https://artifacthub.io/packages/helm/cilium/cilium
kustomize: "cilium-bootstrap": #KustomizeHelm & {
	namespace: "kube-system"

	helm: {
		release:   "cilium"
		name:      "cilium"
		namespace: "kube-system"
		version:   "1.14.0"
		repo:      "https://helm.cilium.io"
		values: {
			operator: replicas: 1
			hubble: {
				relay: enabled: true
				ui: enabled:    false
				tls: auto: {
					method: "certmanager"
					certManagerIssuerRef: {
						name:  "cilium-ca"
						kind:  "ClusterIssuer"
						group: "cert-manager.io"
					}
				}
			}
		}
	}
}

kustomize: "cilium": #KustomizeHelm & {
	namespace: "kube-system"

	helm: {
		release:   "cilium"
		name:      "cilium"
		namespace: "kube-system"
		version:   "1.14.0"
		repo:      "https://helm.cilium.io"
		values: {
			operator: replicas: 1
			envoy: enabled: true
			hubble: {
				relay: enabled: true
				ui: enabled:    true
				tls: auto: {
					method: "certmanager"
					certManagerIssuerRef: {
						name:  "cilium-ca"
						kind:  "ClusterIssuer"
						group: "cert-manager.io"
					}
				}
			}
		}
	}

//	_host: "hubble.defn.run"
//
//	resource: "ingress-hubble-ui": {
//		apiVersion: "networking.k8s.io/v1"
//		kind:       "Ingress"
//		metadata: {
//			name: "hubble-ui"
//			annotations: {
//				"external-dns.alpha.kubernetes.io/hostname":        _host
//				"traefik.ingress.kubernetes.io/router.tls":         "true"
//				"traefik.ingress.kubernetes.io/router.entrypoints": "websecure"
//			}
//		}
//
//		spec: {
//			ingressClassName: "traefik"
//			rules: [{
//				host: _host
//				http: paths: [{
//					path:     "/"
//					pathType: "Prefix"
//					backend: service: {
//						name: "hubble-ui"
//						port: number: 80
//					}
//				}]
//			}]
//		}
//	}
}

// https://artifacthub.io/packages/helm/bitnami/nginx
kustomize: "nginx": #KustomizeHelm & {
	namespace: "nginx"

	helm: {
		release:   "nginx"
		name:      "nginx"
		namespace: "nginx"
		version:   "15.1.2"
		repo:      "https://charts.bitnami.com/bitnami"
		values: {
		}
	}

	resource: "namespace-nginx": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "nginx"
		}
	}

	psm: "service-nginx": {
		apiVersion: "v1"
		kind:       "Service"

		metadata: {
			name:      "nginx"
			namespace: "nginx"
		}

		spec: {
			type: "ClusterIP"
		}
	}
}

// https://raw.githubusercontent.com/tailscale/tailscale/main/cmd/k8s-operator/manifests/operator.yaml
kustomize: "tailscale": #Kustomize & {
	resource: "tailscale": {
		url: "https://raw.githubusercontent.com/tailscale/tailscale/main/cmd/k8s-operator/manifests/operator.yaml"
	}
}

// https://doc.traefik.io/traefik/routing/providers/kubernetes-ingress/
// https://artifacthub.io/packages/helm/traefik/traefik
kustomize: "traefik": #KustomizeHelm & {
	namespace: "traefik"

	helm: {
		release:   "traefik"
		name:      "traefik"
		namespace: "traefik"
		version:   "24.0.0"
		repo:      "https://traefik.github.io/charts"
		values: {
			logs: general: level:  "DEBUG"
			logs: access: enabled: true
			providers: kubernetesIngress: {
				publishedService: enabled: true
				allowExternalNameServices: true
			}

			providers: kubernetesCRD: {
				allowExternalNameServices: true
				allowCrossNamespace:       true
			}
		}
	}

	resource: "namespace-traefik": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "traefik"
		}
	}

	resource: "tlsstore-traefik": {
		apiVersion: "traefik.containo.us/v1alpha1"
		kind:       "TLSStore"
		metadata: {
			name:      "default"
			namespace: "traefik"
		}

		spec: defaultCertificate: secretName: "defn-run-wildcard"
	}

	resource: "serverstransport-insecure": {
		apiVersion: "traefik.containo.us/v1alpha1"
		kind:       "ServersTransport"
		metadata: {
			name:      "insecure"
			namespace: "traefik"
		}
		spec: insecureSkipVerify: true
	}

	resource: "ingressroute-http-to-https": {
		apiVersion: "traefik.containo.us/v1alpha1"
		kind:       "IngressRoute"
		metadata: {
			name:      "traefik-http-to-https"
			namespace: "traefik"
		}
		spec: entryPoints: ["web"]
		spec: routes: [{
			match: "HostRegexp(`{subdomain:[a-z0-9-]+}.defn.run`)"
			kind:  "Rule"
			services: [{
				name: "noop@internal"
				kind: "TraefikService"
			}]
			middlewares: [{
				name: "http-to-https"
			}]
		}]
	}

	psm: "ingressroute-traefik-dashboard": {
		apiVersion: "traefik.io/v1alpha1"
		kind:       "IngressRoute"
		metadata: {
			name:      "traefik-dashboard"
			namespace: "traefik"
		}
		spec: entryPoints: ["websecure"]
		spec: routes: [{
			match: "Host(`traefik.defn.run`) && (PathPrefix(`/api`) || PathPrefix(`/dashboard`))"
			kind:  "Rule"
			services: [{
				name: "api@internal"
				kind: "TraefikService"
			}]
			middlewares: [{
				name: "http-to-https"
			}]
		}]
	}

	resource: "middleware-http-to-https": {
		apiVersion: "traefik.containo.us/v1alpha1"
		kind:       "Middleware"
		metadata: name: "http-to-https"
		spec: redirectScheme: {
			scheme:    "https"
			permanent: false
		}
	}

	psm: "service-tailscale": {
		apiVersion: "v1"
		kind:       "Service"

		metadata: {
			name:      "traefik"
			namespace: "traefik"
			annotations: {
				"external-dns.alpha.kubernetes.io/hostname": "traefik.defn.run"
			}
		}

		spec: {
			type:              "LoadBalancer"
			loadBalancerClass: "tailscale"
		}
	}
}

// https://artifacthub.io/packages/helm/alekc/caddy
kustomize: "caddy": #KustomizeHelm & {
	namespace: "caddy"

	helm: {
		release:   "caddy"
		name:      "caddy"
		namespace: "caddy"
		version:   "0.2.4"
		repo:      "https://charts.alekc.dev"
		values: {
			listenPort: 80
			https: {
				enabled: true
				port:    443
			}
			config: global: """
				auto_https disable_certs

				local_certs

				log {
				    output stdout
				}
				"""

			config: caddyFile: """
				https://*.defn.run {
				    tls /certs/tls.crt /certs/tls.key
				    reverse_proxy {http.request.host.labels.2}.default.svc.cluster.local:80 {
				        header_up -Host
				        header_up X-defn-label0	"{http.request.host.labels.0}"
				        header_up X-defn-label1	"{http.request.host.labels.1}"
				        header_up X-defn-label2	"{http.request.host.labels.2}"
				    }
				}
				"""

			volumes: [{
				name: "certs"
				secret: {
					secretName: "defn-run-wildcard"
					optional:   false
				}
			}]

			volumeMounts: [{
				name:      "certs"
				mountPath: "/certs"
			}]
		}
	}

	resource: "namespace-caddy": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "caddy"
		}
	}

	psm: "service-tailscale": {
		apiVersion: "v1"
		kind:       "Service"

		metadata: {
			name: "caddy"
			annotations: {
				"external-dns.alpha.kubernetes.io/hostname": "caddy.defn.run"
			}
		}

		spec: {
			type:              "LoadBalancer"
			loadBalancerClass: "tailscale"
		}
	}
}

// https://github.com/isaaguilar/terraform-operator/releases
kustomize: "tfo": #Kustomize & {
	namespace: "tf-system"

	resource: "tfo": {
		url: "https://raw.githubusercontent.com/GalleyBytes/terraform-operator/v0.12.1/deploy/bundles/v0.12.0/v0.12.0.yaml"
	}
}

kustomize: "bonchon": #Kustomize & {
	for chicken in ["rocky", "rosie"] {
		resource: "pre-sync-hook-dry-brine-\(chicken)-chicken": batch.#Job & {
			apiVersion: "batch/v1"
			kind:       "Job"
			metadata: {
				name:      "dry-brine-\(chicken)-chicken"
				namespace: "default"
				annotations: "argocd.argoproj.io/hook": "PreSync"
			}

			spec: backoffLimit: 0
			spec: template: spec: {
				serviceAccountName: "default"
				containers: [{
					name:  "meh"
					image: "defn/dev:kubectl"
					command: ["bash", "-c"]
					args: ["""
                    test "completed" == "$(kubectl get tf "\(chicken)" -o json | jq -r '.status.phase')"
                    """]
				}]
				restartPolicy: "Never"
			}
		}
	}

	resource: "tfo-demo-bonchon": {
		apiVersion: "tf.isaaguilar.com/v1alpha2"
		kind:       "Terraform"

		metadata: {
			name:      "bonchon"
			namespace: "default"
		}

		spec: {
			terraformVersion: "1.0.0"
			terraformModule: source: "https://github.com/defn/dev/m.git//tf/fried-chicken?ref=main"

			serviceAccount: "default"
			scmAuthMethods: []

			ignoreDelete:       true
			keepLatestPodsOnly: true

			outputsToOmit: ["0"]

			backend: """
				terraform {
				    backend "kubernetes" {
				        in_cluster_config = true
				        secret_suffix     = "bonchon"
				        namespace         = "default"
				    }
				}
				"""
		}
	}
}

kustomize: "sysbox": #Kustomize & {
	resource: "sysbox": {
		url: "https://raw.githubusercontent.com/nestybox/sysbox/master/sysbox-k8s-manifests/sysbox-install.yaml"
	}

	psm: "sysbox-deploy-k8s": {
		apiVersion: "apps/v1"
		kind:       "DaemonSet"

		metadata: {
			name:      "sysbox-deploy-k8s"
			namespace: "kube-system"
		}
	}
}

kustomize: "defn-shared": #Kustomize & {
	resource: "externalsecret-\(_issuer)": {
		apiVersion: "external-secrets.io/v1beta1"
		kind:       "ExternalSecret"
		metadata: {
			name:      _issuer
			namespace: "cert-manager"
		}
		spec: {
			refreshInterval: "1h"
			secretStoreRef: {
				kind: "ClusterSecretStore"
				name: "dev"
			}
			dataFrom: [{
				extract: key: "dev/amanibhavam-global"
			}]
			target: {
				name:           _issuer
				creationPolicy: "Owner"
			}
		}
	}

	resource: "externalsecret-external-dns": {
		apiVersion: "external-secrets.io/v1beta1"
		kind:       "ExternalSecret"
		metadata: {
			name:      "external-dns"
			namespace: "external-dns"
		}
		spec: {
			refreshInterval: "1h"
			secretStoreRef: {
				kind: "ClusterSecretStore"
				name: "dev"
			}
			dataFrom: [{
				extract: key: "dev/amanibhavam-global"
			}]
			target: {
				name:           "external-dns"
				creationPolicy: "Owner"
			}
		}
	}

	resource: "clusterpolicy-clusterissuer-\(_issuer)": {
		apiVersion: "kyverno.io/v1"
		kind:       "ClusterPolicy"
		metadata: name: "\(_issuer)-clusterissuer"
		spec: {
			generateExistingOnPolicyUpdate: true
			rules: [{
				name: "create-cluster-issuer"
				match: any: [{
					resources: {
						names: [
							_issuer,
						]
						kinds: [
							"Secret",
						]
						namespaces: [
							"cert-manager",
						]
					}
				}]
				generate: {
					synchronize: true
					apiVersion:  "cert-manager.io/v1"
					kind:        "ClusterIssuer"
					name:        _issuer
					data: spec: acme: {
						server: "https://acme.zerossl.com/v2/DV90"
						email:  "{{request.object.data.zerossl_email | base64_decode(@)}}"

						privateKeySecretRef: name: "\(_issuer)-acme"

						externalAccountBinding: {
							keyID: "{{request.object.data.zerossl_eab_kid | base64_decode(@)}}"
							keySecretRef: {
								name: _issuer
								key:  "zerossl-eab-hmac"
							}
						}

						solvers: [{
							selector: {}
							dns01: cloudflare: {
								email: "{{request.object.data.cloudflare_email | base64_decode(@)}}"
								apiTokenSecretRef: {
									name: _issuer
									key:  "cloudflare-api-token"
								}
							}
						}]
					}
				}
			}]
		}
	}

	resource: "cluster-role-binding-admin": rbac.#ClusterRoleBinding & {
		apiVersion: "rbac.authorization.k8s.io/v1"
		kind:       "ClusterRoleBinding"
		metadata: name: "default-admin"
		roleRef: {
			apiGroup: "rbac.authorization.k8s.io"
			kind:     "ClusterRole"
			name:     "cluster-admin"
		}
		subjects: [{
			kind:      "ServiceAccount"
			name:      "default"
			namespace: "default"
		}]
	}
}

kustomize: "defn": #Kustomize & {
	resource: "namespace-defn": core.#Namespace & {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: {
			name: "defn"
		}
	}

	resource: "certificate-defn-run-wildcard-traefik": {
		apiVersion: "cert-manager.io/v1"
		kind:       "Certificate"
		metadata: {
			name:      "defn-run-wildcard"
			namespace: "traefik"
		}
		spec: {
			secretName: "defn-run-wildcard"
			dnsNames: [
				"*.defn.run",
				"*.default.defn.run",
			]
			issuerRef: {
				name:  _issuer
				kind:  "ClusterIssuer"
				group: "cert-manager.io"
			}
		}
	}

	resource: "workflow-hello": {
		apiVersion: "argoproj.io/v1alpha1"
		kind:       "Workflow"
		metadata: {
			name:      "hello"
			namespace: "defn"
		}
		spec: {
			entrypoint: "whalesay"
			arguments: parameters: [{
				name:  "message"
				value: "world"
			}]
			templates: [{
				name: "whalesay"
				inputs: parameters: [{
					name: "message"
				}]
				container: {
					image: "docker/whalesay"
					command: ["cowsay"]
					args: ["{{inputs.parameters.message}}"]
				}
			}]
		}
	}
}
