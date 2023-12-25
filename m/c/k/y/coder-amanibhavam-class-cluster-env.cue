package y

res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-argo-cd": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-argo-cd"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-argo-cd"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-cert-manager": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-cert-manager"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-cert-manager"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.106"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-cilium": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-cilium"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-cilium"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.106"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-coder": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-coder"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-coder"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.109"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-descheduler": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-descheduler"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-descheduler"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-external-dns": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-external-dns"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-external-dns"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.110"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-external-secrets": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-external-secrets"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-external-secrets"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-issuer": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-issuer"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-issuer"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.108"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-karpenter": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-karpenter"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-karpenter"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.105"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-kyverno": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-kyverno"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-kyverno"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.110"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-l5d-control": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-l5d-control"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-l5d-control"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.8"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-l5d-crds": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-l5d-crds"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-l5d-crds"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.3"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-pod-identity": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-pod-identity"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-pod-identity"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-postgres-operator": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-postgres-operator"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-postgres-operator"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.3"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-reloader": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-reloader"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-reloader"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.106"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-secrets": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-secrets"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-secrets"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-tailscale": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-tailscale"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-tailscale"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.4"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-tetragon": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-tetragon"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-tetragon"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-traefik": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-traefik"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-traefik"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.107"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-trust-manager": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-trust-manager"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-trust-manager"
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
res: application: "coder-amanibhavam-class-cluster-env": argocd: "coder-amanibhavam-class-cluster-xwing": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-class-cluster-xwing"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-class-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-class-cluster-xwing"
			repoURL:        "cache.defn.run:5000"
			targetRevision: "0.0.3"
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
