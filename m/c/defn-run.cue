package c

import (
	"strings"
)

k3s_bootstrap: {
	// secrets
	"cert-manager": {}
	"trust-manager": {}
	"pod-identity": {}
	"external-secrets": {}

	// config
	"secrets": {}
	"issuer": {}

	// management
	"karpenter": {}
	"cilium": {}
	"tetragon": {}
	"kyverno": {
		app_sync_options: ["ServerSideApply=true"]
	}

	// traffic
	"l5d-crds": {}
	//"l5d-control": {}

	// deploy
	"argo-cd": {}
}

teacher: {
	bootstrap: {
		[NAME=string]: {
			app_repo: "coder-amanibhavam-district.tail3884f.ts.net:5000"
			app_type: "chart"
			app_def:  "library/helm/coder-\(class.handle)-\(class.env)-cluster-\(NAME)"
		}
	}
}

class: {
	handle:     string
	env:        string
	parent_env: string

	cluster_name: "coder-\(handle)-\(env)"
	name_suffix:  "."

	domain_zone: "defn.run"
	domain_name: "\(parent_env).\(handle).\(domain_zone)"
	domain_slug: "\(parent_env)-\(handle)-\(strings.Replace(domain_zone, ".", "-", -1))"

	secrets_region:   "us-west-2"
	#issuer:          "zerossl-production"
	issuer:           "letsencrypt-production"
	cloudflare_email: "cloudflare@defn.us"

	discovery_url: "https://\(cluster_name).\(infra_tailscale_domain)"
	discovery: {
		issuer:                 discovery_url
		jwks_uri:               "\(discovery_url)/openid/.well-known/jwks.json"
		authorization_endpoint: "urn:kubernetes:programmatic_authorization"
		response_types_supported: [
			"id_token",
		]
		subject_types_supported: [
			"public",
		]
		id_token_signing_alg_values_supported: [
			"RS256",
		]
		claims_supported: [
			"sub",
			"iss",
		]
	}

	infra_account_id:       "510430971399"
	infra_k3s_version:      "rancher/k3s:v1.27.9-k3s1"
	infra_tailscale_domain: "tail3884f.ts.net"

	infra_cilium_name: cluster_name

	bootstrap: teacher.bootstrap
}

kustomize: "hello": #Kustomize & {
	#app_ns: "default"
	#funcs: ["hello", "bye"]

	cluster: #Cluster

	resource: "ingressroute-\(cluster.domain_name)": {
		apiVersion: "traefik.containo.us/v1alpha1"
		kind:       "IngressRoute"
		metadata: {
			name:      cluster.domain_name
			namespace: #app_ns
		}
		spec: entryPoints: ["websecure"]
		spec: routes: [{
			match: "HostRegexp(`{subdomain:[a-z0-9-]+}.default.\(cluster.domain_name)`)"
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

	for f in #funcs {
		resource: "kservice-\(f)": {
			apiVersion: "serving.knative.dev/v1"
			kind:       "Service"
			metadata: {
				//labels: "networking.knative.dev/visibility": "cluster-local"
				name:      f
				namespace: #app_ns
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
