package y

res: namespace: "coder-amanibhavam-district-cluster-tfo": cluster: "tf-system": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "tf-system"
}
res: customresourcedefinition: "coder-amanibhavam-district-cluster-tfo": cluster: "terraforms.tf.galleybytes.com": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.9.2"
		name:              "terraforms.tf.galleybytes.com"
	}
	spec: {
		group: "tf.galleybytes.com"
		names: {
			kind:     "Terraform"
			listKind: "TerraformList"
			plural:   "terraforms"
			shortNames: ["tf"]
			singular: "terraform"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "Terraform is the Schema for the terraforms API"
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
						description: "TerraformSpec defines the desired state of Terraform"
						properties: {
							backend: {
								description: """
		Backend is mandatory terraform backend configuration. Must use a valid terraform backend block. For more information see https://www.terraform.io/language/settings/backends/configuration 
		 Example usage of the kubernetes cluster as a backend: 
		 ```hcl terraform { backend \"kubernetes\" { secret_suffix     = \"all-task-types\" namespace         = \"default\" in_cluster_config = true } } ``` 
		 Example of a remote backend: 
		 ```hcl terraform { backend \"remote\" { organization = \"example_corp\" workspaces { name = \"my-app-prod\" } } } ``` 
		 Usage of the kubernetes backend is only available as of terraform v0.13+.
		"""

								type: "string"
							}
							credentials: {
								description: "Credentials is an array of credentials generally used for Terraform providers"

								items: {
									description: "Credentials are used for adding credentials for terraform providers. For example, in AWS, the AWS Terraform Provider uses the default credential chain of the AWS SDK, one of which are environment variables (eg AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY)"

									properties: {
										aws: {
											description: "AWSCredentials contains the different methods to load AWS credentials for the Terraform AWS Provider. If using AWS_ACCESS_KEY_ID and/or environment variables for credentials, use fromEnvs."

											properties: {
												irsa: {
													description: """
		IRSA requires the irsa role-arn as the string input. This will create a serice account named tf-<resource-name>. In order for the pod to be able to use this role, the \"Trusted Entity\" of the IAM role must allow this serice account name and namespace. 
		 Using a TrustEntity policy that includes \"StringEquals\" setting it as the serivce account name is the most secure way to use IRSA. 
		 However, for a reusable policy consider \"StringLike\" with a few wildcards to make the irsa role usable by pods created by terraform-operator. The example below is pretty liberal, but will work for any pod created by the terraform-operator. 
		 ```json { \"Version\": \"2012-10-17\", \"Statement\": [ { \"Effect\": \"Allow\", \"Principal\": { \"Federated\": \"${OIDC_ARN}\" }, \"Action\": \"sts:AssumeRoleWithWebIdentity\", \"Condition\": { \"StringLike\": { \"${OIDC_URL}:sub\": \"system:serviceaccount:*:tf-*\" } } } ] } ``` 
		 <note>This option is just a specialized version of Credentials.ServiceAccountAnnotations and will be a candidate of removal in the future.</note>
		"""

													type: "string"
												}
												kiam: {
													description: """
		KIAM requires the kiam role-name as the string input. This will add the correct annotation to the terraform execution pod 
		 <note>This option is just a specialized version of Credentials.ServiceAccountAnnotations and will be a candidate of removal in the future.</note>
		"""

													type: "string"
												}
											}
											type: "object"
										}
										secretNameRef: {
											description: "SecretNameRef will load environment variables into the terraform runner from a kubernetes secret"

											properties: {
												key: {
													description: "Key of the secret"
													type:        "string"
												}
												name: {
													description: "Name of the secret"
													type:        "string"
												}
												namespace: {
													description: "Namespace of the secret; Defaults to namespace of the tf resource"

													type: "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										serviceAccountAnnotations: {
											additionalProperties: type: "string"
											description: "ServiceAccountAnnotations allows the service account to be annotated with cloud IAM roles such as Workload Identity on GCP"

											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							ignoreDelete: {
								description: "IgnoreDelete will bypass the finalization process and remove the tf resource without running any delete jobs."

								type: "boolean"
							}
							images: {
								description: "Images describes the container images used by task classes."
								properties: {
									script: {
										description: "Script task type container image definition"
										properties: {
											image: {
												description: "The container image from the registry; tags must be omitted"

												type: "string"
											}
											imagePullPolicy: {
												description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"

												type: "string"
											}
										}
										required: ["image"]
										type: "object"
									}
									setup: {
										description: "Setup task type container image definition"
										properties: {
											image: {
												description: "The container image from the registry; tags must be omitted"

												type: "string"
											}
											imagePullPolicy: {
												description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"

												type: "string"
											}
										}
										required: ["image"]
										type: "object"
									}
									terraform: {
										description: "Terraform task type container image definition"
										properties: {
											image: {
												description: "The container image from the registry; tags must be omitted"

												type: "string"
											}
											imagePullPolicy: {
												description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"

												type: "string"
											}
										}
										required: ["image"]
										type: "object"
									}
								}
								type: "object"
							}
							keepCompletedPods: {
								description: "KeepCompletedPods when true will keep completed pods. Default is false and completed pods are removed."

								type: "boolean"
							}
							keepLatestPodsOnly: {
								description: "KeepLatestPodsOnly when true will keep only the pods that match the current generation of the terraform k8s-resource. This overrides the behavior of `keepCompletedPods`."

								type: "boolean"
							}
							outputsSecret: {
								description: "OutputsSecret will create a secret with the outputs from the module. All outputs from the module will be written to the secret unless the user defines \"outputsToInclude\" or \"outputsToOmit\"."

								type: "string"
							}
							outputsToInclude: {
								description: "OutputsToInclude is a whitelist of outputs to write when writing the outputs to kubernetes."

								items: type: "string"
								type: "array"
							}
							outputsToOmit: {
								description: "OutputsToOmit is a blacklist of outputs to omit when writing the outputs to kubernetes."

								items: type: "string"
								type: "array"
							}
							persistentVolumeSize: {
								anyOf: [{
									type: "integer"
								}, {
									type: "string"
								}]
								description: "PersistentVolumeSize define the size of the disk used to store terraform run data. If not defined, a default of \"2Gi\" is used."

								pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
								"x-kubernetes-int-or-string": true
							}
							plugins: {
								additionalProperties: {
									description: "Plugin Define additional pods to run during a workflow"
									properties: {
										image: {
											description: "The container image from the registry; tags must be omitted"

											type: "string"
										}
										imagePullPolicy: {
											description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"

											type: "string"
										}
										must: {
											description: """
		Must is short for \"must succeed to generate sidecar spec\". Generation of spec does not guarantee correctness. Must will only be applied to sidecars. 
		 If must is false and the sidecar spec fails to generate, the sidecar addition will be omitted.
		"""

											type: "boolean"
										}
										task: {
											description: "Task is the second part of a two-part selector of when the plugin gets run in the workflow. This should correspond to one of the tfo task names."

											type: "string"
										}
										when: {
											description: """
		When is a keyword of a two-part selector of when the plugin gets run in the workflow. The value must be one of 
		 - <code>At</code> to run at the same time as the defined task 
		 - <code>After</code> to run after the defined task has completed. 
		 - <code>Sidecar</code> to run as a sidecar for the given task. Since sidecars run in the same pod as a \"main workflow\" task, failed sidecars will cause a failure in the workflow.
		"""

											type: "string"
										}
									}
									required: [
										"image",
										"task",
										"when",
									]
									type: "object"
								}
								description: """
		Plugins are tasks that run during a workflow but are not part of the main workflow. Plugins can be treated as just another task, however, plugins do not have completion or failure detection. 
		 Example definition of a plugin: 
		 ```yaml plugins: monitor: image: ghcr.io/galleybytes/monitor:latest imagePullPolicy: IfNotPresent when: After task: setup ``` 
		 The above plugin task will run after the setup task has completed. 
		 Alternatively, a plugin can be triggered to start at the same time of another task. For example: 
		 ```yaml plugins: monitor: image: ghcr.io/galleybytes/monitor:latest imagePullPolicy: IfNotPresent when: At task: setup ``` 
		 Each plugin is run once per generation. Plugins that are older than the current generation are automatically reaped.
		"""

								type: "object"
							}
							requireApproval: {
								description: """
		RequireApproval will place a hold after completing a plan that prevents the workflow from continuing. However, the implementation of the hold takes place in the tf.sh script. 
		 (See https://github.com/GalleyBytes/terraform-operator-tasks/blob/master/tf.sh) 
		 Depending on the script that executes during the workflow, this field may be ignored if not implemented by the user properly. To approve a workflow using the official galleybytes implementation, a file needs to be placed on the workflow's persistent-volume: 
		 - <code>$TFO_GENERATION_PATH/\\\\_approved\\\\_\\\\<uuid-of-plan-pod></code> - to approve the workflow 
		 - <code>$TFO_GENERATION_PATH/\\\\_canceled\\\\_\\\\<uuid-of-plan-pod></code> - to deny and cancel the workflow 
		 Deleting the plan that is holding will spawn a new plan and a new approval will be required.
		"""

								type: "boolean"
							}
							scmAuthMethods: {
								description: "SCMAuthMethods define multiple SCMs that require tokens/keys"
								items: {
									description: "SCMAuthMethod definition of SCMs that require tokens/keys"
									properties: {
										git: {
											description: "Git configuration options for auth methods of git"
											properties: {
												https: {
													description: "GitHTTPS configures the setup for git over https using tokens. Proxy is not supported in the terraform job pod at this moment TODO HTTPS Proxy support"

													properties: {
														requireProxy: type: "boolean"
														tokenSecretRef: {
															description: "TokenSecretRef defines the token or password that can be used to log into a system (eg git)"

															properties: {
																key: {
																	description: "Key in the secret ref. Default to `token`"
																	type:        "string"
																}
																lockSecretDeletion: {
																	description: "Set finalizer from controller on the secret to prevent delete flow breaking Works only with spec.ignoreDelete = true"

																	type: "boolean"
																}
																name: {
																	description: "Name the secret name that has the token or password"

																	type: "string"
																}
																namespace: {
																	description: "Namespace of the secret; Default is the namespace of the terraform resource"

																	type: "string"
																}
															}
															required: ["name"]
															type: "object"
														}
													}
													required: ["tokenSecretRef"]
													type: "object"
												}
												ssh: {
													description: "GitSSH configurs the setup for git over ssh with optional proxy"

													properties: {
														requireProxy: type: "boolean"
														sshKeySecretRef: {
															description: "SSHKeySecretRef defines the secret where the SSH key (for the proxy, git, etc) is stored"

															properties: {
																key: {
																	description: "Key in the secret ref. Default to `id_rsa`"
																	type:        "string"
																}
																lockSecretDeletion: {
																	description: "Set finalizer from controller on the secret to prevent delete flow breaking. Works only with `spec.ignoreDelete = true`."

																	type: "boolean"
																}
																name: {
																	description: "Name the secret name that has the SSH key"

																	type: "string"
																}
																namespace: {
																	description: "Namespace of the secret; Default is the namespace of the terraform resource"

																	type: "string"
																}
															}
															required: ["name"]
															type: "object"
														}
													}
													required: ["sshKeySecretRef"]
													type: "object"
												}
											}
											type: "object"
										}
										host: type: "string"
									}
									required: ["host"]
									type: "object"
								}
								type: "array"
							}
							serviceAccount: {
								description: "ServiceAccount use a specific kubernetes ServiceAccount for running the create + destroy pods. If not specified we create a new ServiceAccount per Terraform"

								type: "string"
							}
							setup: {
								description: "Setup is configuration generally used once in the setup task"

								properties: {
									cleanupDisk: {
										description: "CleanupDisk will clear out previous terraform run data from the persistent volume."

										type: "boolean"
									}
									resourceDownloads: {
										description: "ResourceDownloads defines other files to download into the module directory that can be used by the terraform workflow runners. The `tfvar` type will also be fetched by the `exportRepo` option (if defined) to aggregate the set of tfvars to save to an scm system."

										items: {
											description: "ResourceDownload (formerly SrcOpts) defines a resource to fetch using one of the configured protocols: ssh|http|https (eg git::SSH or git::HTTPS)"

											properties: {
												address: {
													description: "Address defines the source address resources to fetch."

													type: "string"
												}
												path: {
													description: "Path will download the resources into this path which is relative to the main module directory."

													type: "string"
												}
												useAsVar: {
													description: "UseAsVar will add the file as a tfvar via the -var-file flag of the terraform plan command. The downloaded resource must not be a directory."

													type: "boolean"
												}
											}
											required: ["address"]
											type: "object"
										}
										type: "array"
									}
								}
								type: "object"
							}
							sshTunnel: {
								description: "SSHTunnel can be defined for pulling from scm sources that cannot be accessed by the network the operator/runner runs in. An example is enterprise-Github servers running on a private network."

								properties: {
									host: type: "string"
									sshKeySecretRef: {
										description: "SSHKeySecretRef defines the secret where the SSH key (for the proxy, git, etc) is stored"

										properties: {
											key: {
												description: "Key in the secret ref. Default to `id_rsa`"
												type:        "string"
											}
											lockSecretDeletion: {
												description: "Set finalizer from controller on the secret to prevent delete flow breaking. Works only with `spec.ignoreDelete = true`."

												type: "boolean"
											}
											name: {
												description: "Name the secret name that has the SSH key"
												type:        "string"
											}
											namespace: {
												description: "Namespace of the secret; Default is the namespace of the terraform resource"

												type: "string"
											}
										}
										required: ["name"]
										type: "object"
									}
									user: type: "string"
								}
								required: ["sshKeySecretRef"]
								type: "object"
							}
							storageClassName: {
								description: "StorageClassName is the name of the volume that terraform-operator will use to store data. An empty value means that this volume does not belong to any StorageClassName and will use the clusters default StorageClassName"

								type: "string"
							}
							taskOptions: {
								description: "TaskOptions are a list of configuration options to be injected into task pods."

								items: {
									description: "TaskOption are different configuration options to be injected into task pods. Can apply to one ore more task pods."

									properties: {
										annotations: {
											additionalProperties: type: "string"
											description: "Annotaitons extra annotaitons to add the task pods"
											type:        "object"
										}
										env: {
											description: "List of environment variables to set in the task pods."

											items: {
												description: "EnvVar represents an environment variable present in a Container."

												properties: {
													name: {
														description: "Name of the environment variable. Must be a C_IDENTIFIER."

														type: "string"
													}
													value: {
														description: "Variable references $(VAR_NAME) are expanded using the previously defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. Double $$ are reduced to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e. \"$$(VAR_NAME)\" will produce the string literal \"$(VAR_NAME)\". Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."

														type: "string"
													}
													valueFrom: {
														description: "Source for the environment variable's value. Cannot be used if value is not empty."

														properties: {
															configMapKeyRef: {
																description: "Selects a key of a ConfigMap."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															fieldRef: {
																description: "Selects a field of the pod: supports metadata.name, metadata.namespace, `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."

																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."

																		type: "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."

																		type: "string"
																	}
																}
																required: ["fieldPath"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."

																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"

																		type: "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description: "Specifies the output format of the exposed resources, defaults to \"1\""

																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															secretKeyRef: {
																description: "Selects a key of a secret in the pod's namespace"

																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."

																		type: "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																		type: "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"

																		type: "boolean"
																	}
																}
																required: ["key"]
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."

											items: {
												description: "EnvFromSource represents the source of a set of ConfigMaps"

												properties: {
													configMapRef: {
														description: "The ConfigMap to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the ConfigMap must be defined"

																type: "boolean"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													prefix: {
														description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."

														type: "string"
													}
													secretRef: {
														description: "The Secret to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "Specify whether the Secret must be defined"
																type:        "boolean"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
												}
												type: "object"
											}
											type: "array"
										}
										for: {
											description: "For is a list of tasks these options will get applied to."

											items: type: "string"
											type: "array"
										}
										labels: {
											additionalProperties: type: "string"
											description: "Labels extra labels to add task pods."
											type:        "object"
										}
										policyRules: {
											description: "RunnerRules are RBAC rules that will be added to all runner pods."

											items: {
												description: "PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to."

												properties: {
													apiGroups: {
														description: "APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. \"\" represents the core API group and \"*\" represents all API groups."

														items: type: "string"
														type: "array"
													}
													nonResourceURLs: {
														description: "NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as \"pods\" or \"secrets\") or non-resource URL paths (such as \"/api\"),  but not both."

														items: type: "string"
														type: "array"
													}
													resourceNames: {
														description: "ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed."

														items: type: "string"
														type: "array"
													}
													resources: {
														description: "Resources is a list of resources this rule applies to. '*' represents all resources."

														items: type: "string"
														type: "array"
													}
													verbs: {
														description: "Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs."

														items: type: "string"
														type: "array"
													}
												}
												required: ["verbs"]
												type: "object"
											}
											type: "array"
										}
										resources: {
											description: "Compute Resources required by the task pods."
											properties: {
												claims: {
													description: """
		Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container. 
		 This is an alpha field and requires enabling the DynamicResourceAllocation feature gate. 
		 This field is immutable. It can only be set for containers.
		"""

													items: {
														description: "ResourceClaim references one entry in PodSpec.ResourceClaims."
														properties: name: {
															description: "Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container."

															type: "string"
														}
														required: ["name"]
														type: "object"
													}
													type: "array"
													"x-kubernetes-list-map-keys": ["name"]
													"x-kubernetes-list-type": "map"
												}
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"

													type: "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"

													type: "object"
												}
											}
											type: "object"
										}
										restartPolicy: {
											description: """
		RestartPolicy describes how the task should be restarted. Only one of the following restart policies may be specified. 
		 ```go const ( RestartPolicyAlways    RestartPolicy = \"Always\" RestartPolicyOnFailure RestartPolicy = \"OnFailure\" RestartPolicyNever     RestartPolicy = \"Never\" ) ``` 
		 If no policy is specified, the restart policy is set to \"Never\".
		"""

											type: "string"
										}
										script: {
											description: "Script is used to configure the source of the task's executable script."

											properties: {
												configMapSelector: {
													description: "ConfigMapSelector reads a in a script from a configmap name+key"

													properties: {
														key: type: "string"
														name: type: "string"
													}
													required: ["name"]
													type: "object"
												}
												inline: {
													description: "Inline is used to write the entire task execution script in the tfo resource."

													type: "string"
												}
												source: {
													description: "Source is an http source that the task container will fetch and then execute."

													type: "string"
												}
											}
											type: "object"
										}
										volumeMounts: {
											description: "Extra volumeMounts for task pod"
											items: {
												description: "VolumeMount describes a mounting of a Volume within a container."

												properties: {
													mountPath: {
														description: "Path within the container at which the volume should be mounted.  Must not contain ':'."

														type: "string"
													}
													mountPropagation: {
														description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."

														type: "string"
													}
													name: {
														description: "This must match the Name of a Volume."
														type:        "string"
													}
													readOnly: {
														description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."

														type: "boolean"
													}
													subPath: {
														description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."

														type: "string"
													}
													subPathExpr: {
														description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."

														type: "string"
													}
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumes: {
											description: "Extra volumes for task pod"
											items: {
												description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."

												properties: {
													awsElasticBlockStore: {
														description: "awsElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"

														properties: {
															fsType: {
																description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"

																type: "string"
															}
															partition: {
																description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."

																format: "int32"
																type:   "integer"
															}
															readOnly: {
																description: "readOnly value true will force the readOnly setting in VolumeMounts. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"

																type: "boolean"
															}
															volumeID: {
																description: "volumeID is unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"

																type: "string"
															}
														}
														required: ["volumeID"]
														type: "object"
													}
													azureDisk: {
														description: "azureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."

														properties: {
															cachingMode: {
																description: "cachingMode is the Host Caching mode: None, Read Only, Read Write."

																type: "string"
															}
															diskName: {
																description: "diskName is the Name of the data disk in the blob storage"

																type: "string"
															}
															diskURI: {
																description: "diskURI is the URI of data disk in the blob storage"

																type: "string"
															}
															fsType: {
																description: "fsType is Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."

																type: "string"
															}
															kind: {
																description: "kind expected values are Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"

																type: "string"
															}
															readOnly: {
																description: "readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."

																type: "boolean"
															}
														}
														required: [
															"diskName",
															"diskURI",
														]
														type: "object"
													}
													azureFile: {
														description: "azureFile represents an Azure File Service mount on the host and bind mount to the pod."

														properties: {
															readOnly: {
																description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."

																type: "boolean"
															}
															secretName: {
																description: "secretName is the  name of secret that contains Azure Storage Account Name and Key"

																type: "string"
															}
															shareName: {
																description: "shareName is the azure share Name"
																type:        "string"
															}
														}
														required: [
															"secretName",
															"shareName",
														]
														type: "object"
													}
													cephfs: {
														description: "cephFS represents a Ceph FS mount on the host that shares a pod's lifetime"

														properties: {
															monitors: {
																description: "monitors is Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"

																items: type: "string"
																type: "array"
															}
															path: {
																description: "path is Optional: Used as the mounted root, rather than the full Ceph tree, default is /"

																type: "string"
															}
															readOnly: {
																description: "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"

																type: "boolean"
															}
															secretFile: {
																description: "secretFile is Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"

																type: "string"
															}
															secretRef: {
																description: "secretRef is Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															user: {
																description: "user is optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"

																type: "string"
															}
														}
														required: ["monitors"]
														type: "object"
													}
													cinder: {
														description: "cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"

														properties: {
															fsType: {
																description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"

																type: "string"
															}
															readOnly: {
																description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"

																type: "boolean"
															}
															secretRef: {
																description: "secretRef is optional: points to a secret object containing parameters used to connect to OpenStack."

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															volumeID: {
																description: "volumeID used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"

																type: "string"
															}
														}
														required: ["volumeID"]
														type: "object"
													}
													configMap: {
														description: "configMap represents a configMap that should populate this volume"

														properties: {
															defaultMode: {
																description: "defaultMode is optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																format: "int32"
																type:   "integer"
															}
															items: {
																description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."

																items: {
																	description: "Maps a string key to a path within a volume."

																	properties: {
																		key: {
																			description: "key is the key to project."
																			type:        "string"
																		}
																		mode: {
																			description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																			format: "int32"
																			type:   "integer"
																		}
																		path: {
																			description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."

																			type: "string"
																		}
																	}
																	required: [
																		"key",
																		"path",
																	]
																	type: "object"
																}
																type: "array"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																type: "string"
															}
															optional: {
																description: "optional specify whether the ConfigMap or its keys must be defined"

																type: "boolean"
															}
														}
														type:                    "object"
														"x-kubernetes-map-type": "atomic"
													}
													csi: {
														description: "csi (Container Storage Interface) represents ephemeral storage that is handled by certain external CSI drivers (Beta feature)."

														properties: {
															driver: {
																description: "driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster."

																type: "string"
															}
															fsType: {
																description: "fsType to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply."

																type: "string"
															}
															nodePublishSecretRef: {
																description: "nodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed."

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															readOnly: {
																description: "readOnly specifies a read-only configuration for the volume. Defaults to false (read/write)."

																type: "boolean"
															}
															volumeAttributes: {
																additionalProperties: type: "string"
																description: "volumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."

																type: "object"
															}
														}
														required: ["driver"]
														type: "object"
													}
													downwardAPI: {
														description: "downwardAPI represents downward API about the pod that should populate this volume"

														properties: {
															defaultMode: {
																description: "Optional: mode bits to use on created files by default. Must be a Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																format: "int32"
																type:   "integer"
															}
															items: {
																description: "Items is a list of downward API volume file"

																items: {
																	description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"

																	properties: {
																		fieldRef: {
																			description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."

																			properties: {
																				apiVersion: {
																					description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."

																					type: "string"
																				}
																				fieldPath: {
																					description: "Path of the field to select in the specified API version."

																					type: "string"
																				}
																			}
																			required: ["fieldPath"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		mode: {
																			description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																			format: "int32"
																			type:   "integer"
																		}
																		path: {
																			description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"

																			type: "string"
																		}
																		resourceFieldRef: {
																			description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."

																			properties: {
																				containerName: {
																					description: "Container name: required for volumes, optional for env vars"

																					type: "string"
																				}
																				divisor: {
																					anyOf: [{
																						type: "integer"
																					}, {
																						type: "string"
																					}]
																					description: "Specifies the output format of the exposed resources, defaults to \"1\""

																					pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																					"x-kubernetes-int-or-string": true
																				}
																				resource: {
																					description: "Required: resource to select"
																					type:        "string"
																				}
																			}
																			required: ["resource"]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																	}
																	required: ["path"]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													emptyDir: {
														description: "emptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

														properties: {
															medium: {
																description: "medium represents what type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

																type: "string"
															}
															sizeLimit: {
																anyOf: [{
																	type: "integer"
																}, {
																	type: "string"
																}]
																description: "sizeLimit is the total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"

																pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																"x-kubernetes-int-or-string": true
															}
														}
														type: "object"
													}
													ephemeral: {
														description: """
		ephemeral represents a volume that is handled by a cluster storage driver. The volume's lifecycle is tied to the pod that defines it - it will be created before the pod starts, and deleted when the pod is removed. 
		 Use this if: a) the volume is only needed while the pod runs, b) features of normal volumes like restoring from snapshot or capacity tracking are needed, c) the storage driver is specified through a storage class, and d) the storage driver supports dynamic volume provisioning through a PersistentVolumeClaim (see EphemeralVolumeSource for more information on the connection between this volume type and PersistentVolumeClaim). 
		 Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes that persist for longer than the lifecycle of an individual pod. 
		 Use CSI for light-weight local ephemeral volumes if the CSI driver is meant to be used that way - see the documentation of the driver for more information. 
		 A pod can use both types of ephemeral volumes and persistent volumes at the same time.
		"""

														properties: volumeClaimTemplate: {
															description: """
		Will be used to create a stand-alone PVC to provision the volume. The pod in which this EphemeralVolumeSource is embedded will be the owner of the PVC, i.e. the PVC will be deleted together with the pod.  The name of the PVC will be `<pod name>-<volume name>` where `<volume name>` is the name from the `PodSpec.Volumes` array entry. Pod validation will reject the pod if the concatenated name is not valid for a PVC (for example, too long). 
		 An existing PVC with that name that is not owned by the pod will *not* be used for the pod to avoid using an unrelated volume by mistake. Starting the pod is then blocked until the unrelated PVC is removed. If such a pre-created PVC is meant to be used by the pod, the PVC has to updated with an owner reference to the pod once the pod exists. Normally this should not be necessary, but it may be useful when manually reconstructing a broken cluster. 
		 This field is read-only and no changes will be made by Kubernetes to the PVC after it has been created. 
		 Required, must not be nil.
		"""

															properties: {
																metadata: {
																	description: "May contain labels and annotations that will be copied into the PVC when creating it. No other fields are allowed and will be rejected during validation."

																	type: "object"
																}
																spec: {
																	description: "The specification for the PersistentVolumeClaim. The entire content is copied unchanged into the PVC that gets created from this template. The same fields as in a PersistentVolumeClaim are also valid here."

																	properties: {
																		accessModes: {
																			description: "accessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"

																			items: type: "string"
																			type: "array"
																		}
																		dataSource: {
																			description: "dataSource field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. When the AnyVolumeDataSource feature gate is enabled, dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be copied to dataSource when dataSourceRef.namespace is not specified. If the namespace is specified, then dataSourceRef will not be copied to dataSource."

																			properties: {
																				apiGroup: {
																					description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																					type: "string"
																				}
																				kind: {
																					description: "Kind is the type of resource being referenced"

																					type: "string"
																				}
																				name: {
																					description: "Name is the name of resource being referenced"

																					type: "string"
																				}
																			}
																			required: [
																				"kind",
																				"name",
																			]
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		dataSourceRef: {
																			description: "dataSourceRef specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the dataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, when namespace isn't specified in dataSourceRef, both fields (dataSource and dataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. When namespace is specified in dataSourceRef, dataSource isn't set to the same value and must be empty. There are three important differences between dataSource and dataSourceRef: * While dataSource only allows two specific types of objects, dataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While dataSource ignores disallowed values (dropping them), dataSourceRef preserves all values, and generates an error if a disallowed value is specified. * While dataSource only allows local objects, dataSourceRef allows objects in any namespaces. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled. (Alpha) Using the namespace field of dataSourceRef requires the CrossNamespaceVolumeDataSource feature gate to be enabled."

																			properties: {
																				apiGroup: {
																					description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."

																					type: "string"
																				}
																				kind: {
																					description: "Kind is the type of resource being referenced"

																					type: "string"
																				}
																				name: {
																					description: "Name is the name of resource being referenced"

																					type: "string"
																				}
																				namespace: {
																					description: "Namespace is the namespace of resource being referenced Note that when a namespace is specified, a gateway.networking.k8s.io/ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled."

																					type: "string"
																				}
																			}
																			required: [
																				"kind",
																				"name",
																			]
																			type: "object"
																		}
																		resources: {
																			description: "resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"

																			properties: {
																				claims: {
																					description: """
		Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container. 
		 This is an alpha field and requires enabling the DynamicResourceAllocation feature gate. 
		 This field is immutable. It can only be set for containers.
		"""

																					items: {
																						description: "ResourceClaim references one entry in PodSpec.ResourceClaims."

																						properties: name: {
																							description: "Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container."

																							type: "string"
																						}
																						required: ["name"]
																						type: "object"
																					}
																					type: "array"
																					"x-kubernetes-list-map-keys": ["name"]
																					"x-kubernetes-list-type": "map"
																				}
																				limits: {
																					additionalProperties: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"

																					type: "object"
																				}
																				requests: {
																					additionalProperties: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/"

																					type: "object"
																				}
																			}
																			type: "object"
																		}
																		selector: {
																			description: "selector is a label query over volumes to consider for binding."

																			properties: {
																				matchExpressions: {
																					description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."

																					items: {
																						description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."

																						properties: {
																							key: {
																								description: "key is the label key that the selector applies to."

																								type: "string"
																							}
																							operator: {
																								description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."

																								type: "string"
																							}
																							values: {
																								description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."

																								items: type: "string"
																								type: "array"
																							}
																						}
																						required: [
																							"key",
																							"operator",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				matchLabels: {
																					additionalProperties: type: "string"
																					description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

																					type: "object"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		storageClassName: {
																			description: "storageClassName is the name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"

																			type: "string"
																		}
																		volumeMode: {
																			description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."

																			type: "string"
																		}
																		volumeName: {
																			description: "volumeName is the binding reference to the PersistentVolume backing this claim."

																			type: "string"
																		}
																	}
																	type: "object"
																}
															}
															required: ["spec"]
															type: "object"
														}
														type: "object"
													}
													fc: {
														description: "fc represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."

														properties: {
															fsType: {
																description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"

																type: "string"
															}
															lun: {
																description: "lun is Optional: FC target lun number"
																format:      "int32"
																type:        "integer"
															}
															readOnly: {
																description: "readOnly is Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."

																type: "boolean"
															}
															targetWWNs: {
																description: "targetWWNs is Optional: FC target worldwide names (WWNs)"

																items: type: "string"
																type: "array"
															}
															wwids: {
																description: "wwids Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."

																items: type: "string"
																type: "array"
															}
														}
														type: "object"
													}
													flexVolume: {
														description: "flexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."

														properties: {
															driver: {
																description: "driver is the name of the driver to use for this volume."

																type: "string"
															}
															fsType: {
																description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script."

																type: "string"
															}
															options: {
																additionalProperties: type: "string"
																description: "options is Optional: this field holds extra command options if any."

																type: "object"
															}
															readOnly: {
																description: "readOnly is Optional: defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."

																type: "boolean"
															}
															secretRef: {
																description: "secretRef is Optional: secretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
														}
														required: ["driver"]
														type: "object"
													}
													flocker: {
														description: "flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"

														properties: {
															datasetName: {
																description: "datasetName is Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated"

																type: "string"
															}
															datasetUUID: {
																description: "datasetUUID is the UUID of the dataset. This is unique identifier of a Flocker dataset"

																type: "string"
															}
														}
														type: "object"
													}
													gcePersistentDisk: {
														description: "gcePersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"

														properties: {
															fsType: {
																description: "fsType is filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"

																type: "string"
															}
															partition: {
																description: "partition is the partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"

																format: "int32"
																type:   "integer"
															}
															pdName: {
																description: "pdName is unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"

																type: "string"
															}
															readOnly: {
																description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"

																type: "boolean"
															}
														}
														required: ["pdName"]
														type: "object"
													}
													gitRepo: {
														description: "gitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."

														properties: {
															directory: {
																description: "directory is the target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name."

																type: "string"
															}
															repository: {
																description: "repository is the URL"
																type:        "string"
															}
															revision: {
																description: "revision is the commit hash for the specified revision."

																type: "string"
															}
														}
														required: ["repository"]
														type: "object"
													}
													glusterfs: {
														description: "glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"

														properties: {
															endpoints: {
																description: "endpoints is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"

																type: "string"
															}
															path: {
																description: "path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"

																type: "string"
															}
															readOnly: {
																description: "readOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"

																type: "boolean"
															}
														}
														required: [
															"endpoints",
															"path",
														]
														type: "object"
													}
													hostPath: {
														description: "hostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."

														properties: {
															path: {
																description: "path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"

																type: "string"
															}
															type: {
																description: "type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"

																type: "string"
															}
														}
														required: ["path"]
														type: "object"
													}
													iscsi: {
														description: "iscsi represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"

														properties: {
															chapAuthDiscovery: {
																description: "chapAuthDiscovery defines whether support iSCSI Discovery CHAP authentication"

																type: "boolean"
															}
															chapAuthSession: {
																description: "chapAuthSession defines whether support iSCSI Session CHAP authentication"

																type: "boolean"
															}
															fsType: {
																description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine"

																type: "string"
															}
															initiatorName: {
																description: "initiatorName is the custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection."

																type: "string"
															}
															iqn: {
																description: "iqn is the target iSCSI Qualified Name."
																type:        "string"
															}
															iscsiInterface: {
																description: "iscsiInterface is the interface Name that uses an iSCSI transport. Defaults to 'default' (tcp)."

																type: "string"
															}
															lun: {
																description: "lun represents iSCSI Target Lun number."
																format:      "int32"
																type:        "integer"
															}
															portals: {
																description: "portals is the iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."

																items: type: "string"
																type: "array"
															}
															readOnly: {
																description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."

																type: "boolean"
															}
															secretRef: {
																description: "secretRef is the CHAP Secret for iSCSI target and initiator authentication"

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															targetPortal: {
																description: "targetPortal is iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."

																type: "string"
															}
														}
														required: [
															"iqn",
															"lun",
															"targetPortal",
														]
														type: "object"
													}
													name: {
														description: "name of the volume. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"

														type: "string"
													}
													nfs: {
														description: "nfs represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"

														properties: {
															path: {
																description: "path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"

																type: "string"
															}
															readOnly: {
																description: "readOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"

																type: "boolean"
															}
															server: {
																description: "server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"

																type: "string"
															}
														}
														required: [
															"path",
															"server",
														]
														type: "object"
													}
													persistentVolumeClaim: {
														description: "persistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

														properties: {
															claimName: {
																description: "claimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"

																type: "string"
															}
															readOnly: {
																description: "readOnly Will force the ReadOnly setting in VolumeMounts. Default false."

																type: "boolean"
															}
														}
														required: ["claimName"]
														type: "object"
													}
													photonPersistentDisk: {
														description: "photonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"

														properties: {
															fsType: {
																description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."

																type: "string"
															}
															pdID: {
																description: "pdID is the ID that identifies Photon Controller persistent disk"

																type: "string"
															}
														}
														required: ["pdID"]
														type: "object"
													}
													portworxVolume: {
														description: "portworxVolume represents a portworx volume attached and mounted on kubelets host machine"

														properties: {
															fsType: {
																description: "fSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified."

																type: "string"
															}
															readOnly: {
																description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."

																type: "boolean"
															}
															volumeID: {
																description: "volumeID uniquely identifies a Portworx volume"

																type: "string"
															}
														}
														required: ["volumeID"]
														type: "object"
													}
													projected: {
														description: "projected items for all in one resources secrets, configmaps, and downward API"

														properties: {
															defaultMode: {
																description: "defaultMode are the mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																format: "int32"
																type:   "integer"
															}
															sources: {
																description: "sources is the list of volume projections"
																items: {
																	description: "Projection that may be projected along with other supported volume types"

																	properties: {
																		configMap: {
																			description: "configMap information about the configMap data to project"

																			properties: {
																				items: {
																					description: "items if unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."

																					items: {
																						description: "Maps a string key to a path within a volume."

																						properties: {
																							key: {
																								description: "key is the key to project."
																								type:        "string"
																							}
																							mode: {
																								description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																								format: "int32"
																								type:   "integer"
																							}
																							path: {
																								description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."

																								type: "string"
																							}
																						}
																						required: [
																							"key",
																							"path",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "optional specify whether the ConfigMap or its keys must be defined"

																					type: "boolean"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		downwardAPI: {
																			description: "downwardAPI information about the downwardAPI data to project"

																			properties: items: {
																				description: "Items is a list of DownwardAPIVolume file"

																				items: {
																					description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"

																					properties: {
																						fieldRef: {
																							description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."

																							properties: {
																								apiVersion: {
																									description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."

																									type: "string"
																								}
																								fieldPath: {
																									description: "Path of the field to select in the specified API version."

																									type: "string"
																								}
																							}
																							required: ["fieldPath"]
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
																						}
																						mode: {
																							description: "Optional: mode bits used to set permissions on this file, must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																							format: "int32"
																							type:   "integer"
																						}
																						path: {
																							description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"

																							type: "string"
																						}
																						resourceFieldRef: {
																							description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."

																							properties: {
																								containerName: {
																									description: "Container name: required for volumes, optional for env vars"

																									type: "string"
																								}
																								divisor: {
																									anyOf: [{
																										type: "integer"
																									}, {
																										type: "string"
																									}]
																									description: "Specifies the output format of the exposed resources, defaults to \"1\""

																									pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																									"x-kubernetes-int-or-string": true
																								}
																								resource: {
																									description: "Required: resource to select"

																									type: "string"
																								}
																							}
																							required: ["resource"]
																							type:                    "object"
																							"x-kubernetes-map-type": "atomic"
																						}
																					}
																					required: ["path"]
																					type: "object"
																				}
																				type: "array"
																			}
																			type: "object"
																		}
																		secret: {
																			description: "secret information about the secret data to project"

																			properties: {
																				items: {
																					description: "items if unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."

																					items: {
																						description: "Maps a string key to a path within a volume."

																						properties: {
																							key: {
																								description: "key is the key to project."
																								type:        "string"
																							}
																							mode: {
																								description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																								format: "int32"
																								type:   "integer"
																							}
																							path: {
																								description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."

																								type: "string"
																							}
																						}
																						required: [
																							"key",
																							"path",
																						]
																						type: "object"
																					}
																					type: "array"
																				}
																				name: {
																					description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																					type: "string"
																				}
																				optional: {
																					description: "optional field specify whether the Secret or its key must be defined"

																					type: "boolean"
																				}
																			}
																			type:                    "object"
																			"x-kubernetes-map-type": "atomic"
																		}
																		serviceAccountToken: {
																			description: "serviceAccountToken is information about the serviceAccountToken data to project"

																			properties: {
																				audience: {
																					description: "audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."

																					type: "string"
																				}
																				expirationSeconds: {
																					description: "expirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."

																					format: "int64"
																					type:   "integer"
																				}
																				path: {
																					description: "path is the path relative to the mount point of the file to project the token into."

																					type: "string"
																				}
																			}
																			required: ["path"]
																			type: "object"
																		}
																	}
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													quobyte: {
														description: "quobyte represents a Quobyte mount on the host that shares a pod's lifetime"

														properties: {
															group: {
																description: "group to map volume access to Default is no group"

																type: "string"
															}
															readOnly: {
																description: "readOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false."

																type: "boolean"
															}
															registry: {
																description: "registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes"

																type: "string"
															}
															tenant: {
																description: "tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin"

																type: "string"
															}
															user: {
																description: "user to map volume access to Defaults to serivceaccount user"

																type: "string"
															}
															volume: {
																description: "volume is a string that references an already created Quobyte volume by name."

																type: "string"
															}
														}
														required: [
															"registry",
															"volume",
														]
														type: "object"
													}
													rbd: {
														description: "rbd represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"

														properties: {
															fsType: {
																description: "fsType is the filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine"

																type: "string"
															}
															image: {
																description: "image is the rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"

																type: "string"
															}
															keyring: {
																description: "keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"

																type: "string"
															}
															monitors: {
																description: "monitors is a collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"

																items: type: "string"
																type: "array"
															}
															pool: {
																description: "pool is the rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"

																type: "string"
															}
															readOnly: {
																description: "readOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"

																type: "boolean"
															}
															secretRef: {
																description: "secretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															user: {
																description: "user is the rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"

																type: "string"
															}
														}
														required: [
															"image",
															"monitors",
														]
														type: "object"
													}
													scaleIO: {
														description: "scaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."

														properties: {
															fsType: {
																description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\"."

																type: "string"
															}
															gateway: {
																description: "gateway is the host address of the ScaleIO API Gateway."

																type: "string"
															}
															protectionDomain: {
																description: "protectionDomain is the name of the ScaleIO Protection Domain for the configured storage."

																type: "string"
															}
															readOnly: {
																description: "readOnly Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."

																type: "boolean"
															}
															secretRef: {
																description: "secretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail."

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															sslEnabled: {
																description: "sslEnabled Flag enable/disable SSL communication with Gateway, default false"

																type: "boolean"
															}
															storageMode: {
																description: "storageMode indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned."

																type: "string"
															}
															storagePool: {
																description: "storagePool is the ScaleIO Storage Pool associated with the protection domain."

																type: "string"
															}
															system: {
																description: "system is the name of the storage system as configured in ScaleIO."

																type: "string"
															}
															volumeName: {
																description: "volumeName is the name of a volume already created in the ScaleIO system that is associated with this volume source."

																type: "string"
															}
														}
														required: [
															"gateway",
															"secretRef",
															"system",
														]
														type: "object"
													}
													secret: {
														description: "secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"

														properties: {
															defaultMode: {
																description: "defaultMode is Optional: mode bits used to set permissions on created files by default. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																format: "int32"
																type:   "integer"
															}
															items: {
																description: "items If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."

																items: {
																	description: "Maps a string key to a path within a volume."

																	properties: {
																		key: {
																			description: "key is the key to project."
																			type:        "string"
																		}
																		mode: {
																			description: "mode is Optional: mode bits used to set permissions on this file. Must be an octal value between 0000 and 0777 or a decimal value between 0 and 511. YAML accepts both octal and decimal values, JSON requires decimal values for mode bits. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."

																			format: "int32"
																			type:   "integer"
																		}
																		path: {
																			description: "path is the relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."

																			type: "string"
																		}
																	}
																	required: [
																		"key",
																		"path",
																	]
																	type: "object"
																}
																type: "array"
															}
															optional: {
																description: "optional field specify whether the Secret or its keys must be defined"

																type: "boolean"
															}
															secretName: {
																description: "secretName is the name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"

																type: "string"
															}
														}
														type: "object"
													}
													storageos: {
														description: "storageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."

														properties: {
															fsType: {
																description: "fsType is the filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."

																type: "string"
															}
															readOnly: {
																description: "readOnly defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."

																type: "boolean"
															}
															secretRef: {
																description: "secretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted."

																properties: name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"

																	type: "string"
																}
																type:                    "object"
																"x-kubernetes-map-type": "atomic"
															}
															volumeName: {
																description: "volumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace."

																type: "string"
															}
															volumeNamespace: {
																description: "volumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created."

																type: "string"
															}
														}
														type: "object"
													}
													vsphereVolume: {
														description: "vsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"

														properties: {
															fsType: {
																description: "fsType is filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."

																type: "string"
															}
															storagePolicyID: {
																description: "storagePolicyID is the storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."

																type: "string"
															}
															storagePolicyName: {
																description: "storagePolicyName is the storage Policy Based Management (SPBM) profile name."

																type: "string"
															}
															volumePath: {
																description: "volumePath is the path that identifies vSphere volume vmdk"

																type: "string"
															}
														}
														required: ["volumePath"]
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
									}
									required: ["for"]
									type: "object"
								}
								type: "array"
							}
							terraformModule: {
								description: "TerraformModule is used to configure the source of the terraform module."

								properties: {
									configMapSeclector: {
										description: "Typoed form of configMapSelector"
										properties: {
											key: type: "string"
											name: type: "string"
										}
										required: ["name"]
										type: "object"
									}
									configMapSelector: {
										description: """
		ConfigMapSelector is an option that points to an existing configmap on the executing cluster. The configmap is expected to contains has the terraform module (ie keys ending with .tf). The configmap would need to live in the same namespace as the tfo resource. 
		 The configmap is mounted as a volume and put into the TFO_MAIN_MODULE path by the setup task. 
		 If a key is defined, the value is used as the module else the entirety of the data objects will be loaded as files.
		"""

										properties: {
											key: type: "string"
											name: type: "string"
										}
										required: ["name"]
										type: "object"
									}
									inline: {
										description: "Inline used to define an entire terraform module inline and then mounted in the TFO_MAIN_MODULE path."

										type: "string"
									}
									source: {
										description: "Source accepts a subset of the terraform \"Module Source\" ways of defining a module. Terraform Operator prefers modules that are defined in a git repo as opposed to other scm types. Refer to https://www.terraform.io/language/modules/sources#module-sources for more details."

										type: "string"
									}
									version: {
										description: "Version to select from a terraform registry. For version to be used, source must be defined. Refer to https://www.terraform.io/language/modules/sources#module-sources for more details"

										type: "string"
									}
								}
								type: "object"
							}
							terraformVersion: {
								description: "TerraformVersion is the version of terraform which is used to run the module. The terraform version is used as the tag of the terraform image  regardless if images.terraform.image is defined with a tag. In that case, the tag is stripped and replace with this value."

								type: "string"
							}
							writeOutputsToStatus: {
								description: "WriteOutputsToStatus will add the outputs from the module to the status of the Terraform CustomResource."

								type: "boolean"
							}
						}
						required: [
							"backend",
							"terraformModule",
							"terraformVersion",
						]
						type: "object"
					}
					status: {
						description: "TerraformStatus defines the observed state of Terraform"
						properties: {
							lastCompletedGeneration: {
								description: "LastCompletedGeneration shows the generation of the last completed workflow. This is not relevant for remotely executed workflows."

								format: "int64"
								type:   "integer"
							}
							outputs: {
								additionalProperties: type: "string"
								description: "Outputs terraform outputs, when opt-in, will be added to this `status.outputs` field as key/value pairs"

								type: "object"
							}
							phase: {
								description: "Phase is the current phase of the workflow"
								type:        "string"
							}
							pluginsStarted: {
								description: "PluginsStarted is a list of plugins that have been executed by the controller. Will get refreshed each generation."

								items: type: "string"
								type: "array"
							}
							podNamePrefix: {
								description: "PodNamePrefix is used to identify this installation of the resource. For very long resource names, like those greater than 220 characters, the prefix ensures resource uniqueness for runners and other resources used by the runner. Another case for the pod name prefix is when rapidly deleteing a resource and recreating it, the chance of recycling existing resources is reduced to virtually nil."

								type: "string"
							}
							retryEventReason: {
								description: """
		RetryEventReason copies the value of the resource label for 'kubernetes.io/change-cause'. When '.setup' is is the suffix of the value, the pipeline will retry from the setup task. 
		 Example of starting from setup: 
		 ```yaml metadata: labels: kubernetes.io/change-cause: triggered-by-isa_aguilar-20231025T011600.setup ``` 
		 A default retry will start from the init task otherwise.
		"""

								type: "string"
							}
							retryTimestamp: {
								format: "date-time"
								type:   "string"
							}
							stage: {
								description: "Stage stores information about the current stage"
								properties: {
									generation: {
										description: "Generation is the generation of the resource when the task got started."

										format: "int64"
										type:   "integer"
									}
									interruptible: {
										description: "Interruptible is set to false when the pod should not be terminated such as when doing a terraform apply."

										type: "boolean"
									}
									message: {
										description: "Message stores the last message displayed in the logs. It is stored and checked by the controller to reduce the noise in the logs by only displying the message once."

										type: "string"
									}
									podName: {
										description: "PodName is the pod assigned to execute the stage."
										type:        "string"
									}
									podType: {
										description: "TaskType is which task is currently running."
										type:        "string"
									}
									podUID: {
										description: "PodUID is the pod uid of the pod assigned to execute the stage."

										type: "string"
									}
									reason: {
										description: "Reason is a message of what is happening with the pod. The controller uses this field when certain reasons occur to make scheduling decisions."

										type: "string"
									}
									startTime: {
										description: "StartTime is when the task got created by the controller, not when a pod got started."

										format: "date-time"
										type:   "string"
									}
									state: {
										description: "State is the phase of the task pod."
										type:        "string"
									}
									stopTime: {
										description: "StopTime is when the task went into a stopped phase."
										format:      "date-time"
										type:        "string"
									}
								}
								required: [
									"generation",
									"interruptible",
									"podType",
									"reason",
									"state",
								]
								type: "object"
							}
						}
						required: [
							"lastCompletedGeneration",
							"phase",
							"podNamePrefix",
							"stage",
						]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: serviceaccount: "coder-amanibhavam-district-cluster-tfo": "tf-system": "terraform-operator": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		name:      "terraform-operator"
		namespace: "tf-system"
	}
}
res: clusterrole: "coder-amanibhavam-district-cluster-tfo": cluster: "terraform-operator": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "terraform-operator"
	rules: [{
		apiGroups: [""]
		resources: [
			"pods",
			"services",
			"services/finalizers",
			"endpoints",
			"persistentvolumeclaims",
			"events",
			"configmaps",
			"secrets",
			"serviceaccounts",
			"nodes",
		]
		verbs: ["*"]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: [
			"roles",
			"rolebindings",
			"clusterroles",
			"clusterrolebindings",
		]
		verbs: ["*"]
	}, {
		apiGroups: ["apps"]
		resources: [
			"deployments",
			"daemonsets",
			"replicasets",
			"statefulsets",
		]
		verbs: ["*"]
	}, {
		apiGroups: ["batch"]
		resources: ["jobs"]
		verbs: ["*"]
	}, {
		apiGroups: ["monitoring.coreos.com"]
		resources: ["servicemonitors"]
		verbs: [
			"get",
			"create",
		]
	}, {
		apiGroups: ["apps"]
		resourceNames: ["terraform-operator"]
		resources: ["deployments/finalizers"]
		verbs: ["update"]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: ["get"]
	}, {
		apiGroups: ["apps"]
		resources: ["replicasets"]
		verbs: ["get"]
	}, {
		apiGroups: ["tf.galleybytes.com"]
		resources: ["*"]
		verbs: ["*"]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resourceNames: ["terraforms.tf.galleybytes.com"]
		resources: ["customresourcedefinitions"]
		verbs: ["*"]
	}]
}
res: clusterrolebinding: "coder-amanibhavam-district-cluster-tfo": cluster: "terraform-operator": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: name: "terraform-operator"
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "terraform-operator"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "terraform-operator"
		namespace: "tf-system"
	}]
}
res: deployment: "coder-amanibhavam-district-cluster-tfo": "tf-system": "terraform-operator": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "terraform-operator"
		namespace: "tf-system"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			app:       "terraform-operator"
			component: "controller"
		}
		strategy: {
			rollingUpdate: {
				maxSurge:       "25%"
				maxUnavailable: "25%"
			}
			type: "RollingUpdate"
		}
		template: {
			metadata: labels: {
				app:       "terraform-operator"
				component: "controller"
			}
			spec: {
				containers: [{
					args: [
						"--zap-log-level=debug",
						"--zap-encoder=console",
					]
					command: ["terraform-operator"]
					env: [{
						name: "WATCH_NAMESPACE"
					}, {
						name: "POD_NAME"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "metadata.name"
						}
					}, {
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: {
							apiVersion: "v1"
							fieldPath:  "metadata.namespace"
						}
					}, {
						name:  "OPERATOR_NAME"
						value: "terraform-operator"
					}]
					image:           "ghcr.io/galleybytes/terraform-operator:v0.16.0"
					imagePullPolicy: "IfNotPresent"
					name:            "terraform-operator"
					resources: {
						limits: {
							cpu:    "50m"
							memory: "128M"
						}
						requests: {
							cpu:    "25m"
							memory: "128M"
						}
					}
				}]
				securityContext: {
					runAsNonRoot: true
					runAsUser:    1001
				}
				serviceAccountName: "terraform-operator"
			}
		}
	}
}