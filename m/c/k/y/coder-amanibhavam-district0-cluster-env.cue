package y

res: application: "coder-amanibhavam-district0-cluster-env": argocd: "coder-amanibhavam-district0-cluster-argo-cd": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-district0-cluster-argo-cd"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-district0-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-district0-cluster-argo-cd"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.104"
		}
		syncPolicy: {
			automated: {
				prune:    true
				selfHeal: true
			}
			syncOptions: []
		}
	}
}
res: application: "coder-amanibhavam-district0-cluster-env": argocd: "coder-amanibhavam-district0-cluster-external-secrets": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-district0-cluster-external-secrets"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-district0-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-district0-cluster-external-secrets"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.104"
		}
		syncPolicy: {
			automated: {
				prune:    true
				selfHeal: true
			}
			syncOptions: []
		}
	}
}
res: application: "coder-amanibhavam-district0-cluster-env": argocd: "coder-amanibhavam-district0-cluster-kyverno": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-district0-cluster-kyverno"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-district0-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-district0-cluster-kyverno"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.109"
		}
		syncPolicy: {
			automated: {
				prune:    true
				selfHeal: true
			}
			syncOptions: ["ServerSideApply=true"]
		}
	}
}
res: application: "coder-amanibhavam-district0-cluster-env": argocd: "coder-amanibhavam-district0-cluster-postgres-operator": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-district0-cluster-postgres-operator"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-district0-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-district0-cluster-postgres-operator"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.103"
		}
		syncPolicy: {
			automated: {
				prune:    true
				selfHeal: true
			}
			syncOptions: []
		}
	}
}
res: application: "coder-amanibhavam-district0-cluster-env": argocd: "coder-amanibhavam-district0-cluster-secrets": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-district0-cluster-secrets"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-district0-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-district0-cluster-secrets"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.103"
		}
		syncPolicy: {
			automated: {
				prune:    true
				selfHeal: true
			}
			syncOptions: []
		}
	}
}