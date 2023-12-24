package y

res: application: "coder-amanibhavam-district1-cluster-env": argocd: "coder-amanibhavam-district1-cluster-kyverno": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-district1-cluster-kyverno"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-district1-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-district1-cluster-kyverno"
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