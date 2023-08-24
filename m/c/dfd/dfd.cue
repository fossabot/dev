package c

_issuer:           "zerossl-production"
_cloudflare_email: "cloudflare@defn.us"

_domain_name: "defn.run"

_domain_slug: "dev-amanibhavam-defn-run"
_domain:      "dev.amanibhavam.defn.run"

cluster_type: "k3d"
cluster_name: "dfd"
vclusters: [0, 1]

env: (#Transform & {
	transformer: #TransformK3D

	inputs: "\(cluster_name)-bootstrap": bootstrap: {
		"cilium-bootstrap": [1, ""]
		"cert-manager-crds": [1, ""]
	}
}).outputs

env: (#Transform & {
	transformer: #TransformK3D

	inputs: "\(cluster_name)": {
		bootstrap: {
			// ~~~~~ Wave 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			//
			// essentials
			"kyverno": [2, "", "ServerSideApply=true"]
			"cert-manager": [2, ""]

			// ~~~~~ Wave 10 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			//
			// external secrets
			"pod-identity": [10, ""]
			"external-secrets": [11, ""]
			"secrets": [12, ""]

			// ~~~~~ Wave 30 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			//
			// external dns, issuer
			"external-dns": [30, ""]
			"issuer": [30, ""]

			// ~~~~~ Wave 40 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			//
			// traefik, functions
			"knative": [40, ""]
			"kourier": [40, ""]
			"traefik": [40, ""]

			// ~~~~~ Wave 100+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			//
			// bootstrapped
			"cilium": [100, ""]
			"argo-cd": [100, ""]

			// vclusters
			for v in vclusters {
				// vcluster
				"\(cluster_type)-\(cluster_name)-vc\(v)": [100, ""]

				// vcluster workloads
				"vcluster-\(cluster_type)-\(cluster_name)-vc\(v)": [101, ""]
			}

			// experimental
			"hello": [100, ""]
			"emojivoto": [100, ""]
		}
	}
}).outputs

env: (#Transform & {
	transformer: #TransformVCluster

	inputs: {
		[string]: {
			instance_types: []
			parent: env[cluster_name]
			bootstrap: {
				"kyverno": [2, "", "ServerSideApply=true"]
				"cert-manager": [2, ""]
				"pod-identity": [10, ""]
				"emojivoto": [100, "", "ServerSideApply=true"]
			}
		}

		for v in vclusters {
			"\(cluster_type)-\(cluster_name)-vc\(v)": {}
		}
	}
}).outputs

kustomize: (#Transform & {
	transformer: #TransformKustomizeVCluster

	inputs: {
		[string]: vc_machine: cluster_name
		for v in vclusters {
			"\(cluster_type)-\(cluster_name)-vc\(v)": vc_index: v
		}
	}
}).outputs

kustomize: "secrets": #Kustomize & {
	resource: "cluster-secret-store": {
		apiVersion: "external-secrets.io/v1beta1"
		kind:       "ClusterSecretStore"
		metadata: name: cluster_name
		spec: provider: aws: {
			service: "SecretsManager"
			region:  "us-west-2"
		}
	}
}

kustomize: "hello": #Kustomize & {
	_app_ns: "default"
	_funcs: ["hello", "bye"]

	resource: "ingressroute-\(_domain)": {
		apiVersion: "traefik.containo.us/v1alpha1"
		kind:       "IngressRoute"
		metadata: {
			name:      _domain
			namespace: _app_ns
		}
		spec: entryPoints: ["websecure"]
		spec: routes: [{
			match: "HostRegexp(`{subdomain:[a-z0-9-]+}.default.\(_domain)`)"
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
				namespace: _app_ns
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
