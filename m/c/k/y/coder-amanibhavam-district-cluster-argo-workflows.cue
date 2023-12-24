package y

res: namespace: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "argo-workflows"
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "clusterworkflowtemplates.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "clusterworkflowtemplates.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "ClusterWorkflowTemplate"
			listKind: "ClusterWorkflowTemplateList"
			plural:   "clusterworkflowtemplates"
			shortNames: [
				"clusterwftmpl",
				"cwft",
			]
			singular: "clusterworkflowtemplate"
		}
		scope: "Cluster"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "cronworkflows.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "cronworkflows.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "CronWorkflow"
			listKind: "CronWorkflowList"
			plural:   "cronworkflows"
			shortNames: [
				"cwf",
				"cronwf",
			]
			singular: "cronworkflow"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
					status: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "workflowartifactgctasks.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "workflowartifactgctasks.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "WorkflowArtifactGCTask"
			listKind: "WorkflowArtifactGCTaskList"
			plural:   "workflowartifactgctasks"
			shortNames: ["wfat"]
			singular: "workflowartifactgctask"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
					status: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "workfloweventbindings.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "workfloweventbindings.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "WorkflowEventBinding"
			listKind: "WorkflowEventBindingList"
			plural:   "workfloweventbindings"
			shortNames: ["wfeb"]
			singular: "workfloweventbinding"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "workflows.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "workflows.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "Workflow"
			listKind: "WorkflowList"
			plural:   "workflows"
			shortNames: ["wf"]
			singular: "workflow"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "Status of the workflow"
				jsonPath:    ".status.phase"
				name:        "Status"
				type:        "string"
			}, {
				description: "When the workflow was started"
				format:      "date-time"
				jsonPath:    ".status.startedAt"
				name:        "Age"
				type:        "date"
			}, {
				description: "Human readable message indicating details about why the workflow is in this condition."

				jsonPath: ".status.message"
				name:     "Message"
				type:     "string"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
					status: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "workflowtaskresults.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "workflowtaskresults.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "WorkflowTaskResult"
			listKind: "WorkflowTaskResultList"
			plural:   "workflowtaskresults"
			singular: "workflowtaskresult"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					message: type: "string"
					metadata: type: "object"
					outputs: {
						properties: {
							artifacts: {
								items: {
									properties: {
										archive: {
											properties: {
												none: type: "object"
												tar: {
													properties: compressionLevel: {
														format: "int32"
														type:   "integer"
													}
													type: "object"
												}
												zip: type: "object"
											}
											type: "object"
										}
										archiveLogs: type: "boolean"
										artifactGC: {
											properties: {
												podMetadata: {
													properties: {
														annotations: {
															additionalProperties: type: "string"
															type: "object"
														}
														labels: {
															additionalProperties: type: "string"
															type: "object"
														}
													}
													type: "object"
												}
												serviceAccountName: type: "string"
												strategy: {
													enum: [
														"",
														"OnWorkflowCompletion",
														"OnWorkflowDeletion",
														"Never",
													]
													type: "string"
												}
											}
											type: "object"
										}
										artifactory: {
											properties: {
												passwordSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												url: type: "string"
												usernameSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
											}
											required: ["url"]
											type: "object"
										}
										azure: {
											properties: {
												accountKeySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												blob: type: "string"
												container: type: "string"
												endpoint: type: "string"
												useSDKCreds: type: "boolean"
											}
											required: [
												"blob",
												"container",
												"endpoint",
											]
											type: "object"
										}
										deleted: type: "boolean"
										from: type: "string"
										fromExpression: type: "string"
										gcs: {
											properties: {
												bucket: type: "string"
												key: type: "string"
												serviceAccountKeySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
											}
											required: ["key"]
											type: "object"
										}
										git: {
											properties: {
												branch: type: "string"
												depth: {
													format: "int64"
													type:   "integer"
												}
												disableSubmodules: type: "boolean"
												fetch: {
													items: type: "string"
													type: "array"
												}
												insecureIgnoreHostKey: type: "boolean"
												passwordSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												repo: type: "string"
												revision: type: "string"
												singleBranch: type: "boolean"
												sshPrivateKeySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												usernameSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
											}
											required: ["repo"]
											type: "object"
										}
										globalName: type: "string"
										hdfs: {
											properties: {
												addresses: {
													items: type: "string"
													type: "array"
												}
												force: type: "boolean"
												hdfsUser: type: "string"
												krbCCacheSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												krbConfigConfigMap: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												krbKeytabSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												krbRealm: type: "string"
												krbServicePrincipalName: type: "string"
												krbUsername: type: "string"
												path: type: "string"
											}
											required: ["path"]
											type: "object"
										}
										http: {
											properties: {
												auth: {
													properties: {
														basicAuth: {
															properties: {
																passwordSecret: {
																	properties: {
																		key: type: "string"
																		name: type: "string"
																		optional: type: "boolean"
																	}
																	required: ["key"]
																	type: "object"
																}
																usernameSecret: {
																	properties: {
																		key: type: "string"
																		name: type: "string"
																		optional: type: "boolean"
																	}
																	required: ["key"]
																	type: "object"
																}
															}
															type: "object"
														}
														clientCert: {
															properties: {
																clientCertSecret: {
																	properties: {
																		key: type: "string"
																		name: type: "string"
																		optional: type: "boolean"
																	}
																	required: ["key"]
																	type: "object"
																}
																clientKeySecret: {
																	properties: {
																		key: type: "string"
																		name: type: "string"
																		optional: type: "boolean"
																	}
																	required: ["key"]
																	type: "object"
																}
															}
															type: "object"
														}
														oauth2: {
															properties: {
																clientIDSecret: {
																	properties: {
																		key: type: "string"
																		name: type: "string"
																		optional: type: "boolean"
																	}
																	required: ["key"]
																	type: "object"
																}
																clientSecretSecret: {
																	properties: {
																		key: type: "string"
																		name: type: "string"
																		optional: type: "boolean"
																	}
																	required: ["key"]
																	type: "object"
																}
																endpointParams: {
																	items: {
																		properties: {
																			key: type: "string"
																			value: type: "string"
																		}
																		required: ["key"]
																		type: "object"
																	}
																	type: "array"
																}
																scopes: {
																	items: type: "string"
																	type: "array"
																}
																tokenURLSecret: {
																	properties: {
																		key: type: "string"
																		name: type: "string"
																		optional: type: "boolean"
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
												headers: {
													items: {
														properties: {
															name: type: "string"
															value: type: "string"
														}
														required: [
															"name",
															"value",
														]
														type: "object"
													}
													type: "array"
												}
												url: type: "string"
											}
											required: ["url"]
											type: "object"
										}
										mode: {
											format: "int32"
											type:   "integer"
										}
										name: type: "string"
										optional: type: "boolean"
										oss: {
											properties: {
												accessKeySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												bucket: type: "string"
												createBucketIfNotPresent: type: "boolean"
												endpoint: type: "string"
												key: type: "string"
												lifecycleRule: {
													properties: {
														markDeletionAfterDays: {
															format: "int32"
															type:   "integer"
														}
														markInfrequentAccessAfterDays: {
															format: "int32"
															type:   "integer"
														}
													}
													type: "object"
												}
												secretKeySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												securityToken: type: "string"
												useSDKCreds: type: "boolean"
											}
											required: ["key"]
											type: "object"
										}
										path: type: "string"
										raw: {
											properties: data: type: "string"
											required: ["data"]
											type: "object"
										}
										recurseMode: type: "boolean"
										s3: {
											properties: {
												accessKeySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												bucket: type: "string"
												caSecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												createBucketIfNotPresent: {
													properties: objectLocking: type: "boolean"
													type: "object"
												}
												encryptionOptions: {
													properties: {
														enableEncryption: type: "boolean"
														kmsEncryptionContext: type: "string"
														kmsKeyId: type: "string"
														serverSideCustomerKeySecret: {
															properties: {
																key: type: "string"
																name: type: "string"
																optional: type: "boolean"
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												endpoint: type: "string"
												insecure: type: "boolean"
												key: type: "string"
												region: type: "string"
												roleARN: type: "string"
												secretKeySecret: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												useSDKCreds: type: "boolean"
											}
											type: "object"
										}
										subPath: type: "string"
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							exitCode: type: "string"
							parameters: {
								items: {
									properties: {
										default: type: "string"
										description: type: "string"
										enum: {
											items: type: "string"
											type: "array"
										}
										globalName: type: "string"
										name: type: "string"
										value: type: "string"
										valueFrom: {
											properties: {
												configMapKeyRef: {
													properties: {
														key: type: "string"
														name: type: "string"
														optional: type: "boolean"
													}
													required: ["key"]
													type: "object"
												}
												default: type: "string"
												event: type: "string"
												expression: type: "string"
												jqFilter: type: "string"
												jsonPath: type: "string"
												parameter: type: "string"
												path: type: "string"
												supplied: type: "object"
											}
											type: "object"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							result: type: "string"
						}
						type: "object"
					}
					phase: type: "string"
					progress: type: "string"
				}
				required: ["metadata"]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "workflowtasksets.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "workflowtasksets.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "WorkflowTaskSet"
			listKind: "WorkflowTaskSetList"
			plural:   "workflowtasksets"
			shortNames: ["wfts"]
			singular: "workflowtaskset"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
					status: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "workflowtemplates.argoproj.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		name: "workflowtemplates.argoproj.io"
	}
	spec: {
		group: "argoproj.io"
		names: {
			kind:     "WorkflowTemplate"
			listKind: "WorkflowTemplateList"
			plural:   "workflowtemplates"
			shortNames: ["wftmpl"]
			singular: "workflowtemplate"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: type: "string"
					kind: type: "string"
					metadata: type: "object"
					spec: {
						type:                                   "object"
						"x-kubernetes-map-type":                "atomic"
						"x-kubernetes-preserve-unknown-fields": true
					}
				}
				required: [
					"metadata",
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: serviceaccount: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-server": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "server"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-server"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-server"
		namespace: "argo-workflows"
	}
}
res: serviceaccount: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-workflow-controller": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-workflow-controller"
		namespace: "argo-workflows"
	}
}
res: role: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-workflow": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-workflow"
		namespace: "argo-workflows"
	}
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"get",
			"watch",
			"patch",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/log"]
		verbs: [
			"get",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: ["argoproj.io"]
		resources: ["workflowtaskresults"]
		verbs: [
			"create",
			"patch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"workflowtasksets",
			"workflowartifactgctasks",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"workflowtasksets/status",
			"workflowartifactgctasks/status",
		]
		verbs: ["patch"]
	}]
}
res: role: "coder-amanibhavam-district-cluster-argo-workflows": default: "argo-workflows-workflow": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "Role"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-workflow"
		namespace: "default"
	}
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"get",
			"watch",
			"patch",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/log"]
		verbs: [
			"get",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: ["argoproj.io"]
		resources: ["workflowtaskresults"]
		verbs: [
			"create",
			"patch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"workflowtasksets",
			"workflowartifactgctasks",
		]
		verbs: [
			"list",
			"watch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"workflowtasksets/status",
			"workflowartifactgctasks/status",
		]
		verbs: ["patch"]
	}]
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-admin": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":                  "server"
			"app.kubernetes.io/instance":                   "argo-workflows"
			"app.kubernetes.io/managed-by":                 "Helm"
			"app.kubernetes.io/name":                       "argo-workflows-server"
			"app.kubernetes.io/part-of":                    "argo-workflows"
			"helm.sh/chart":                                "argo-workflows-0.40.3"
			"rbac.authorization.k8s.io/aggregate-to-admin": "true"
		}
		name: "argo-workflows-admin"
	}
	rules: [{
		apiGroups: ["argoproj.io"]
		resources: [
			"workflows",
			"workflows/finalizers",
			"workfloweventbindings",
			"workfloweventbindings/finalizers",
			"workflowtemplates",
			"workflowtemplates/finalizers",
			"cronworkflows",
			"cronworkflows/finalizers",
			"clusterworkflowtemplates",
			"clusterworkflowtemplates/finalizers",
			"workflowtasksets",
			"workflowtasksets/finalizers",
			"workflowtaskresults",
			"workflowtaskresults/finalizers",
			"workflowartifactgctasks",
			"workflowartifactgctasks/finalizers",
		]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}]
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-edit": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":                 "server"
			"app.kubernetes.io/instance":                  "argo-workflows"
			"app.kubernetes.io/managed-by":                "Helm"
			"app.kubernetes.io/name":                      "argo-workflows-server"
			"app.kubernetes.io/part-of":                   "argo-workflows"
			"helm.sh/chart":                               "argo-workflows-0.40.3"
			"rbac.authorization.k8s.io/aggregate-to-edit": "true"
		}
		name: "argo-workflows-edit"
	}
	rules: [{
		apiGroups: ["argoproj.io"]
		resources: [
			"workflows",
			"workflows/finalizers",
			"workfloweventbindings",
			"workfloweventbindings/finalizers",
			"workflowtemplates",
			"workflowtemplates/finalizers",
			"cronworkflows",
			"cronworkflows/finalizers",
			"clusterworkflowtemplates",
			"clusterworkflowtemplates/finalizers",
			"workflowtasksets",
			"workflowtasksets/finalizers",
			"workflowtaskresults",
			"workflowtaskresults/finalizers",
			"workflowartifactgctasks",
			"workflowartifactgctasks/finalizers",
		]
		verbs: [
			"create",
			"delete",
			"deletecollection",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}]
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-server": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "server"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-server"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-server"
	}
	rules: [{
		apiGroups: [""]
		resources: [
			"configmaps",
			"events",
		]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"get",
			"list",
			"watch",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/log"]
		verbs: [
			"get",
			"list",
		]
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"watch",
			"create",
			"patch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"eventsources",
			"sensors",
			"workflows",
			"workfloweventbindings",
			"workflowtemplates",
			"cronworkflows",
		]
		verbs: [
			"create",
			"get",
			"list",
			"watch",
			"update",
			"patch",
			"delete",
		]
	}]
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-server-cluster-template": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "server"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-server"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-server-cluster-template"
	}
	rules: [{
		apiGroups: ["argoproj.io"]
		resources: ["clusterworkflowtemplates"]
		verbs: [
			"get",
			"list",
			"watch",
			"create",
			"update",
			"patch",
			"delete",
		]
	}]
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-view": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":                 "workflow-controller"
			"app.kubernetes.io/instance":                  "argo-workflows"
			"app.kubernetes.io/managed-by":                "Helm"
			"app.kubernetes.io/name":                      "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":                   "argo-workflows"
			"helm.sh/chart":                               "argo-workflows-0.40.3"
			"rbac.authorization.k8s.io/aggregate-to-view": "true"
		}
		name: "argo-workflows-view"
	}
	rules: [{
		apiGroups: ["argoproj.io"]
		resources: [
			"workflows",
			"workflows/finalizers",
			"workfloweventbindings",
			"workfloweventbindings/finalizers",
			"workflowtemplates",
			"workflowtemplates/finalizers",
			"cronworkflows",
			"cronworkflows/finalizers",
			"clusterworkflowtemplates",
			"clusterworkflowtemplates/finalizers",
			"workflowtasksets",
			"workflowtasksets/finalizers",
			"workflowtaskresults",
			"workflowtaskresults/finalizers",
			"workflowartifactgctasks",
			"workflowartifactgctasks/finalizers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-workflow-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-workflow-controller"
	}
	rules: [{
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"create",
			"get",
			"list",
			"watch",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: [
			"get",
			"watch",
			"list",
		]
	}, {
		apiGroups: [""]
		resources: [
			"persistentvolumeclaims",
			"persistentvolumeclaims/finalizers",
		]
		verbs: [
			"create",
			"update",
			"delete",
			"get",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"workflows",
			"workflows/finalizers",
			"workflowtasksets",
			"workflowtasksets/finalizers",
			"workflowartifactgctasks",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
			"patch",
			"delete",
			"create",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"workflowtemplates",
			"workflowtemplates/finalizers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"workflowtaskresults",
			"workflowtaskresults/finalizers",
		]
		verbs: [
			"list",
			"watch",
			"deletecollection",
		]
	}, {
		apiGroups: ["argoproj.io"]
		resources: [
			"cronworkflows",
			"cronworkflows/finalizers",
		]
		verbs: [
			"get",
			"list",
			"watch",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"patch",
		]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts"]
		verbs: [
			"get",
			"list",
		]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets"]
		verbs: [
			"create",
			"get",
			"delete",
		]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["create"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resourceNames: [
			"workflow-controller",
			"workflow-controller-lease",
		]
		resources: ["leases"]
		verbs: [
			"get",
			"watch",
			"update",
			"patch",
			"delete",
		]
	}, {
		apiGroups: [""]
		resourceNames: ["argo-workflows-agent-ca-certificates"]
		resources: ["secrets"]
		verbs: ["get"]
	}]
}
res: clusterrole: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-workflow-controller-cluster-template": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-workflow-controller-cluster-template"
	}
	rules: [{
		apiGroups: ["argoproj.io"]
		resources: [
			"clusterworkflowtemplates",
			"clusterworkflowtemplates/finalizers",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}]
}
res: rolebinding: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-workflow": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-workflow"
		namespace: "argo-workflows"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "argo-workflows-workflow"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argo-workflow"
		namespace: "argo-workflows"
	}]
}
res: rolebinding: "coder-amanibhavam-district-cluster-argo-workflows": default: "argo-workflows-workflow": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "RoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-workflow"
		namespace: "default"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "Role"
		name:     "argo-workflows-workflow"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argo-workflow"
		namespace: "default"
	}]
}
res: clusterrolebinding: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-server": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "server"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-server"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-server"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "argo-workflows-server"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argo-workflows-server"
		namespace: "argo-workflows"
	}]
}
res: clusterrolebinding: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-server-cluster-template": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "server"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-server"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-server-cluster-template"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "argo-workflows-server-cluster-template"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argo-workflows-server"
		namespace: "argo-workflows"
	}]
}
res: clusterrolebinding: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-workflow-controller": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-workflow-controller"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "argo-workflows-workflow-controller"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argo-workflows-workflow-controller"
		namespace: "argo-workflows"
	}]
}
res: clusterrolebinding: "coder-amanibhavam-district-cluster-argo-workflows": cluster: "argo-workflows-workflow-controller-cluster-template": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name: "argo-workflows-workflow-controller-cluster-template"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "argo-workflows-workflow-controller-cluster-template"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "argo-workflows-workflow-controller"
		namespace: "argo-workflows"
	}]
}
res: configmap: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-workflow-controller-configmap": {
	apiVersion: "v1"
	data: config: """
		nodeEvents:
		  enabled: true

		"""

	kind: "ConfigMap"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-cm"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-workflow-controller-configmap"
		namespace: "argo-workflows"
	}
}
res: service: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-server": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "server"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-server"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"app.kubernetes.io/version":    "v3.5.2"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-server"
		namespace: "argo-workflows"
	}
	spec: {
		ports: [{
			port:       2746
			targetPort: 2746
		}]
		selector: {
			"app.kubernetes.io/instance": "argo-workflows"
			"app.kubernetes.io/name":     "argo-workflows-server"
		}
		sessionAffinity: "None"
		type:            "ClusterIP"
	}
}
res: deployment: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-server": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "server"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-server"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"app.kubernetes.io/version":    "v3.5.2"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-server"
		namespace: "argo-workflows"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			"app.kubernetes.io/instance": "argo-workflows"
			"app.kubernetes.io/name":     "argo-workflows-server"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/component":  "server"
				"app.kubernetes.io/instance":   "argo-workflows"
				"app.kubernetes.io/managed-by": "Helm"
				"app.kubernetes.io/name":       "argo-workflows-server"
				"app.kubernetes.io/part-of":    "argo-workflows"
				"app.kubernetes.io/version":    "v3.5.2"
				"helm.sh/chart":                "argo-workflows-0.40.3"
			}
			spec: {
				containers: [{
					args: [
						"server",
						"--configmap=argo-workflows-workflow-controller-configmap",
						"--secure=false",
						"--loglevel",
						"info",
						"--gloglevel",
						"0",
						"--log-format",
						"text",
					]
					env: [{
						name:  "IN_CLUSTER"
						value: "true"
					}, {
						name: "ARGO_NAMESPACE"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "metadata.namespace"
						}
					}, {
						name:  "BASE_HREF"
						value: "/"
					}]
					image:           "quay.io/argoproj/argocli:v3.5.2"
					imagePullPolicy: "Always"
					name:            "argo-server"
					ports: [{
						containerPort: 2746
						name:          "web"
					}]
					readinessProbe: {
						httpGet: {
							path:   "/"
							port:   2746
							scheme: "HTTP"
						}
						initialDelaySeconds: 10
						periodSeconds:       20
					}
					resources: {}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: false
						runAsNonRoot:           true
					}
					volumeMounts: [{
						mountPath: "/tmp"
						name:      "tmp"
					}]
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: "argo-workflows-server"
				volumes: [{
					emptyDir: {}
					name: "tmp"
				}]
			}
		}
	}
}
res: deployment: "coder-amanibhavam-district-cluster-argo-workflows": "argo-workflows": "argo-workflows-workflow-controller": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/component":  "workflow-controller"
			"app.kubernetes.io/instance":   "argo-workflows"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
			"app.kubernetes.io/part-of":    "argo-workflows"
			"app.kubernetes.io/version":    "v3.5.2"
			"helm.sh/chart":                "argo-workflows-0.40.3"
		}
		name:      "argo-workflows-workflow-controller"
		namespace: "argo-workflows"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			"app.kubernetes.io/instance": "argo-workflows"
			"app.kubernetes.io/name":     "argo-workflows-workflow-controller"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/component":  "workflow-controller"
				"app.kubernetes.io/instance":   "argo-workflows"
				"app.kubernetes.io/managed-by": "Helm"
				"app.kubernetes.io/name":       "argo-workflows-workflow-controller"
				"app.kubernetes.io/part-of":    "argo-workflows"
				"app.kubernetes.io/version":    "v3.5.2"
				"helm.sh/chart":                "argo-workflows-0.40.3"
			}
			spec: {
				containers: [{
					args: [
						"--configmap",
						"argo-workflows-workflow-controller-configmap",
						"--executor-image",
						"quay.io/argoproj/argoexec:v3.5.2",
						"--loglevel",
						"info",
						"--gloglevel",
						"0",
						"--log-format",
						"text",
					]
					command: ["workflow-controller"]
					env: [{
						name: "ARGO_NAMESPACE"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "metadata.namespace"
						}
					}, {
						name: "LEADER_ELECTION_IDENTITY"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "metadata.name"
						}
					}]
					image:           "quay.io/argoproj/workflow-controller:v3.5.2"
					imagePullPolicy: "Always"
					livenessProbe: {
						failureThreshold: 3
						httpGet: {
							path: "/healthz"
							port: 6060
						}
						initialDelaySeconds: 90
						periodSeconds:       60
						timeoutSeconds:      30
					}
					name: "controller"
					ports: [{
						containerPort: 9090
						name:          "metrics"
					}, {
						containerPort: 6060
					}]
					resources: {}
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
					}
				}]
				nodeSelector: "kubernetes.io/os": "linux"
				serviceAccountName: "argo-workflows-workflow-controller"
			}
		}
	}
}
