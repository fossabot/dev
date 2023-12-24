package y

res: namespace: "coder-amanibhavam-district-cluster-harbor": cluster: harbor: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "harbor"
}
res: configmap: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-core": {
	apiVersion: "v1"
	data: {
		"_REDIS_URL_CORE":                        "redis://harbor-redis:6379/0?idle_timeout_seconds=30"
		"_REDIS_URL_REG":                         "redis://harbor-redis:6379/2?idle_timeout_seconds=30"
		CHART_CACHE_DRIVER:                       "redis"
		CONFIG_PATH:                              "/etc/core/app.conf"
		CORE_LOCAL_URL:                           "http://127.0.0.1:8080"
		CORE_URL:                                 "http://harbor-core:80"
		DATABASE_TYPE:                            "postgresql"
		EXT_ENDPOINT:                             "https://harbor.district.amanibhavam.defn.run"
		HTTP_PROXY:                               ""
		HTTPS_PROXY:                              ""
		JOBSERVICE_URL:                           "http://harbor-jobservice"
		LOG_LEVEL:                                "info"
		NO_PROXY:                                 "harbor-core,harbor-jobservice,harbor-database,harbor-registry,harbor-portal,harbor-trivy,harbor-exporter,127.0.0.1,localhost,.local,.internal"
		PERMITTED_REGISTRY_TYPES_FOR_PROXY_CACHE: "docker-hub,harbor,azure-acr,aws-ecr,google-gcr,quay,docker-registry,github-ghcr,jfrog-artifactory"
		PORT:                                     "8080"
		PORTAL_URL:                               "http://harbor-portal"
		POSTGRESQL_DATABASE:                      "registry"
		POSTGRESQL_HOST:                          "harbor-database"
		POSTGRESQL_MAX_IDLE_CONNS:                "100"
		POSTGRESQL_MAX_OPEN_CONNS:                "900"
		POSTGRESQL_PORT:                          "5432"
		POSTGRESQL_SSLMODE:                       "disable"
		POSTGRESQL_USERNAME:                      "postgres"
		QUOTA_UPDATE_PROVIDER:                    "db"
		REGISTRY_CONTROLLER_URL:                  "http://harbor-registry:8080"
		REGISTRY_CREDENTIAL_USERNAME:             "harbor_registry_user"
		REGISTRY_STORAGE_PROVIDER_NAME:           "filesystem"
		REGISTRY_URL:                             "http://harbor-registry:5000"
		TOKEN_SERVICE_URL:                        "http://harbor-core:80/service/token"
		TRIVY_ADAPTER_URL:                        "http://harbor-trivy:8080"
		WITH_TRIVY:                               "true"
		"app.conf": """
			appname = Harbor
			runmode = prod
			enablegzip = true

			[prod]
			httpport = 8080

			"""
	}

	kind: "ConfigMap"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-core"
		namespace: "harbor"
	}
}
res: configmap: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-jobservice": {
	apiVersion: "v1"
	data: "config.yml": """
		#Server listening port
		protocol: \"http\"
		port: 8080
		worker_pool:
		  workers: 10
		  backend: \"redis\"
		  redis_pool:
		    redis_url: \"redis://harbor-redis:6379/1\"
		    namespace: \"harbor_job_service_namespace\"
		    idle_timeout_second: 3600
		job_loggers:
		  - name: \"FILE\"
		    level: INFO
		    settings: # Customized settings of logger
		      base_dir: \"/var/log/jobs\"
		    sweeper:
		      duration: 14 #days
		      settings: # Customized settings of sweeper
		        work_dir: \"/var/log/jobs\"
		metric:
		  enabled: false
		  path: /metrics
		  port: 8001
		#Loggers for the job service
		loggers:
		  - name: \"STD_OUTPUT\"
		    level: INFO
		reaper:
		  # the max time to wait for a task to finish, if unfinished after max_update_hours, the task will be mark as error, but the task will continue to run, default value is 24
		  max_update_hours: 24
		  # the max time for execution in running state without new task created
		  max_dangling_hours: 168

		"""

	kind: "ConfigMap"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-jobservice"
		namespace: "harbor"
	}
}
res: configmap: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-jobservice-env": {
	apiVersion: "v1"
	data: {
		CORE_URL:                                   "http://harbor-core:80"
		HTTP_PROXY:                                 ""
		HTTPS_PROXY:                                ""
		JOBSERVICE_WEBHOOK_JOB_HTTP_CLIENT_TIMEOUT: "3"
		JOBSERVICE_WEBHOOK_JOB_MAX_RETRY:           "3"
		NO_PROXY:                                   "harbor-core,harbor-jobservice,harbor-database,harbor-registry,harbor-portal,harbor-trivy,harbor-exporter,127.0.0.1,localhost,.local,.internal"
		REGISTRY_CONTROLLER_URL:                    "http://harbor-registry:8080"
		REGISTRY_CREDENTIAL_USERNAME:               "harbor_registry_user"
		REGISTRY_URL:                               "http://harbor-registry:5000"
		TOKEN_SERVICE_URL:                          "http://harbor-core:80/service/token"
	}
	kind: "ConfigMap"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-jobservice-env"
		namespace: "harbor"
	}
}
res: configmap: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-portal": {
	apiVersion: "v1"
	data: "nginx.conf": """
		worker_processes auto;
		pid /tmp/nginx.pid;
		events {
		    worker_connections  1024;
		}
		http {
		    client_body_temp_path /tmp/client_body_temp;
		    proxy_temp_path /tmp/proxy_temp;
		    fastcgi_temp_path /tmp/fastcgi_temp;
		    uwsgi_temp_path /tmp/uwsgi_temp;
		    scgi_temp_path /tmp/scgi_temp;
		    server {
		        listen 8080;
		        listen [::]:8080;
		        server_name  localhost;
		        root   /usr/share/nginx/html;
		        index  index.html index.htm;
		        include /etc/nginx/mime.types;
		        gzip on;
		        gzip_min_length 1000;
		        gzip_proxied expired no-cache no-store private auth;
		        gzip_types text/plain text/css application/json application/javascript application/x-javascript text/xml application/xml application/xml+rss text/javascript;
		        location /devcenter-api-2.0 {
		            try_files $uri $uri/ /swagger-ui-index.html;
		        }
		        location / {
		            try_files $uri $uri/ /index.html;
		        }
		        location = /index.html {
		            add_header Cache-Control \"no-store, no-cache, must-revalidate\";
		        }
		    }
		}

		"""

	kind: "ConfigMap"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-portal"
		namespace: "harbor"
	}
}
res: configmap: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registry": {
	apiVersion: "v1"
	data: {
		"config.yml": """
			version: 0.1
			log:
			  level: info
			  fields:
			    service: registry
			storage:
			  filesystem:
			    rootdirectory: /storage
			  cache:
			    layerinfo: redis
			  maintenance:
			    uploadpurging:
			      enabled: true
			      age: 168h
			      interval: 24h
			      dryrun: false
			  delete:
			    enabled: true
			  redirect:
			    disable: false
			redis:
			  addr: harbor-redis:6379
			  db: 2
			  readtimeout: 10s
			  writetimeout: 10s
			  dialtimeout: 10s
			  pool:
			    maxidle: 100
			    maxactive: 500
			    idletimeout: 60s
			http:
			  addr: :5000
			  relativeurls: false
			  # set via environment variable
			  # secret: placeholder
			  debug:
			    addr: localhost:5001
			auth:
			  htpasswd:
			    realm: harbor-registry-basic-realm
			    path: /etc/registry/passwd
			validation:
			  disabled: true
			compatibility:
			  schema1:
			    enabled: true

			"""

		"ctl-config.yml": """
			---
			protocol: \"http\"
			port: 8080
			log_level: info
			registry_config: \"/etc/registry/config.yml\"

			"""
	}

	kind: "ConfigMap"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-registry"
		namespace: "harbor"
	}
}
res: configmap: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registryctl": {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-registryctl"
		namespace: "harbor"
	}
}
res: secret: "coder-amanibhavam-district-cluster-harbor": harbor: "ignore-core": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "ignore-core"
		namespace: "harbor"
	}
	type: "Opaque"
}
res: secret: "coder-amanibhavam-district-cluster-harbor": harbor: "ignore-database": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "ignore-database"
		namespace: "harbor"
	}
	type: "Opaque"
}
res: secret: "coder-amanibhavam-district-cluster-harbor": harbor: "ignore-jobservice": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "ignore-jobservice"
		namespace: "harbor"
	}
	type: "Opaque"
}
res: secret: "coder-amanibhavam-district-cluster-harbor": harbor: "ignore-registry": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "ignore-registry"
		namespace: "harbor"
	}
	type: "Opaque"
}
res: secret: "coder-amanibhavam-district-cluster-harbor": harbor: "ignore-registry-htpasswd": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "ignore-registry-htpasswd"
		namespace: "harbor"
	}
	type: "Opaque"
}
res: secret: "coder-amanibhavam-district-cluster-harbor": harbor: "ignore-registryctl": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "ignore-registryctl"
		namespace: "harbor"
	}
	type: "Opaque"
}
res: secret: "coder-amanibhavam-district-cluster-harbor": harbor: "ignore-trivy": {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "ignore-trivy"
		namespace: "harbor"
	}
	type: "Opaque"
}
res: service: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-core": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-core"
		namespace: "harbor"
	}
	spec: {
		ports: [{
			name:       "http-web"
			port:       80
			targetPort: 8080
		}]
		selector: {
			app:       "harbor"
			component: "core"
			release:   "harbor"
		}
	}
}
res: service: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-database": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-database"
		namespace: "harbor"
	}
	spec: {
		ports: [{
			port: 5432
		}]
		selector: {
			app:       "harbor"
			component: "database"
			release:   "harbor"
		}
	}
}
res: service: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-jobservice": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-jobservice"
		namespace: "harbor"
	}
	spec: {
		ports: [{
			name:       "http-jobservice"
			port:       80
			targetPort: 8080
		}]
		selector: {
			app:       "harbor"
			component: "jobservice"
			release:   "harbor"
		}
	}
}
res: service: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-portal": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-portal"
		namespace: "harbor"
	}
	spec: {
		ports: [{
			port:       80
			targetPort: 8080
		}]
		selector: {
			app:       "harbor"
			component: "portal"
			release:   "harbor"
		}
	}
}
res: service: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-redis": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-redis"
		namespace: "harbor"
	}
	spec: {
		ports: [{
			port: 6379
		}]
		selector: {
			app:       "harbor"
			component: "redis"
			release:   "harbor"
		}
	}
}
res: service: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registry": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-registry"
		namespace: "harbor"
	}
	spec: {
		ports: [{
			name: "http-registry"
			port: 5000
		}, {
			name: "http-controller"
			port: 8080
		}]
		selector: {
			app:       "harbor"
			component: "registry"
			release:   "harbor"
		}
	}
}
res: service: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-trivy": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-trivy"
		namespace: "harbor"
	}
	spec: {
		ports: [{
			name:     "http-trivy"
			port:     8080
			protocol: "TCP"
		}]
		selector: {
			app:       "harbor"
			component: "trivy"
			release:   "harbor"
		}
	}
}
res: persistentvolumeclaim: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-jobservice": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "jobservice"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-jobservice"
		namespace: "harbor"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "1Gi"
	}
}
res: persistentvolumeclaim: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registry": {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		annotations: "helm.sh/resource-policy": "keep"
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "registry"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-registry"
		namespace: "harbor"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "5Gi"
	}
}
res: deployment: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-core": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "core"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-core"
		namespace: "harbor"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			app:       "harbor"
			component: "core"
			release:   "harbor"
		}
		template: {
			metadata: {
				annotations: {
					"checksum/configmap":         "d1ac6f3afbe79d73141d586627234519352376404b0319f83b7aa9c4a45d8ba8"
					"checksum/secret":            ""
					"checksum/secret-jobservice": ""
				}
				labels: {
					app:       "harbor"
					component: "core"
					name:      "harbor-core"
					release:   "harbor"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					env: [{
						name: "CORE_SECRET"
						valueFrom: secretKeyRef: {
							key:  "secret"
							name: "external-harbor-core"
						}
					}, {
						name: "JOBSERVICE_SECRET"
						valueFrom: secretKeyRef: {
							key:  "JOBSERVICE_SECRET"
							name: "external-harbor-jobservice"
						}
					}, {
						name: "HARBOR_ADMIN_PASSWORD"
						valueFrom: secretKeyRef: {
							key:  "harbor_admin_password"
							name: "external-harbor-admin"
						}
					}]
					envFrom: [{
						configMapRef: name: "harbor-core"
					}, {
						secretRef: name: "external-harbor-core"
					}]
					image:           "goharbor/harbor-core:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 2
						httpGet: {
							path:   "/api/v2.0/ping"
							port:   8080
							scheme: "HTTP"
						}
						periodSeconds: 10
					}
					name: "core"
					ports: [{
						containerPort: 8080
					}]
					readinessProbe: {
						failureThreshold: 2
						httpGet: {
							path:   "/api/v2.0/ping"
							port:   8080
							scheme: "HTTP"
						}
						periodSeconds: 10
					}
					startupProbe: {
						failureThreshold: 360
						httpGet: {
							path:   "/api/v2.0/ping"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 10
						periodSeconds:       10
					}
					volumeMounts: [{
						mountPath: "/etc/core/app.conf"
						name:      "config"
						subPath:   "app.conf"
					}, {
						mountPath: "/etc/core/key"
						name:      "secret-key"
						subPath:   "key"
					}, {
						mountPath: "/etc/core/private_key.pem"
						name:      "token-service-private-key"
						subPath:   "tls.key"
					}, {
						mountPath: "/etc/core/ca"
						name:      "ca-download"
					}, {
						mountPath: "/etc/core/token"
						name:      "psc"
					}]
				}]
				securityContext: {
					fsGroup:   10000
					runAsUser: 10000
				}
				terminationGracePeriodSeconds: 120
				volumes: [{
					configMap: {
						items: [{
							key:  "app.conf"
							path: "app.conf"
						}]
						name: "harbor-core"
					}
					name: "config"
				}, {
					name: "secret-key"
					secret: {
						items: [{
							key:  "secretKey"
							path: "key"
						}]
						secretName: "external-harbor-core"
					}
				}, {
					name: "token-service-private-key"
					secret: secretName: "external-harbor-core"
				}, {
					name:   "ca-download"
				}, {
					emptyDir: {}
					name: "psc"
				}]
			}
		}
	}
}
res: deployment: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-jobservice": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "jobservice"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-jobservice"
		namespace: "harbor"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			app:       "harbor"
			component: "jobservice"
			release:   "harbor"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: {
				annotations: {
					"checksum/configmap":     "cc0e1292cee3c8425c958aeee30046a701a7b3e32ce7b5d3751cceebea93e2f3"
					"checksum/configmap-env": "52de7676d9ac66bda6ec9e57e3274d89d9b22ddea971c927ebb81964b680f5df"
					"checksum/secret":        ""
					"checksum/secret-core":   ""
				}
				labels: {
					app:       "harbor"
					chart:     "harbor"
					component: "jobservice"
					heritage:  "Helm"
					name:      "harbor-jobservice"
					release:   "harbor"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					env: [{
						name: "CORE_SECRET"
						valueFrom: secretKeyRef: {
							key:  "secret"
							name: "external-harbor-core"
						}
					}]
					envFrom: [{
						configMapRef: name: "harbor-jobservice-env"
					}, {
						secretRef: name: "external-harbor-jobservice"
					}]
					image:           "goharbor/harbor-jobservice:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						httpGet: {
							path:   "/api/v1/stats"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 300
						periodSeconds:       10
					}
					name: "jobservice"
					ports: [{
						containerPort: 8080
					}]
					readinessProbe: {
						httpGet: {
							path:   "/api/v1/stats"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 20
						periodSeconds:       10
					}
					volumeMounts: [{
						mountPath: "/etc/jobservice/config.yml"
						name:      "jobservice-config"
						subPath:   "config.yml"
					}, {
						mountPath: "/var/log/jobs"
						name:      "job-logs"
					}]
				}]
				securityContext: {
					fsGroup:   10000
					runAsUser: 10000
				}
				terminationGracePeriodSeconds: 120
				volumes: [{
					configMap: name: "harbor-jobservice"
					name: "jobservice-config"
				}, {
					name: "job-logs"
					persistentVolumeClaim: claimName: "harbor-jobservice"
				}]
			}
		}
	}
}
res: deployment: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-portal": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "portal"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-portal"
		namespace: "harbor"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			app:       "harbor"
			component: "portal"
			release:   "harbor"
		}
		template: {
			metadata: {
				annotations: "checksum/configmap": "81e3c496ae5701420a27d38fd5d8a908c1ba48909fbc7d774e6325c925e5b224"
				labels: {
					app:       "harbor"
					component: "portal"
					release:   "harbor"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					image:           "goharbor/harbor-portal:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						httpGet: {
							path:   "/"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 300
						periodSeconds:       10
					}
					name: "portal"
					ports: [{
						containerPort: 8080
					}]
					readinessProbe: {
						httpGet: {
							path:   "/"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 1
						periodSeconds:       10
					}
					volumeMounts: [{
						mountPath: "/etc/nginx/nginx.conf"
						name:      "portal-config"
						subPath:   "nginx.conf"
					}]
				}]
				securityContext: {
					fsGroup:   10000
					runAsUser: 10000
				}
				volumes: [{
					configMap: name: "harbor-portal"
					name: "portal-config"
				}]
			}
		}
	}
}
res: deployment: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registry": {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "registry"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-registry"
		namespace: "harbor"
	}
	spec: {
		replicas:             1
		revisionHistoryLimit: 10
		selector: matchLabels: {
			app:       "harbor"
			component: "registry"
			release:   "harbor"
		}
		strategy: type: "RollingUpdate"
		template: {
			metadata: {
				annotations: {
					"checksum/configmap":         "1dd422c1f80f9b0e00e1a2297e956c1da3fb1d6bc24892179accf38bc1e3be96"
					"checksum/secret":            ""
					"checksum/secret-core":       ""
					"checksum/secret-jobservice": ""
				}
				labels: {
					app:       "harbor"
					chart:     "harbor"
					component: "registry"
					heritage:  "Helm"
					name:      "harbor-registry"
					release:   "harbor"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					args: [
						"serve",
						"/etc/registry/config.yml",
					]
					envFrom: [{
						secretRef: name: "external-harbor-registry"
					}]
					image:           "goharbor/registry-photon:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						httpGet: {
							path:   "/"
							port:   5000
							scheme: "HTTP"
						}
						initialDelaySeconds: 300
						periodSeconds:       10
					}
					name: "registry"
					ports: [{
						containerPort: 5000
					}, {
						containerPort: 5001
					}]
					readinessProbe: {
						httpGet: {
							path:   "/"
							port:   5000
							scheme: "HTTP"
						}
						initialDelaySeconds: 1
						periodSeconds:       10
					}
					volumeMounts: [{
						mountPath: "/storage"
						name:      "registry-data"
					}, {
						mountPath: "/etc/registry/passwd"
						name:      "registry-htpasswd"
						subPath:   "passwd"
					}, {
						mountPath: "/etc/registry/config.yml"
						name:      "registry-config"
						subPath:   "config.yml"
					}]
				}, {
					env: [{
						name: "CORE_SECRET"
						valueFrom: secretKeyRef: {
							key:  "secret"
							name: "external-harbor-core"
						}
					}, {
						name: "JOBSERVICE_SECRET"
						valueFrom: secretKeyRef: {
							key:  "JOBSERVICE_SECRET"
							name: "external-harbor-jobservice"
						}
					}]
					envFrom: [{
						configMapRef: name: "harbor-registryctl"
					}, {
						secretRef: name: "external-harbor-registry"
					}, {
						secretRef: name: "external-harbor-registryctl"
					}]
					image:           "goharbor/harbor-registryctl:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						httpGet: {
							path:   "/api/health"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 300
						periodSeconds:       10
					}
					name: "registryctl"
					ports: [{
						containerPort: 8080
					}]
					readinessProbe: {
						httpGet: {
							path:   "/api/health"
							port:   8080
							scheme: "HTTP"
						}
						initialDelaySeconds: 1
						periodSeconds:       10
					}
					volumeMounts: [{
						mountPath: "/storage"
						name:      "registry-data"
					}, {
						mountPath: "/etc/registry/config.yml"
						name:      "registry-config"
						subPath:   "config.yml"
					}, {
						mountPath: "/etc/registryctl/config.yml"
						name:      "registry-config"
						subPath:   "ctl-config.yml"
					}]
				}]
				securityContext: {
					fsGroup:             10000
					fsGroupChangePolicy: "OnRootMismatch"
					runAsUser:           10000
				}
				terminationGracePeriodSeconds: 120
				volumes: [{
					name: "registry-htpasswd"
					secret: {
						items: [{
							key:  "REGISTRY_HTPASSWD"
							path: "passwd"
						}]
						secretName: "external-harbor-registry-htpasswd"
					}
				}, {
					configMap: name: "harbor-registry"
					name: "registry-config"
				}, {
					name: "registry-data"
					persistentVolumeClaim: claimName: "harbor-registry"
				}]
			}
		}
	}
}
res: statefulset: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-database": {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	metadata: {
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "database"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-database"
		namespace: "harbor"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			app:       "harbor"
			component: "database"
			release:   "harbor"
		}
		serviceName: "harbor-database"
		template: {
			metadata: {
				annotations: "checksum/secret": "55b1e7be0855a53d12362dc11834f575bd16ba09cdd84b0551bda85635e15ac1"
				labels: {
					app:       "harbor"
					chart:     "harbor"
					component: "database"
					heritage:  "Helm"
					name:      "harbor-database"
					release:   "harbor"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					env: [{
						name:  "PGDATA"
						value: "/var/lib/postgresql/data/pgdata"
					}]
					envFrom: [{
						secretRef: name: "external-harbor-database"
					}]
					image:           "goharbor/harbor-db:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						exec: command: ["/docker-healthcheck.sh"]
						initialDelaySeconds: 300
						periodSeconds:       10
						timeoutSeconds:      1
					}
					name: "database"
					readinessProbe: {
						exec: command: ["/docker-healthcheck.sh"]
						initialDelaySeconds: 1
						periodSeconds:       10
						timeoutSeconds:      1
					}
					volumeMounts: [{
						mountPath: "/var/lib/postgresql/data"
						name:      "database-data"
					}, {
						mountPath: "/dev/shm"
						name:      "shm-volume"
					}]
				}]
				initContainers: [{
					args: [
						"-c",
						"[ -e /var/lib/postgresql/data/postgresql.conf ] && [ ! -d /var/lib/postgresql/data/pgdata ] && mkdir -m 0700 /var/lib/postgresql/data/pgdata && mv /var/lib/postgresql/data/* /var/lib/postgresql/data/pgdata/ || true",
					]

					command: ["/bin/sh"]
					image:           "goharbor/harbor-db:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					name:            "data-migrator"
					volumeMounts: [{
						mountPath: "/var/lib/postgresql/data"
						name:      "database-data"
					}]
				}, {
					args: [
						"-c",
						"chmod -R 700 /var/lib/postgresql/data/pgdata || true",
					]
					command: ["/bin/sh"]
					image:           "goharbor/harbor-db:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					name:            "data-permissions-ensurer"
					volumeMounts: [{
						mountPath: "/var/lib/postgresql/data"
						name:      "database-data"
					}]
				}]
				securityContext: {
					fsGroup:   999
					runAsUser: 999
				}
				terminationGracePeriodSeconds: 120
				volumes: [{
					emptyDir: {
						medium:    "Memory"
						sizeLimit: "512Mi"
					}
					name: "shm-volume"
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: {
				labels: {
					app:      "harbor"
					chart:    "harbor"
					heritage: "Helm"
					release:  "harbor"
				}
				name: "database-data"
			}
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "1Gi"
			}
		}]
	}
}
res: statefulset: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-redis": {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	metadata: {
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "redis"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-redis"
		namespace: "harbor"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			app:       "harbor"
			component: "redis"
			release:   "harbor"
		}
		serviceName: "harbor-redis"
		template: {
			metadata: labels: {
				app:       "harbor"
				chart:     "harbor"
				component: "redis"
				heritage:  "Helm"
				name:      "harbor-redis"
				release:   "harbor"
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					image:           "goharbor/redis-photon:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						initialDelaySeconds: 300
						periodSeconds:       10
						tcpSocket: port: 6379
					}
					name: "redis"
					readinessProbe: {
						initialDelaySeconds: 1
						periodSeconds:       10
						tcpSocket: port: 6379
					}
					volumeMounts: [{
						mountPath: "/var/lib/redis"
						name:      "data"
					}]
				}]
				securityContext: {
					fsGroup:   999
					runAsUser: 999
				}
				terminationGracePeriodSeconds: 120
			}
		}
		volumeClaimTemplates: [{
			metadata: {
				labels: {
					app:      "harbor"
					chart:    "harbor"
					heritage: "Helm"
					release:  "harbor"
				}
				name: "data"
			}
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "1Gi"
			}
		}]
	}
}
res: statefulset: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-trivy": {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	metadata: {
		labels: {
			app:       "harbor"
			chart:     "harbor"
			component: "trivy"
			heritage:  "Helm"
			release:   "harbor"
		}
		name:      "harbor-trivy"
		namespace: "harbor"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			app:       "harbor"
			component: "trivy"
			release:   "harbor"
		}
		serviceName: "harbor-trivy"
		template: {
			metadata: {
				annotations: "checksum/secret": "81105cb33a8cb2937d69d3a39d46a94953951b6154c8518d288852bcf66b4d6d"
				labels: {
					app:       "harbor"
					chart:     "harbor"
					component: "trivy"
					heritage:  "Helm"
					name:      "harbor-trivy"
					release:   "harbor"
				}
			}
			spec: {
				automountServiceAccountToken: false
				containers: [{
					env: [{
						name:  "HTTP_PROXY"
						value: ""
					}, {
						name:  "HTTPS_PROXY"
						value: ""
					}, {
						name:  "NO_PROXY"
						value: "harbor-core,harbor-jobservice,harbor-database,harbor-registry,harbor-portal,harbor-trivy,harbor-exporter,127.0.0.1,localhost,.local,.internal"
					}, {
						name:  "SCANNER_LOG_LEVEL"
						value: "info"
					}, {
						name:  "SCANNER_TRIVY_CACHE_DIR"
						value: "/home/scanner/.cache/trivy"
					}, {
						name:  "SCANNER_TRIVY_REPORTS_DIR"
						value: "/home/scanner/.cache/reports"
					}, {
						name:  "SCANNER_TRIVY_DEBUG_MODE"
						value: "false"
					}, {
						name:  "SCANNER_TRIVY_VULN_TYPE"
						value: "os,library"
					}, {
						name:  "SCANNER_TRIVY_TIMEOUT"
						value: "5m0s"
					}, {
						name: "SCANNER_TRIVY_GITHUB_TOKEN"
						valueFrom: secretKeyRef: {
							key:  "gitHubToken"
							name: "external-harbor-trivy"
						}
					}, {
						name:  "SCANNER_TRIVY_SEVERITY"
						value: "UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL"
					}, {
						name:  "SCANNER_TRIVY_IGNORE_UNFIXED"
						value: "false"
					}, {
						name:  "SCANNER_TRIVY_SKIP_UPDATE"
						value: "false"
					}, {
						name:  "SCANNER_TRIVY_OFFLINE_SCAN"
						value: "false"
					}, {
						name:  "SCANNER_TRIVY_SECURITY_CHECKS"
						value: "vuln"
					}, {
						name:  "SCANNER_TRIVY_INSECURE"
						value: "false"
					}, {
						name:  "SCANNER_API_SERVER_ADDR"
						value: ":8080"
					}, {
						name: "SCANNER_REDIS_URL"
						valueFrom: secretKeyRef: {
							key:  "redisURL"
							name: "external-harbor-trivy"
						}
					}, {
						name: "SCANNER_STORE_REDIS_URL"
						valueFrom: secretKeyRef: {
							key:  "redisURL"
							name: "external-harbor-trivy"
						}
					}, {
						name: "SCANNER_JOB_QUEUE_REDIS_URL"
						valueFrom: secretKeyRef: {
							key:  "redisURL"
							name: "external-harbor-trivy"
						}
					}]
					image:           "goharbor/trivy-adapter-photon:v2.9.1"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 10
						httpGet: {
							path:   "/probe/healthy"
							port:   "api-server"
							scheme: "HTTP"
						}
						initialDelaySeconds: 5
						periodSeconds:       10
						successThreshold:    1
					}
					name: "trivy"
					ports: [{
						containerPort: 8080
						name:          "api-server"
					}]
					readinessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/probe/ready"
							port:   "api-server"
							scheme: "HTTP"
						}
						initialDelaySeconds: 5
						periodSeconds:       10
						successThreshold:    1
					}
					resources: {
						limits: {
							cpu:    1
							memory: "1Gi"
						}
						requests: {
							cpu:    "200m"
							memory: "512Mi"
						}
					}
					securityContext: {
						allowPrivilegeEscalation: false
						privileged:               false
					}
					volumeMounts: [{
						mountPath: "/home/scanner/.cache"
						name:      "data"
						readOnly:  false
					}]
				}]
				securityContext: {
					fsGroup:   10000
					runAsUser: 10000
				}
			}
		}
		volumeClaimTemplates: [{
			metadata: {
				labels: {
					app:      "harbor"
					chart:    "harbor"
					heritage: "Helm"
					release:  "harbor"
				}
				name: "data"
			}
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "5Gi"
			}
		}]
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-admin": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-admin"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "harbor_admin_password"
			}
			secretKey: "harbor_admin_password"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "harbor_postgres_password"
			}
			secretKey: "harbor_postgres_password"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-admin"
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-core": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-core"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "CSRF_KEY"
			}
			secretKey: "CSRF_KEY"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "POSTGRESQL_PASSWORD"
			}
			secretKey: "POSTGRESQL_PASSWORD"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "REGISTRY_CREDENTIAL_PASSWORD"
			}
			secretKey: "REGISTRY_CREDENTIAL_PASSWORD"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "secret"
			}
			secretKey: "secret"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "secretKey"
			}
			secretKey: "secretKey"
		}, {
			remoteRef: {
				decodingStrategy: "Base64"
				key:              "coder-amanibhavam-district-cluster"
				property:         "tls.crt"
			}
			secretKey: "tls.crt"
		}, {
			remoteRef: {
				decodingStrategy: "Base64"
				key:              "coder-amanibhavam-district-cluster"
				property:         "tls.key"
			}
			secretKey: "tls.key"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-core"
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-database": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-database"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "POSTGRES_PASSWORD"
			}
			secretKey: "POSTGRES_PASSWORD"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-database"
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-jobservice": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-jobservice"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "JOBSERVICE_SECRET"
			}
			secretKey: "JOBSERVICE_SECRET"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "REGISTRY_CREDENTIAL_PASSWORD"
			}
			secretKey: "REGISTRY_CREDENTIAL_PASSWORD"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-jobservice"
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registry": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-registry"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "REGISTRY_HTTP_SECRET"
			}
			secretKey: "REGISTRY_HTTP_SECRET"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "REGISTRY_REDIS_PASSWORD"
			}
			secretKey: "REGISTRY_REDIS_PASSWORD"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-registry"
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registry-htpasswd": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-registry-htpasswd"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "REGISTRY_HTPASSWD"
			}
			secretKey: "REGISTRY_HTPASSWD"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-registry-htpasswd"
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-registryctl": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-registryctl"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "hello"
			}
			secretKey: "hello"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-registryctl"
		}
	}
}
res: externalsecret: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-trivy": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ExternalSecret"
	metadata: {
		name:      "harbor-trivy"
		namespace: "harbor"
	}
	spec: {
		data: [{
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "gitHubToken"
			}
			secretKey: "gitHubToken"
		}, {
			remoteRef: {
				key:      "coder-amanibhavam-district-cluster"
				property: "redisURL"
			}
			secretKey: "redisURL"
		}]
		refreshInterval: "1h"
		secretStoreRef: {
			kind: "ClusterSecretStore"
			name: "coder-amanibhavam-district"
		}
		target: {
			creationPolicy: "Owner"
			name:           "external-harbor-trivy"
		}
	}
}
res: ingress: "coder-amanibhavam-district-cluster-harbor": harbor: "harbor-ingress": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: {
			"ingress.kubernetes.io/proxy-body-size":       "0"
			"ingress.kubernetes.io/ssl-redirect":          "true"
			"nginx.ingress.kubernetes.io/proxy-body-size": "0"
			"nginx.ingress.kubernetes.io/ssl-redirect":    "true"
		}
		labels: {
			app:      "harbor"
			chart:    "harbor"
			heritage: "Helm"
			release:  "harbor"
		}
		name:      "harbor-ingress"
		namespace: "harbor"
	}
	spec: {
		rules: [{
			host: "harbor.district.amanibhavam.defn.run"
			http: paths: [{
				backend: service: {
					name: "harbor-core"
					port: number: 80
				}
				path:     "/api/"
				pathType: "Prefix"
			}, {
				backend: service: {
					name: "harbor-core"
					port: number: 80
				}
				path:     "/service/"
				pathType: "Prefix"
			}, {
				backend: service: {
					name: "harbor-core"
					port: number: 80
				}
				path:     "/v2/"
				pathType: "Prefix"
			}, {
				backend: service: {
					name: "harbor-core"
					port: number: 80
				}
				path:     "/chartrepo/"
				pathType: "Prefix"
			}, {
				backend: service: {
					name: "harbor-core"
					port: number: 80
				}
				path:     "/c/"
				pathType: "Prefix"
			}, {
				backend: service: {
					name: "harbor-portal"
					port: number: 80
				}
				path:     "/"
				pathType: "Prefix"
			}]
		}]
		tls: [{
			hosts: ["harbor.district.amanibhavam.defn.run"]
		}]
	}
}