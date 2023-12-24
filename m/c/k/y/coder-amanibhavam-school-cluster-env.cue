package y

res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-argo-cd": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-argo-cd"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-argo-cd"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-cert-manager": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-cert-manager"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-cert-manager"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-cilium": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-cilium"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-cilium"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-coder": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-coder"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-coder"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-descheduler": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-descheduler"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-descheduler"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-external-dns": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-external-dns"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-external-dns"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-external-secrets": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-external-secrets"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-external-secrets"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-issuer": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-issuer"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-issuer"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-karpenter": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-karpenter"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-karpenter"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-kyverno": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-kyverno"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-kyverno"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-l5d-control": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-l5d-control"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-l5d-control"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-l5d-crds": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-l5d-crds"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-l5d-crds"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-pod-identity": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-pod-identity"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-pod-identity"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-postgres-operator": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-postgres-operator"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-postgres-operator"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-reloader": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-reloader"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-reloader"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-secrets": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-secrets"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-secrets"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-spaceship": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-spaceship"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-spaceship"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-tailscale": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-tailscale"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-tailscale"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-tetragon": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-tetragon"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-tetragon"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-traefik": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-traefik"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-traefik"
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
res: application: "coder-amanibhavam-school-cluster-env": argocd: "coder-amanibhavam-school-cluster-trust-manager": {
	apiVersion: "argoproj.io/v1alpha1"
	kind:       "Application"
	metadata: {
		annotations: "argocd.argoproj.io/sync-wave": "100"
		name:      "coder-amanibhavam-school-cluster-trust-manager"
		namespace: "argocd"
	}
	spec: {
		destination: name: "coder-amanibhavam-school-cluster"
		project: "default"
		source: {
			chart:          "library/helm/coder-amanibhavam-school-cluster-trust-manager"
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