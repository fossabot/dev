package y

res: namespace: "coder-amanibhavam-school-cluster-postgres-operator": cluster: "postgres-operator": {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "postgres-operator"
}
res: customresourcedefinition: "coder-amanibhavam-school-cluster-postgres-operator": cluster: "operatorconfigurations.acid.zalan.do": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		labels: "app.kubernetes.io/name": "postgres-operator"
		name: "operatorconfigurations.acid.zalan.do"
	}
	spec: {
		group: "acid.zalan.do"
		names: {
			categories: ["all"]
			kind:     "OperatorConfiguration"
			listKind: "OperatorConfigurationList"
			plural:   "operatorconfigurations"
			shortNames: ["opconfig"]
			singular: "operatorconfiguration"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "Spilo image to be used for Pods"
				jsonPath:    ".configuration.docker_image"
				name:        "Image"
				type:        "string"
			}, {
				description: "Label for K8s resources created by operator"
				jsonPath:    ".configuration.kubernetes.cluster_name_label"
				name:        "Cluster-Label"
				type:        "string"
			}, {
				description: "Name of service account to be used"
				jsonPath:    ".configuration.kubernetes.pod_service_account_name"
				name:        "Service-Account"
				type:        "string"
			}, {
				description: "Minimum number of instances per Postgres cluster"
				jsonPath:    ".configuration.min_instances"
				name:        "Min-Instances"
				type:        "integer"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: {
						enum: ["acid.zalan.do/v1"]
						type: "string"
					}
					configuration: {
						properties: {
							aws_or_gcp: {
								properties: {
									additional_secret_mount: type: "string"
									additional_secret_mount_path: {
										default: "/meta/credentials"
										type:    "string"
									}
									aws_region: {
										default: "eu-central-1"
										type:    "string"
									}
									enable_ebs_gp3_migration: {
										default: false
										type:    "boolean"
									}
									enable_ebs_gp3_migration_max_size: {
										default: 1000
										type:    "integer"
									}
									gcp_credentials: type: "string"
									kube_iam_role: type: "string"
									log_s3_bucket: type: "string"
									wal_az_storage_account: type: "string"
									wal_gs_bucket: type: "string"
									wal_s3_bucket: type: "string"
								}
								type: "object"
							}
							connection_pooler: {
								properties: {
									connection_pooler_default_cpu_limit: {
										default: "1"
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									connection_pooler_default_cpu_request: {
										default: "500m"
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									connection_pooler_default_memory_limit: {
										default: "100Mi"
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									connection_pooler_default_memory_request: {
										default: "100Mi"
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									connection_pooler_image: {
										default: "registry.opensource.zalan.do/acid/pgbouncer:master-27"
										type:    "string"
									}
									connection_pooler_max_db_connections: {
										default: 60
										type:    "integer"
									}
									connection_pooler_mode: {
										default: "transaction"
										enum: [
											"session",
											"transaction",
										]
										type: "string"
									}
									connection_pooler_number_of_instances: {
										default: 2
										minimum: 1
										type:    "integer"
									}
									connection_pooler_schema: {
										default: "pooler"
										type:    "string"
									}
									connection_pooler_user: {
										default: "pooler"
										type:    "string"
									}
								}
								type: "object"
							}
							crd_categories: {
								items: type: "string"
								nullable: true
								type:     "array"
							}
							debug: {
								properties: {
									debug_logging: {
										default: true
										type:    "boolean"
									}
									enable_database_access: {
										default: true
										type:    "boolean"
									}
								}
								type: "object"
							}
							docker_image: {
								default: "ghcr.io/zalando/spilo-15:3.0-p1"
								type:    "string"
							}
							enable_crd_registration: {
								default: true
								type:    "boolean"
							}
							enable_crd_validation: {
								default:     true
								description: "deprecated"
								type:        "boolean"
							}
							enable_lazy_spilo_upgrade: {
								default: false
								type:    "boolean"
							}
							enable_pgversion_env_var: {
								default: true
								type:    "boolean"
							}
							enable_shm_volume: {
								default: true
								type:    "boolean"
							}
							enable_spilo_wal_path_compat: {
								default: false
								type:    "boolean"
							}
							enable_team_id_clustername_prefix: {
								default: false
								type:    "boolean"
							}
							etcd_host: {
								default: ""
								type:    "string"
							}
							ignore_instance_limits_annotation_key: type: "string"
							kubernetes: {
								properties: {
									additional_pod_capabilities: {
										items: type: "string"
										type: "array"
									}
									cluster_domain: {
										default: "cluster.local"
										type:    "string"
									}
									cluster_labels: {
										additionalProperties: type: "string"
										default: application: "spilo"
										type: "object"
									}
									cluster_name_label: {
										default: "cluster-name"
										type:    "string"
									}
									custom_pod_annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									delete_annotation_date_key: type: "string"
									delete_annotation_name_key: type: "string"
									downscaler_annotations: {
										items: type: "string"
										type: "array"
									}
									enable_cross_namespace_secret: {
										default: false
										type:    "boolean"
									}
									enable_init_containers: {
										default: true
										type:    "boolean"
									}
									enable_pod_antiaffinity: {
										default: false
										type:    "boolean"
									}
									enable_pod_disruption_budget: {
										default: true
										type:    "boolean"
									}
									enable_readiness_probe: {
										default: false
										type:    "boolean"
									}
									enable_sidecars: {
										default: true
										type:    "boolean"
									}
									ignored_annotations: {
										items: type: "string"
										type: "array"
									}
									infrastructure_roles_secret_name: type: "string"
									infrastructure_roles_secrets: {
										items: {
											properties: {
												defaultrolevalue: type: "string"
												defaultuservalue: type: "string"
												details: type: "string"
												passwordkey: type: "string"
												rolekey: type: "string"
												secretname: type: "string"
												template: type: "boolean"
												userkey: type: "string"
											}
											required: [
												"secretname",
												"userkey",
												"passwordkey",
											]
											type: "object"
										}
										nullable: true
										type:     "array"
									}
									inherited_annotations: {
										items: type: "string"
										type: "array"
									}
									inherited_labels: {
										items: type: "string"
										type: "array"
									}
									master_pod_move_timeout: {
										default: "20m"
										type:    "string"
									}
									node_readiness_label: {
										additionalProperties: type: "string"
										type: "object"
									}
									node_readiness_label_merge: {
										enum: [
											"AND",
											"OR",
										]
										type: "string"
									}
									oauth_token_secret_name: {
										default: "postgresql-operator"
										type:    "string"
									}
									pdb_name_format: {
										default: "postgres-{cluster}-pdb"
										type:    "string"
									}
									pod_antiaffinity_preferred_during_scheduling: {
										default: false
										type:    "boolean"
									}
									pod_antiaffinity_topology_key: {
										default: "kubernetes.io/hostname"
										type:    "string"
									}
									pod_environment_configmap: type: "string"
									pod_environment_secret: type: "string"
									pod_management_policy: {
										default: "ordered_ready"
										enum: [
											"ordered_ready",
											"parallel",
										]
										type: "string"
									}
									pod_priority_class_name: type: "string"
									pod_role_label: {
										default: "spilo-role"
										type:    "string"
									}
									pod_service_account_definition: {
										default: ""
										type:    "string"
									}
									pod_service_account_name: {
										default: "postgres-pod"
										type:    "string"
									}
									pod_service_account_role_binding_definition: {
										default: ""
										type:    "string"
									}
									pod_terminate_grace_period: {
										default: "5m"
										type:    "string"
									}
									secret_name_template: {
										default: "{username}.{cluster}.credentials.{tprkind}.{tprgroup}"
										type:    "string"
									}
									share_pgsocket_with_sidecars: {
										default: false
										type:    "boolean"
									}
									spilo_allow_privilege_escalation: {
										default: true
										type:    "boolean"
									}
									spilo_fsgroup: type: "integer"
									spilo_privileged: {
										default: false
										type:    "boolean"
									}
									spilo_runasgroup: type: "integer"
									spilo_runasuser: type: "integer"
									storage_resize_mode: {
										default: "pvc"
										enum: [
											"ebs",
											"mixed",
											"pvc",
											"off",
										]
										type: "string"
									}
									toleration: {
										additionalProperties: type: "string"
										type: "object"
									}
									watched_namespace: type: "string"
								}
								type: "object"
							}
							kubernetes_use_configmaps: {
								default: false
								type:    "boolean"
							}
							load_balancer: {
								properties: {
									custom_service_annotations: {
										additionalProperties: type: "string"
										type: "object"
									}
									db_hosted_zone: {
										default: "db.example.com"
										type:    "string"
									}
									enable_master_load_balancer: {
										default: true
										type:    "boolean"
									}
									enable_master_pooler_load_balancer: {
										default: false
										type:    "boolean"
									}
									enable_replica_load_balancer: {
										default: false
										type:    "boolean"
									}
									enable_replica_pooler_load_balancer: {
										default: false
										type:    "boolean"
									}
									external_traffic_policy: {
										default: "Cluster"
										enum: [
											"Cluster",
											"Local",
										]
										type: "string"
									}
									master_dns_name_format: {
										default: "{cluster}.{namespace}.{hostedzone}"
										type:    "string"
									}
									master_legacy_dns_name_format: {
										default: "{cluster}.{team}.{hostedzone}"
										type:    "string"
									}
									replica_dns_name_format: {
										default: "{cluster}-repl.{namespace}.{hostedzone}"
										type:    "string"
									}
									replica_legacy_dns_name_format: {
										default: "{cluster}-repl.{team}.{hostedzone}"
										type:    "string"
									}
								}
								type: "object"
							}
							logging_rest_api: {
								properties: {
									api_port: {
										default: 8080
										type:    "integer"
									}
									cluster_history_entries: {
										default: 1000
										type:    "integer"
									}
									ring_log_lines: {
										default: 100
										type:    "integer"
									}
								}
								type: "object"
							}
							logical_backup: {
								properties: {
									logical_backup_azure_storage_account_key: type: "string"
									logical_backup_azure_storage_account_name: type: "string"
									logical_backup_azure_storage_container: type: "string"
									logical_backup_cpu_limit: {
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									logical_backup_cpu_request: {
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									logical_backup_docker_image: {
										default: "registry.opensource.zalan.do/acid/logical-backup:v1.10.1"
										type:    "string"
									}
									logical_backup_google_application_credentials: type: "string"
									logical_backup_job_prefix: {
										default: "logical-backup-"
										type:    "string"
									}
									logical_backup_memory_limit: {
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									logical_backup_memory_request: {
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									logical_backup_provider: {
										default: "s3"
										enum: [
											"az",
											"gcs",
											"s3",
										]
										type: "string"
									}
									logical_backup_s3_access_key_id: type: "string"
									logical_backup_s3_bucket: type: "string"
									logical_backup_s3_endpoint: type: "string"
									logical_backup_s3_region: type: "string"
									logical_backup_s3_retention_time: type: "string"
									logical_backup_s3_secret_access_key: type: "string"
									logical_backup_s3_sse: type: "string"
									logical_backup_schedule: {
										default: "30 00 * * *"
										pattern: "^(\\d+|\\*)(/\\d+)?(\\s+(\\d+|\\*)(/\\d+)?){4}$"
										type:    "string"
									}
								}
								type: "object"
							}
							major_version_upgrade: {
								properties: {
									major_version_upgrade_mode: {
										default: "off"
										type:    "string"
									}
									major_version_upgrade_team_allow_list: {
										items: type: "string"
										type: "array"
									}
									minimal_major_version: {
										default: "11"
										type:    "string"
									}
									target_major_version: {
										default: "15"
										type:    "string"
									}
								}
								type: "object"
							}
							max_instances: {
								default:     -1
								description: "-1 = disabled"
								minimum:     -1
								type:        "integer"
							}
							min_instances: {
								default:     -1
								description: "-1 = disabled"
								minimum:     -1
								type:        "integer"
							}
							patroni: {
								properties: enable_patroni_failsafe_mode: {
									default: false
									type:    "boolean"
								}
								type: "object"
							}
							postgres_pod_resources: {
								properties: {
									default_cpu_limit: {
										default: "1"
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									default_cpu_request: {
										default: "100m"
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									default_memory_limit: {
										default: "500Mi"
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									default_memory_request: {
										default: "100Mi"
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									max_cpu_request: {
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									max_memory_request: {
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									min_cpu_limit: {
										default: "250m"
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									min_memory_limit: {
										default: "250Mi"
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
								}
								type: "object"
							}
							repair_period: {
								default: "5m"
								type:    "string"
							}
							resync_period: {
								default: "30m"
								type:    "string"
							}
							scalyr: {
								properties: {
									scalyr_api_key: type: "string"
									scalyr_cpu_limit: {
										default: "1"
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									scalyr_cpu_request: {
										default: "100m"
										pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
										type:    "string"
									}
									scalyr_image: type: "string"
									scalyr_memory_limit: {
										default: "500Mi"
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									scalyr_memory_request: {
										default: "50Mi"
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									scalyr_server_url: {
										default: "https://upload.eu.scalyr.com"
										type:    "string"
									}
								}
								type: "object"
							}
							set_memory_request_to_limit: {
								default: false
								type:    "boolean"
							}
							sidecar_docker_images: {
								additionalProperties: type: "string"
								type: "object"
							}
							sidecars: {
								items: {
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								nullable: true
								type:     "array"
							}
							teams_api: {
								properties: {
									enable_admin_role_for_users: {
										default: true
										type:    "boolean"
									}
									enable_postgres_team_crd: {
										default: true
										type:    "boolean"
									}
									enable_postgres_team_crd_superusers: {
										default: false
										type:    "boolean"
									}
									enable_team_member_deprecation: {
										default: false
										type:    "boolean"
									}
									enable_team_superuser: {
										default: false
										type:    "boolean"
									}
									enable_teams_api: {
										default: true
										type:    "boolean"
									}
									pam_configuration: {
										default: "https://info.example.com/oauth2/tokeninfo?access_token= uid realm=/employees"

										type: "string"
									}
									pam_role_name: {
										default: "zalandos"
										type:    "string"
									}
									postgres_superuser_teams: {
										items: type: "string"
										type: "array"
									}
									protected_role_names: {
										default: [
											"admin",
											"cron_admin",
										]
										items: type: "string"
										type: "array"
									}
									role_deletion_suffix: {
										default: "_deleted"
										type:    "string"
									}
									team_admin_role: {
										default: "admin"
										type:    "string"
									}
									team_api_role_configuration: {
										additionalProperties: type: "string"
										default: log_statement: "all"
										type: "object"
									}
									teams_api_url: {
										default: "https://teams.example.com/api/"
										type:    "string"
									}
								}
								type: "object"
							}
							timeouts: {
								properties: {
									patroni_api_check_interval: {
										default: "1s"
										type:    "string"
									}
									patroni_api_check_timeout: {
										default: "5s"
										type:    "string"
									}
									pod_deletion_wait_timeout: {
										default: "10m"
										type:    "string"
									}
									pod_label_wait_timeout: {
										default: "10m"
										type:    "string"
									}
									ready_wait_interval: {
										default: "4s"
										type:    "string"
									}
									ready_wait_timeout: {
										default: "30s"
										type:    "string"
									}
									resource_check_interval: {
										default: "3s"
										type:    "string"
									}
									resource_check_timeout: {
										default: "10m"
										type:    "string"
									}
								}
								type: "object"
							}
							users: {
								properties: {
									additional_owner_roles: {
										items: type: "string"
										nullable: true
										type:     "array"
									}
									enable_password_rotation: {
										default: false
										type:    "boolean"
									}
									password_rotation_interval: {
										default: 90
										type:    "integer"
									}
									password_rotation_user_retention: {
										default: 180
										type:    "integer"
									}
									replication_username: {
										default: "standby"
										type:    "string"
									}
									super_username: {
										default: "postgres"
										type:    "string"
									}
								}
								type: "object"
							}
							workers: {
								default: 8
								minimum: 1
								type:    "integer"
							}
						}
						type: "object"
					}
					kind: {
						enum: ["OperatorConfiguration"]
						type: "string"
					}
					status: {
						additionalProperties: type: "string"
						type: "object"
					}
				}
				required: [
					"kind",
					"apiVersion",
					"configuration",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-school-cluster-postgres-operator": cluster: "postgresqls.acid.zalan.do": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		labels: "app.kubernetes.io/name": "postgres-operator"
		name: "postgresqls.acid.zalan.do"
	}
	spec: {
		group: "acid.zalan.do"
		names: {
			categories: ["all"]
			kind:     "postgresql"
			listKind: "postgresqlList"
			plural:   "postgresqls"
			shortNames: ["pg"]
			singular: "postgresql"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "Team responsible for Postgres cluster"
				jsonPath:    ".spec.teamId"
				name:        "Team"
				type:        "string"
			}, {
				description: "PostgreSQL version"
				jsonPath:    ".spec.postgresql.version"
				name:        "Version"
				type:        "string"
			}, {
				description: "Number of Pods per Postgres cluster"
				jsonPath:    ".spec.numberOfInstances"
				name:        "Pods"
				type:        "integer"
			}, {
				description: "Size of the bound volume"
				jsonPath:    ".spec.volume.size"
				name:        "Volume"
				type:        "string"
			}, {
				description: "Requested CPU for Postgres containers"
				jsonPath:    ".spec.resources.requests.cpu"
				name:        "CPU-Request"
				type:        "string"
			}, {
				description: "Requested memory for Postgres containers"
				jsonPath:    ".spec.resources.requests.memory"
				name:        "Memory-Request"
				type:        "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				description: "Current sync status of postgresql resource"
				jsonPath:    ".status.PostgresClusterStatus"
				name:        "Status"
				type:        "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: {
						enum: ["acid.zalan.do/v1"]
						type: "string"
					}
					kind: {
						enum: ["postgresql"]
						type: "string"
					}
					spec: {
						properties: {
							additionalVolumes: {
								items: {
									properties: {
										mountPath: type: "string"
										name: type: "string"
										subPath: type: "string"
										targetContainers: {
											items: type: "string"
											nullable: true
											type:     "array"
										}
										volumeSource: {
											type:                                   "object"
											"x-kubernetes-preserve-unknown-fields": true
										}
									}
									required: [
										"name",
										"mountPath",
										"volumeSource",
									]
									type: "object"
								}
								type: "array"
							}
							allowedSourceRanges: {
								items: {
									pattern: "^(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d|[1-9]\\d|1\\d\\d|2[0-4]\\d|25[0-5])\\/(\\d|[1-2]\\d|3[0-2])$"
									type:    "string"
								}
								nullable: true
								type:     "array"
							}
							clone: {
								properties: {
									cluster: type: "string"
									s3_access_key_id: type: "string"
									s3_endpoint: type: "string"
									s3_force_path_style: type: "boolean"
									s3_secret_access_key: type: "string"
									s3_wal_path: type: "string"
									timestamp: {
										pattern: "^([0-9]+)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])[Tt]([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9]|60)(\\.[0-9]+)?(([+-]([01][0-9]|2[0-3]):[0-5][0-9]))$"
										type:    "string"
									}
									uid: {
										format: "uuid"
										type:   "string"
									}
								}
								required: ["cluster"]
								type: "object"
							}
							connectionPooler: {
								properties: {
									dockerImage: type: "string"
									maxDBConnections: type: "integer"
									mode: {
										enum: [
											"session",
											"transaction",
										]
										type: "string"
									}
									numberOfInstances: {
										minimum: 1
										type:    "integer"
									}
									resources: {
										properties: {
											limits: {
												properties: {
													cpu: {
														pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
														type:    "string"
													}
													memory: {
														pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
														type:    "string"
													}
												}
												type: "object"
											}
											requests: {
												properties: {
													cpu: {
														pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
														type:    "string"
													}
													memory: {
														pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
														type:    "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									schema: type: "string"
									user: type: "string"
								}
								type: "object"
							}
							databases: {
								additionalProperties: type: "string"
								type: "object"
							}
							dockerImage: type: "string"
							enableConnectionPooler: type: "boolean"
							enableLogicalBackup: type: "boolean"
							enableMasterLoadBalancer: type: "boolean"
							enableMasterPoolerLoadBalancer: type: "boolean"
							enableReplicaConnectionPooler: type: "boolean"
							enableReplicaLoadBalancer: type: "boolean"
							enableReplicaPoolerLoadBalancer: type: "boolean"
							enableShmVolume: type: "boolean"
							env: {
								items: {
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								nullable: true
								type:     "array"
							}
							init_containers: {
								description: "deprecated"
								items: {
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								nullable: true
								type:     "array"
							}
							initContainers: {
								items: {
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								nullable: true
								type:     "array"
							}
							logicalBackupSchedule: {
								pattern: "^(\\d+|\\*)(/\\d+)?(\\s+(\\d+|\\*)(/\\d+)?){4}$"
								type:    "string"
							}
							maintenanceWindows: {
								items: {
									pattern: "^\\ *((Mon|Tue|Wed|Thu|Fri|Sat|Sun):(2[0-3]|[01]?\\d):([0-5]?\\d)|(2[0-3]|[01]?\\d):([0-5]?\\d))-((Mon|Tue|Wed|Thu|Fri|Sat|Sun):(2[0-3]|[01]?\\d):([0-5]?\\d)|(2[0-3]|[01]?\\d):([0-5]?\\d))\\ *$"

									type: "string"
								}
								type: "array"
							}
							masterServiceAnnotations: {
								additionalProperties: type: "string"
								type: "object"
							}
							nodeAffinity: {
								properties: {
									preferredDuringSchedulingIgnoredDuringExecution: {
										items: {
											properties: {
												preference: {
													properties: {
														matchExpressions: {
															items: {
																properties: {
																	key: type: "string"
																	operator: type: "string"
																	values: {
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
														matchFields: {
															items: {
																properties: {
																	key: type: "string"
																	operator: type: "string"
																	values: {
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
													}
													type: "object"
												}
												weight: {
													format: "int32"
													type:   "integer"
												}
											}
											required: [
												"preference",
												"weight",
											]
											type: "object"
										}
										type: "array"
									}
									requiredDuringSchedulingIgnoredDuringExecution: {
										properties: nodeSelectorTerms: {
											items: {
												properties: {
													matchExpressions: {
														items: {
															properties: {
																key: type: "string"
																operator: type: "string"
																values: {
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
													matchFields: {
														items: {
															properties: {
																key: type: "string"
																operator: type: "string"
																values: {
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
												}
												type: "object"
											}
											type: "array"
										}
										required: ["nodeSelectorTerms"]
										type: "object"
									}
								}
								type: "object"
							}
							numberOfInstances: {
								minimum: 0
								type:    "integer"
							}
							patroni: {
								properties: {
									failsafe_mode: type: "boolean"
									initdb: {
										additionalProperties: type: "string"
										type: "object"
									}
									loop_wait: type: "integer"
									maximum_lag_on_failover: type: "integer"
									pg_hba: {
										items: type: "string"
										type: "array"
									}
									retry_timeout: type: "integer"
									slots: {
										additionalProperties: {
											additionalProperties: type: "string"
											type: "object"
										}
										type: "object"
									}
									synchronous_mode: type: "boolean"
									synchronous_mode_strict: type: "boolean"
									synchronous_node_count: type: "integer"
									ttl: type: "integer"
								}
								type: "object"
							}
							pod_priority_class_name: {
								description: "deprecated"
								type:        "string"
							}
							podAnnotations: {
								additionalProperties: type: "string"
								type: "object"
							}
							podPriorityClassName: type: "string"
							postgresql: {
								properties: {
									parameters: {
										additionalProperties: type: "string"
										type: "object"
									}
									version: {
										enum: [
											"10",
											"11",
											"12",
											"13",
											"14",
											"15",
										]
										type: "string"
									}
								}
								required: ["version"]
								type: "object"
							}
							preparedDatabases: {
								additionalProperties: {
									properties: {
										defaultUsers: type: "boolean"
										extensions: {
											additionalProperties: type: "string"
											type: "object"
										}
										schemas: {
											additionalProperties: {
												properties: {
													defaultRoles: type: "boolean"
													defaultUsers: type: "boolean"
												}
												type: "object"
											}
											type: "object"
										}
										secretNamespace: type: "string"
									}
									type: "object"
								}
								type: "object"
							}
							replicaLoadBalancer: {
								description: "deprecated"
								type:        "boolean"
							}
							replicaServiceAnnotations: {
								additionalProperties: type: "string"
								type: "object"
							}
							resources: {
								properties: {
									limits: {
										properties: {
											cpu: {
												pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
												type:    "string"
											}
											memory: {
												pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
												type:    "string"
											}
										}
										type: "object"
									}
									requests: {
										properties: {
											cpu: {
												pattern: "^(\\d+m|\\d+(\\.\\d{1,3})?)$"
												type:    "string"
											}
											memory: {
												pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
												type:    "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							schedulerName: type: "string"
							serviceAnnotations: {
								additionalProperties: type: "string"
								type: "object"
							}
							sidecars: {
								items: {
									type:                                   "object"
									"x-kubernetes-preserve-unknown-fields": true
								}
								nullable: true
								type:     "array"
							}
							spiloFSGroup: type: "integer"
							spiloRunAsGroup: type: "integer"
							spiloRunAsUser: type: "integer"
							standby: {
								oneOf: [{
									required: ["s3_wal_path"]
								}, {
									required: ["gs_wal_path"]
								}, {
									required: ["standby_host"]
								}]
								properties: {
									gs_wal_path: type: "string"
									s3_wal_path: type: "string"
									standby_host: type: "string"
									standby_port: type: "string"
								}
								type: "object"
							}
							streams: {
								items: {
									properties: {
										applicationId: type: "string"
										batchSize: type: "integer"
										database: type: "string"
										filter: {
											additionalProperties: type: "string"
											type: "object"
										}
										tables: {
											additionalProperties: {
												properties: {
													eventType: type: "string"
													idColumn: type: "string"
													payloadColumn: type: "string"
												}
												required: ["eventType"]
												type: "object"
											}
											type: "object"
										}
									}
									required: [
										"applicationId",
										"database",
										"tables",
									]
									type: "object"
								}
								type: "array"
							}
							teamId: type: "string"
							tls: {
								properties: {
									caFile: type: "string"
									caSecretName: type: "string"
									certificateFile: type: "string"
									privateKeyFile: type: "string"
									secretName: type: "string"
								}
								required: ["secretName"]
								type: "object"
							}
							tolerations: {
								items: {
									properties: {
										effect: {
											enum: [
												"NoExecute",
												"NoSchedule",
												"PreferNoSchedule",
											]
											type: "string"
										}
										key: type: "string"
										operator: {
											enum: [
												"Equal",
												"Exists",
											]
											type: "string"
										}
										tolerationSeconds: type: "integer"
										value: type: "string"
									}
									type: "object"
								}
								type: "array"
							}
							useLoadBalancer: {
								description: "deprecated"
								type:        "boolean"
							}
							users: {
								additionalProperties: {
									items: {
										enum: [
											"bypassrls",
											"BYPASSRLS",
											"nobypassrls",
											"NOBYPASSRLS",
											"createdb",
											"CREATEDB",
											"nocreatedb",
											"NOCREATEDB",
											"createrole",
											"CREATEROLE",
											"nocreaterole",
											"NOCREATEROLE",
											"inherit",
											"INHERIT",
											"noinherit",
											"NOINHERIT",
											"login",
											"LOGIN",
											"nologin",
											"NOLOGIN",
											"replication",
											"REPLICATION",
											"noreplication",
											"NOREPLICATION",
											"superuser",
											"SUPERUSER",
											"nosuperuser",
											"NOSUPERUSER",
										]
										type: "string"
									}
									nullable: true
									type:     "array"
								}
								type: "object"
							}
							usersWithInPlaceSecretRotation: {
								items: type: "string"
								nullable: true
								type:     "array"
							}
							usersWithSecretRotation: {
								items: type: "string"
								nullable: true
								type:     "array"
							}
							volume: {
								properties: {
									iops: type: "integer"
									selector: {
										properties: {
											matchExpressions: {
												items: {
													properties: {
														key: type: "string"
														operator: {
															enum: [
																"DoesNotExist",
																"Exists",
																"In",
																"NotIn",
															]
															type: "string"
														}
														values: {
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
												type:                                   "object"
												"x-kubernetes-preserve-unknown-fields": true
											}
										}
										type: "object"
									}
									size: {
										pattern: "^(\\d+(e\\d+)?|\\d+(\\.\\d+)?(e\\d+)?[EPTGMK]i?)$"
										type:    "string"
									}
									storageClass: type: "string"
									subPath: type: "string"
									throughput: type: "integer"
								}
								required: ["size"]
								type: "object"
							}
						}
						required: [
							"numberOfInstances",
							"teamId",
							"postgresql",
							"volume",
						]
						type: "object"
					}
					status: {
						additionalProperties: type: "string"
						type: "object"
					}
				}
				required: [
					"kind",
					"apiVersion",
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
res: customresourcedefinition: "coder-amanibhavam-school-cluster-postgres-operator": cluster: "postgresteams.acid.zalan.do": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		labels: "app.kubernetes.io/name": "postgres-operator"
		name: "postgresteams.acid.zalan.do"
	}
	spec: {
		group: "acid.zalan.do"
		names: {
			categories: ["all"]
			kind:     "PostgresTeam"
			listKind: "PostgresTeamList"
			plural:   "postgresteams"
			shortNames: ["pgteam"]
			singular: "postgresteam"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				properties: {
					apiVersion: {
						enum: ["acid.zalan.do/v1"]
						type: "string"
					}
					kind: {
						enum: ["PostgresTeam"]
						type: "string"
					}
					spec: {
						properties: {
							additionalMembers: {
								additionalProperties: {
									description: "List of users who will also be added to the Postgres cluster"

									items: type: "string"
									nullable: true
									type:     "array"
								}
								description: "Map for teamId and associated additional users"
								type:        "object"
							}
							additionalSuperuserTeams: {
								additionalProperties: {
									description: "List of teams to become Postgres superusers"
									items: type: "string"
									nullable: true
									type:     "array"
								}
								description: "Map for teamId and associated additional superuser teams"
								type:        "object"
							}
							additionalTeams: {
								additionalProperties: {
									description: "List of teams whose members will also be added to the Postgres cluster"

									items: type: "string"
									nullable: true
									type:     "array"
								}
								description: "Map for teamId and associated additional teams"
								type:        "object"
							}
						}
						type: "object"
					}
				}
				required: [
					"kind",
					"apiVersion",
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
res: serviceaccount: "coder-amanibhavam-school-cluster-postgres-operator": "postgres-operator": "postgres-operator": {
	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "postgres-operator"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "postgres-operator"
			"helm.sh/chart":                "postgres-operator-1.10.1"
		}
		name:      "postgres-operator"
		namespace: "postgres-operator"
	}
}
res: clusterrole: "coder-amanibhavam-school-cluster-postgres-operator": cluster: "postgres-operator": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "postgres-operator"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "postgres-operator"
			"helm.sh/chart":                "postgres-operator-1.10.1"
		}
		name: "postgres-operator"
	}
	rules: [{
		apiGroups: ["acid.zalan.do"]
		resources: [
			"postgresqls",
			"postgresqls/status",
			"operatorconfigurations",
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
	}, {
		apiGroups: ["acid.zalan.do"]
		resources: ["postgresteams"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["apiextensions.k8s.io"]
		resources: ["customresourcedefinitions"]
		verbs: [
			"get",
			"create",
			"patch",
			"update",
		]
	}, {
		apiGroups: [""]
		resources: ["events"]
		verbs: [
			"create",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["configmaps"]
		verbs: ["get"]
	}, {
		apiGroups: [""]
		resources: ["endpoints"]
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
	}, {
		apiGroups: [""]
		resources: ["secrets"]
		verbs: [
			"create",
			"delete",
			"get",
			"update",
		]
	}, {
		apiGroups: [""]
		resources: ["nodes"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumeclaims"]
		verbs: [
			"delete",
			"get",
			"list",
			"patch",
			"update",
		]
	}, {
		apiGroups: [""]
		resources: ["persistentvolumes"]
		verbs: [
			"get",
			"list",
		]
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"delete",
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["pods/exec"]
		verbs: ["create"]
	}, {
		apiGroups: [""]
		resources: ["services"]
		verbs: [
			"create",
			"delete",
			"get",
			"patch",
			"update",
		]
	}, {
		apiGroups: ["apps"]
		resources: [
			"statefulsets",
			"deployments",
		]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
		]
	}, {
		apiGroups: ["batch"]
		resources: ["cronjobs"]
		verbs: [
			"create",
			"delete",
			"get",
			"list",
			"patch",
			"update",
		]
	}, {
		apiGroups: [""]
		resources: ["namespaces"]
		verbs: ["get"]
	}, {
		apiGroups: ["policy"]
		resources: ["poddisruptionbudgets"]
		verbs: [
			"create",
			"delete",
			"get",
		]
	}, {
		apiGroups: [""]
		resources: ["serviceaccounts"]
		verbs: [
			"get",
			"create",
		]
	}, {
		apiGroups: ["rbac.authorization.k8s.io"]
		resources: ["rolebindings"]
		verbs: [
			"get",
			"create",
		]
	}]
}
res: clusterrole: "coder-amanibhavam-school-cluster-postgres-operator": cluster: "postgres-pod": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "postgres-operator"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "postgres-operator"
			"helm.sh/chart":                "postgres-operator-1.10.1"
		}
		name: "postgres-pod"
	}
	rules: [{
		apiGroups: [""]
		resources: ["endpoints"]
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
	}, {
		apiGroups: [""]
		resources: ["pods"]
		verbs: [
			"get",
			"list",
			"patch",
			"update",
			"watch",
		]
	}, {
		apiGroups: [""]
		resources: ["services"]
		verbs: ["create"]
	}]
}
res: clusterrolebinding: "coder-amanibhavam-school-cluster-postgres-operator": cluster: "postgres-operator": {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRoleBinding"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "postgres-operator"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "postgres-operator"
			"helm.sh/chart":                "postgres-operator-1.10.1"
		}
		name: "postgres-operator"
	}
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "postgres-operator"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "postgres-operator"
		namespace: "postgres-operator"
	}]
}
res: service: "coder-amanibhavam-school-cluster-postgres-operator": "postgres-operator": "postgres-operator": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "postgres-operator"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "postgres-operator"
			"helm.sh/chart":                "postgres-operator-1.10.1"
		}
		name:      "postgres-operator"
		namespace: "postgres-operator"
	}
	spec: {
		ports: [{
			port:       8080
			protocol:   "TCP"
			targetPort: 8080
		}]
		selector: {
			"app.kubernetes.io/instance": "postgres-operator"
			"app.kubernetes.io/name":     "postgres-operator"
		}
		type: "ClusterIP"
	}
}
res: deployment: "coder-amanibhavam-school-cluster-postgres-operator": "postgres-operator": "postgres-operator": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "postgres-operator"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "postgres-operator"
			"helm.sh/chart":                "postgres-operator-1.10.1"
		}
		name:      "postgres-operator"
		namespace: "postgres-operator"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			"app.kubernetes.io/instance": "postgres-operator"
			"app.kubernetes.io/name":     "postgres-operator"
		}
		template: {
			metadata: {
				annotations: "checksum/config": "8a272a88b75d58e2d41edf5e72199c4025a5c6a1adcfa7e5c0b5871240ed44fa"
				labels: {
					"app.kubernetes.io/instance": "postgres-operator"
					"app.kubernetes.io/name":     "postgres-operator"
				}
			}
			spec: {
				affinity: {}
				containers: [{
					env: [{
						name:  "POSTGRES_OPERATOR_CONFIGURATION_OBJECT"
						value: "postgres-operator"
					}]
					image:           "registry.opensource.zalan.do/acid/postgres-operator:v1.10.1"
					imagePullPolicy: "IfNotPresent"
					name:            "postgres-operator"
					readinessProbe: {
						httpGet: {
							path: "/readyz"
							port: 8080
						}
						initialDelaySeconds: 5
						periodSeconds:       10
					}
					resources: {
						limits: {
							cpu:    "500m"
							memory: "500Mi"
						}
						requests: {
							cpu:    "100m"
							memory: "250Mi"
						}
					}
					securityContext: {
						allowPrivilegeEscalation: false
						readOnlyRootFilesystem:   true
						runAsNonRoot:             true
						runAsUser:                1000
					}
				}]
				nodeSelector: {}
				serviceAccountName: "postgres-operator"
				tolerations: []
			}
		}
	}
}
res: operatorconfiguration: "coder-amanibhavam-school-cluster-postgres-operator": "postgres-operator": "postgres-operator": {
	apiVersion: "acid.zalan.do/v1"
	configuration: {
		aws_or_gcp: {
			aws_region:               "eu-central-1"
			enable_ebs_gp3_migration: false
		}
		connection_pooler: {
			connection_pooler_default_cpu_limit:      "1"
			connection_pooler_default_cpu_request:    "500m"
			connection_pooler_default_memory_limit:   "100Mi"
			connection_pooler_default_memory_request: "100Mi"
			connection_pooler_image:                  "registry.opensource.zalan.do/acid/pgbouncer:master-27"
			connection_pooler_max_db_connections:     60
			connection_pooler_mode:                   "transaction"
			connection_pooler_number_of_instances:    2
			connection_pooler_schema:                 "pooler"
			connection_pooler_user:                   "pooler"
		}
		crd_categories: ["all"]
		debug: {
			debug_logging:          true
			enable_database_access: true
		}
		docker_image:                      "ghcr.io/zalando/spilo-15:3.0-p1"
		enable_crd_registration:           true
		enable_lazy_spilo_upgrade:         false
		enable_pgversion_env_var:          true
		enable_shm_volume:                 true
		enable_spilo_wal_path_compat:      false
		enable_team_id_clustername_prefix: false
		etcd_host:                         ""
		kubernetes: {
			cluster_domain: "cluster.local"
			cluster_labels: application: "spilo"
			cluster_name_label:                           "cluster-name"
			enable_cross_namespace_secret:                false
			enable_init_containers:                       true
			enable_pod_antiaffinity:                      false
			enable_pod_disruption_budget:                 true
			enable_readiness_probe:                       false
			enable_sidecars:                              true
			oauth_token_secret_name:                      "postgres-operator"
			pdb_name_format:                              "postgres-{cluster}-pdb"
			pod_antiaffinity_preferred_during_scheduling: false
			pod_antiaffinity_topology_key:                "kubernetes.io/hostname"
			pod_management_policy:                        "ordered_ready"
			pod_role_label:                               "spilo-role"
			pod_service_account_name:                     "postgres-pod"
			pod_terminate_grace_period:                   "5m"
			secret_name_template:                         "{username}.{cluster}.credentials.{tprkind}.{tprgroup}"
			share_pgsocket_with_sidecars:                 false
			spilo_allow_privilege_escalation:             true
			spilo_privileged:                             false
			storage_resize_mode:                          "pvc"
			watched_namespace:                            "*"
		}
		load_balancer: {
			db_hosted_zone:                      "db.example.com"
			enable_master_load_balancer:         false
			enable_master_pooler_load_balancer:  false
			enable_replica_load_balancer:        false
			enable_replica_pooler_load_balancer: false
			external_traffic_policy:             "Cluster"
			master_dns_name_format:              "{cluster}.{namespace}.{hostedzone}"
			master_legacy_dns_name_format:       "{cluster}.{team}.{hostedzone}"
			replica_dns_name_format:             "{cluster}-repl.{namespace}.{hostedzone}"
			replica_legacy_dns_name_format:      "{cluster}-repl.{team}.{hostedzone}"
		}
		logging_rest_api: {
			api_port:                8080
			cluster_history_entries: 1000
			ring_log_lines:          100
		}
		logical_backup: {
			logical_backup_docker_image:         "registry.opensource.zalan.do/acid/logical-backup:v1.10.1"
			logical_backup_job_prefix:           "logical-backup-"
			logical_backup_provider:             "s3"
			logical_backup_s3_access_key_id:     ""
			logical_backup_s3_bucket:            "my-bucket-url"
			logical_backup_s3_endpoint:          ""
			logical_backup_s3_region:            ""
			logical_backup_s3_retention_time:    ""
			logical_backup_s3_secret_access_key: ""
			logical_backup_s3_sse:               "AES256"
			logical_backup_schedule:             "30 00 * * *"
		}
		major_version_upgrade: {
			major_version_upgrade_mode: "off"
			minimal_major_version:      "11"
			target_major_version:       "15"
		}
		max_instances: -1
		min_instances: -1
		patroni: enable_patroni_failsafe_mode: false
		postgres_pod_resources: {
			default_cpu_limit:      "1"
			default_cpu_request:    "100m"
			default_memory_limit:   "500Mi"
			default_memory_request: "100Mi"
			min_cpu_limit:          "250m"
			min_memory_limit:       "250Mi"
		}
		repair_period: "5m"
		resync_period: "30m"
		teams_api: {
			enable_admin_role_for_users:         true
			enable_postgres_team_crd:            false
			enable_postgres_team_crd_superusers: false
			enable_team_member_deprecation:      false
			enable_team_superuser:               false
			enable_teams_api:                    false
			pam_role_name:                       "zalandos"
			postgres_superuser_teams: ["postgres_superusers"]
			protected_role_names: [
				"admin",
				"cron_admin",
			]
			role_deletion_suffix: "_deleted"
			team_admin_role:      "admin"
			team_api_role_configuration: log_statement: "all"
		}
		timeouts: {
			patroni_api_check_interval: "1s"
			patroni_api_check_timeout:  "5s"
			pod_deletion_wait_timeout:  "10m"
			pod_label_wait_timeout:     "10m"
			ready_wait_interval:        "3s"
			ready_wait_timeout:         "30s"
			resource_check_interval:    "3s"
			resource_check_timeout:     "10m"
		}
		users: {
			enable_password_rotation:         false
			password_rotation_interval:       90
			password_rotation_user_retention: 180
			replication_username:             "standby"
			super_username:                   "postgres"
		}
		workers: 8
	}
	kind: "OperatorConfiguration"
	metadata: {
		labels: {
			"app.kubernetes.io/instance":   "postgres-operator"
			"app.kubernetes.io/managed-by": "Helm"
			"app.kubernetes.io/name":       "postgres-operator"
			"helm.sh/chart":                "postgres-operator-1.10.1"
		}
		name:      "postgres-operator"
		namespace: "postgres-operator"
	}
}