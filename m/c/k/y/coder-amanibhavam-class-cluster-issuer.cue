package y

res: externalsecret: "coder-amanibhavam-class-cluster-issuer": "cert-manager": "letsencrypt-production": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "letsencrypt-production"
		namespace: "cert-manager"
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
			name:           "letsencrypt-production"
		}
	}
}
res: externalsecret: "coder-amanibhavam-class-cluster-issuer": "cert-manager": "letsencrypt-staging": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "letsencrypt-staging"
		namespace: "cert-manager"
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
			name:           "letsencrypt-staging"
		}
	}
}
res: externalsecret: "coder-amanibhavam-class-cluster-issuer": "cert-manager": "zerossl-production": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "zerossl-production"
		namespace: "cert-manager"
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
			name:           "zerossl-production"
		}
	}
}
res: clusterpolicy: "coder-amanibhavam-class-cluster-issuer": cluster: "letsencrypt-production-clusterissuer": {
	apiVersion: "kyverno.io/v1"
	kind:       "ClusterPolicy"
	metadata: name: "letsencrypt-production-clusterissuer"
	spec: {
		generateExistingOnPolicyUpdate: true
		rules: [{
			generate: {
				apiVersion: "cert-manager.io/v1"
				data: spec: acme: {
					email: "{{request.object.data.zerossl_email | base64_decode(@)}}"
					privateKeySecretRef: name: "letsencrypt-production-acme"
					server: "https://acme-v02.api.letsencrypt.org/directory"
					solvers: [{
						dns01: cloudflare: {
							apiTokenSecretRef: {
								key:  "cloudflare_api_token"
								name: "letsencrypt-production"
							}
							email: "{{request.object.data.cloudflare_email | base64_decode(@)}}"
						}
						selector: {}
					}]
				}
				kind:        "ClusterIssuer"
				name:        "letsencrypt-production"
				synchronize: true
			}
			match: any: [{
				resources: {
					kinds: ["Secret"]
					names: ["letsencrypt-production"]
					namespaces: ["cert-manager"]
				}
			}]
			name: "create-cluster-issuer"
		}]
	}
}
res: clusterpolicy: "coder-amanibhavam-class-cluster-issuer": cluster: "letsencrypt-staging-clusterissuer": {
	apiVersion: "kyverno.io/v1"
	kind:       "ClusterPolicy"
	metadata: name: "letsencrypt-staging-clusterissuer"
	spec: {
		generateExistingOnPolicyUpdate: true
		rules: [{
			generate: {
				apiVersion: "cert-manager.io/v1"
				data: spec: acme: {
					email: "{{request.object.data.zerossl_email | base64_decode(@)}}"
					privateKeySecretRef: name: "letsencrypt-staging-acme"
					server: "https://acme-staging-v02.api.letsencrypt.org/directory"
					solvers: [{
						dns01: cloudflare: {
							apiTokenSecretRef: {
								key:  "cloudflare_api_token"
								name: "letsencrypt-staging"
							}
							email: "{{request.object.data.cloudflare_email | base64_decode(@)}}"
						}
						selector: {}
					}]
				}
				kind:        "ClusterIssuer"
				name:        "letsencrypt-staging"
				synchronize: true
			}
			match: any: [{
				resources: {
					kinds: ["Secret"]
					names: ["letsencrypt-staging"]
					namespaces: ["cert-manager"]
				}
			}]
			name: "create-cluster-issuer"
		}]
	}
}
res: clusterpolicy: "coder-amanibhavam-class-cluster-issuer": cluster: "zerossl-production-clusterissuer": {
	apiVersion: "kyverno.io/v1"
	kind:       "ClusterPolicy"
	metadata: name: "zerossl-production-clusterissuer"
	spec: {
		generateExistingOnPolicyUpdate: true
		rules: [{
			generate: {
				apiVersion: "cert-manager.io/v1"
				data: spec: acme: {
					email: "{{request.object.data.zerossl_email | base64_decode(@)}}"
					externalAccountBinding: {
						keyID: "{{request.object.data.zerossl_eab_kid | base64_decode(@)}}"
						keySecretRef: {
							key:  "zerossl_eab_hmac"
							name: "zerossl-production"
						}
					}
					privateKeySecretRef: name: "zerossl-production-acme"
					server: "https://acme.zerossl.com/v2/DV90"
					solvers: [{
						dns01: cloudflare: {
							apiTokenSecretRef: {
								key:  "cloudflare_api_token"
								name: "zerossl-production"
							}
							email: "{{request.object.data.cloudflare_email | base64_decode(@)}}"
						}
						selector: {}
					}]
				}
				kind:        "ClusterIssuer"
				name:        "zerossl-production"
				synchronize: true
			}
			match: any: [{
				resources: {
					kinds: ["Secret"]
					names: ["zerossl-production"]
					namespaces: ["cert-manager"]
				}
			}]
			name: "create-cluster-issuer"
		}]
	}
}