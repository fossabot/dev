package y

res: customresourcedefinition: "coder-amanibhavam-school-cluster-trust-manager": cluster: "bundles.trust.cert-manager.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.13.0"
		name: "bundles.trust.cert-manager.io"
	}
	spec: {
		group: "trust.cert-manager.io"
		names: {
			kind:     "Bundle"
			listKind: "BundleList"
			plural:   "bundles"
			singular: "bundle"
		}
		scope: "Cluster"
		versions: [{
			additionalPrinterColumns: [{
				description: "Bundle Target Key"
				jsonPath:    ".status.target.configMap.key"
				name:        "Target"
				type:        "string"
			}, {
				description: "Bundle has been synced"
				jsonPath:    ".status.conditions[?(@.type == \"Synced\")].status"
				name:        "Synced"
				type:        "string"
			}, {
				description: "Reason Bundle has Synced status"
				jsonPath:    ".status.conditions[?(@.type == \"Synced\")].reason"
				name:        "Reason"
				type:        "string"
			}, {
				description: "Timestamp Bundle was created"
				jsonPath:    ".metadata.creationTimestamp"
				name:        "Age"
				type:        "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "Desired state of the Bundle resource."
						properties: {
							sources: {
								description: "Sources is a set of references to data whose data will sync to the target."

								items: {
									description: "BundleSource is the set of sources whose data will be appended and synced to the BundleTarget in all Namespaces."

									properties: {
										configMap: {
											description: "ConfigMap is a reference to a ConfigMap's `data` key, in the trust Namespace."

											properties: {
												key: {
													description: "Key is the key of the entry in the object's `data` field to be used."

													type: "string"
												}
												name: {
													description: "Name is the name of the source object in the trust Namespace."

													type: "string"
												}
											}
											required: [
												"key",
												"name",
											]
											type: "object"
										}
										inLine: {
											description: "InLine is a simple string to append as the source data."

											type: "string"
										}
										secret: {
											description: "Secret is a reference to a Secrets's `data` key, in the trust Namespace."

											properties: {
												key: {
													description: "Key is the key of the entry in the object's `data` field to be used."

													type: "string"
												}
												name: {
													description: "Name is the name of the source object in the trust Namespace."

													type: "string"
												}
											}
											required: [
												"key",
												"name",
											]
											type: "object"
										}
										useDefaultCAs: {
											description: "UseDefaultCAs, when true, requests the default CA bundle to be used as a source. Default CAs are available if trust-manager was installed via Helm or was otherwise set up to include a package-injecting init container by using the \"--default-package-location\" flag when starting the trust-manager controller. If default CAs were not configured at start-up, any request to use the default CAs will fail. The version of the default CA package which is used for a Bundle is stored in the defaultCAPackageVersion field of the Bundle's status field."

											type: "boolean"
										}
									}
									type: "object"
								}
								type: "array"
							}
							target: {
								description: "Target is the target location in all namespaces to sync source data to."

								properties: {
									additionalFormats: {
										description: "AdditionalFormats specifies any additional formats to write to the target"

										properties: {
											jks: {
												description: "JKS requests a JKS-formatted binary trust bundle to be written to the target. The bundle is created with the hardcoded password \"changeit\"."

												properties: key: {
													description: "Key is the key of the entry in the object's `data` field to be used."

													type: "string"
												}
												required: ["key"]
												type: "object"
											}
											pkcs12: {
												description: "PKCS12 requests a PKCS12-formatted binary trust bundle to be written to the target. The bundle is created without a password."

												properties: key: {
													description: "Key is the key of the entry in the object's `data` field to be used."

													type: "string"
												}
												required: ["key"]
												type: "object"
											}
										}
										type: "object"
									}
									configMap: {
										description: "ConfigMap is the target ConfigMap in Namespaces that all Bundle source data will be synced to."

										properties: key: {
											description: "Key is the key of the entry in the object's `data` field to be used."

											type: "string"
										}
										required: ["key"]
										type: "object"
									}
									namespaceSelector: {
										description: "NamespaceSelector will, if set, only sync the target resource in Namespaces which match the selector."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels matches on the set of labels that must be present on a Namespace for the Bundle target to be synced there."

											type: "object"
										}
										type: "object"
									}
									secret: {
										description: "Secret is the target Secret that all Bundle source data will be synced to. Using Secrets as targets is only supported if enabled at trust-manager startup. By default, trust-manager has no permissions for writing to secrets and can only read secrets in the trust namespace."

										properties: key: {
											description: "Key is the key of the entry in the object's `data` field to be used."

											type: "string"
										}
										required: ["key"]
										type: "object"
									}
								}
								type: "object"
							}
						}
						required: [
							"sources",
							"target",
						]
						type: "object"
					}
					status: {
						description: "Status of the Bundle. This is set and managed automatically."
						properties: {
							conditions: {
								description: "List of status conditions to indicate the status of the Bundle. Known condition types are `Bundle`."

								items: {
									description: "BundleCondition contains condition information for a Bundle."

									properties: {
										lastTransitionTime: {
											description: "LastTransitionTime is the timestamp corresponding to the last status change of this condition."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "Message is a human readable description of the details of the last transition, complementing reason."

											type: "string"
										}
										observedGeneration: {
											description: "If set, this represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.condition[x].observedGeneration is 9, the condition is out of date with respect to the current state of the Bundle."

											format: "int64"
											type:   "integer"
										}
										reason: {
											description: "Reason is a brief machine readable explanation for the condition's last transition."

											type: "string"
										}
										status: {
											description: "Status of the condition, one of ('True', 'False', 'Unknown')."

											type: "string"
										}
										type: {
											description: "Type of the condition, known values are (`Synced`)."
											type:        "string"
										}
									}
									required: [
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
								"x-kubernetes-list-map-keys": ["type"]
								"x-kubernetes-list-type": "map"
							}
							defaultCAVersion: {
								description: "DefaultCAPackageVersion, if set and non-empty, indicates the version information which was retrieved when the set of default CAs was requested in the bundle source. This should only be set if useDefaultCAs was set to \"true\" on a source, and will be the same for the same version of a bundle with identical certificates."

								type: "string"
							}
							target: {
								description: "Target is the current Target that the Bundle is attempting or has completed syncing the source data to."

								properties: {
									additionalFormats: {
										description: "AdditionalFormats specifies any additional formats to write to the target"

										properties: {
											jks: {
												description: "JKS requests a JKS-formatted binary trust bundle to be written to the target. The bundle is created with the hardcoded password \"changeit\"."

												properties: key: {
													description: "Key is the key of the entry in the object's `data` field to be used."

													type: "string"
												}
												required: ["key"]
												type: "object"
											}
											pkcs12: {
												description: "PKCS12 requests a PKCS12-formatted binary trust bundle to be written to the target. The bundle is created without a password."

												properties: key: {
													description: "Key is the key of the entry in the object's `data` field to be used."

													type: "string"
												}
												required: ["key"]
												type: "object"
											}
										}
										type: "object"
									}
									configMap: {
										description: "ConfigMap is the target ConfigMap in Namespaces that all Bundle source data will be synced to."

										properties: key: {
											description: "Key is the key of the entry in the object's `data` field to be used."

											type: "string"
										}
										required: ["key"]
										type: "object"
									}
									namespaceSelector: {
										description: "NamespaceSelector will, if set, only sync the target resource in Namespaces which match the selector."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels matches on the set of labels that must be present on a Namespace for the Bundle target to be synced there."

											type: "object"
										}
										type: "object"
									}
									secret: {
										description: "Secret is the target Secret that all Bundle source data will be synced to. Using Secrets as targets is only supported if enabled at trust-manager startup. By default, trust-manager has no permissions for writing to secrets and can only read secrets in the trust namespace."

										properties: key: {
											description: "Key is the key of the entry in the object's `data` field to be used."

											type: "string"
										}
										required: ["key"]
										type: "object"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: serviceaccount: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager"
		namespace: "cert-manager"
	}
}
res: role: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager"
		namespace: "cert-manager"
	}
	rules: [{
		apiGroups: [""]
		resources: ["secrets"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: [
			"get",
			"create",
			"update",
			"watch",
			"list",
		]
	}]
}
res: clusterrole: "coder-amanibhavam-school-cluster-trust-manager": cluster: "trust-manager": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name: "trust-manager"
	}
	rules: [{
		apiGroups: ["trust.cert-manager.io"]
		resources: ["bundles"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["trust.cert-manager.io"]
		resources: ["bundles/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: ["trust.cert-manager.io"]
		resources: ["bundles/status"]
		verbs: ["patch"]
	}, {
		apiGroups: ["trust.cert-manager.io"]
		resources: ["bundles"]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: [
			"get",
			"list",
			"create",
			"update",
			"patch",
			"watch",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["namespaces"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}]
}
res: rolebinding: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager"
		namespace: "cert-manager"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "trust-manager"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "trust-manager"
		namespace: "cert-manager"
	}]
}
res: clusterrolebinding: "coder-amanibhavam-school-cluster-trust-manager": cluster: "trust-manager": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name: "trust-manager"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "trust-manager"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "trust-manager"
		namespace: "cert-manager"
	}]
}
res: service: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                            "trust-manager"
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager"
		namespace: "cert-manager"
	}
	spec: {
		ports: [{
			name:       "webhook"
			port:       443
			protocol:   "TCP"
			targetPort: 6443
		}]
		selector: app: "trust-manager"
		type: "ClusterIP"
	}
}
res: service: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager-metrics": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:                            "trust-manager"
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager-metrics"
		namespace: "cert-manager"
	}
	spec: {
		ports: [{
			name:       "metrics"
			port:       9402
			protocol:   "TCP"
			targetPort: 9402
		}]
		selector: app: "trust-manager"
		type: "ClusterIP"
	}
}
res: deployment: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager"
		namespace: "cert-manager"
	}
	spec: {
		replicas: 1
		selector: matchLabels: app: "trust-manager"
		template: {
			metadata: labels: app: "trust-manager"
			spec: {
				containers: [{
					args: [
						"--log-level=1",
						"--metrics-port=9402",
						"--readiness-probe-port=6060",
						"--readiness-probe-path=/readyz",
						"--trust-namespace=cert-manager",
						"--webhook-host=0.0.0.0",
						"--webhook-port=6443",
						"--webhook-certificate-dir=/tls",
						"--default-package-location=/packages/cert-manager-package-debian.json",
					]
					command: ["trust-manager"]
					image:           "quay.io/jetstack/trust-manager:v0.7.0"
					imagePullPolicy: "IfNotPresent"
					name:            "trust-manager"
					ports: [{
						containerPort: 6443
					}, {
						containerPort: 9402
					}]
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: 6060
						}
						initialDelaySeconds: 3
						periodSeconds:       7
					}
					resources: {}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/tls"
						name:      "tls"
						readOnly:  true
					}, {
						mountPath: "/packages"
						name:      "packages"
						readOnly:  true
					}]
				}]
				initContainers: [{
					args: [
						"/copyandmaybepause",
						"/debian-package",
						"/packages",
					]
					image:           "quay.io/jetstack/cert-manager-package-debian:20210119.0"
					imagePullPolicy: "IfNotPresent"
					name:            "cert-manager-package-debian"
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						seccompProfile: type: "RuntimeDefault"
					}
					volumeMounts: [{
						mountPath: "/packages"
						name:      "packages"
						readOnly:  false
					}]
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: "trust-manager"
				volumes: [{
					emptyDir: {}
					name: "packages"
				}, {
					name: "tls"
					secret: {
						defaultMode: 420
						secretName:  "trust-manager-tls"
					}
				}]
			}
		}
	}
}
res: certificate: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Certificate"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager"
		namespace: "cert-manager"
	}
	spec: {
		commonName: "trust-manager.cert-manager.svc"
		dnsNames: ["trust-manager.cert-manager.svc"]
		issuerRef: {
			group: "cert-manager.io"
			kind:  "Issuer"
			name:  "trust-manager"
		}
		revisionHistoryLimit: 1
		secretName:           "trust-manager-tls"
	}
}
res: issuer: "coder-amanibhavam-school-cluster-trust-manager": "cert-manager": "trust-manager": {
	apiVersion: "cert-manager.io/v1"
	kind:       "Issuer"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name:      "trust-manager"
		namespace: "cert-manager"
	}
	spec: selfSigned: {}
}
res: validatingwebhookconfiguration: "coder-amanibhavam-school-cluster-trust-manager": cluster: "trust-manager": {
	apiVersion: "admissionregistration.k8s.io/v1"
	kind:       "ValidatingWebhookConfiguration"
	metadata: {
		annotations: "cert-manager.io/inject-ca-from": "cert-manager/trust-manager"
		labels: {
			app:                            "trust-manager"
			"app.kubernetes.io/instance":   "trust-manager"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "trust-manager"
			"app.kubernetes.io/version":    "v0.7.0"
			"helm.sh/chart":                "trust-manager-v0.7.0"
		}
		name: "trust-manager"
	}
	webhooks: [{
		admissionReviewVersions: ["v1"]
		clientConfig: service: {
			name:      "trust-manager"
			namespace: "cert-manager"
			path:      "/validate-trust-cert-manager-io-v1alpha1-bundle"
		}
		failurePolicy: "Fail"
		name:          "trust.cert-manager.io"
		rules: [{
			apiGroups: ["trust.cert-manager.io"]
			apiVersions: ["*"]
			operations: [
				"CREATE",
				"UPDATE",
			]
			resources: ["*/*"]
		}]
		sideEffects:    "None"
		timeoutSeconds: 5
	}]
}