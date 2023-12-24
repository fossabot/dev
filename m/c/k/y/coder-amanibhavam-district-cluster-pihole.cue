package y

res: namespace: "coder-amanibhavam-district-cluster-pihole": cluster: pihole: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "pihole"
}
res: configmap: "coder-amanibhavam-district-cluster-pihole": pihole: "pihole-custom-dnsmasq": {
	apiVersion: "v1"
	data: {
		"02-custom.conf": """
			addn-hosts=/etc/addn-hosts

			"""

		"05-pihole-custom-cname.conf": ""
		"addn-hosts":                  ""
	}
	kind: "ConfigMap"
	metadata: {
		labels: {
			app:      "pihole"
			chart:    "pihole-2.20.0"
			heritage: "Helm"
			release:  "pihole"
		}
		name:      "pihole-custom-dnsmasq"
		namespace: "pihole"
	}
}
res: secret: "coder-amanibhavam-district-cluster-pihole": pihole: "pihole-password": {
	apiVersion: "v1"
	data: password: "YWRtaW4="
	kind: "Secret"
	metadata: {
		labels: {
			app:      "pihole"
			chart:    "pihole-2.20.0"
			heritage: "Helm"
			release:  "pihole"
		}
		name:      "pihole-password"
		namespace: "pihole"
	}
	type: "Opaque"
}
res: service: "coder-amanibhavam-district-cluster-pihole": pihole: "pihole-dns": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "pihole"
			chart:    "pihole-2.20.0"
			heritage: "Helm"
			release:  "pihole"
		}
		name:      "pihole-dns"
		namespace: "pihole"
	}
	spec: {
		clusterIP: "10.250.128.53"
		ports: [{
			name:       "dns"
			port:       53
			protocol:   "TCP"
			targetPort: "dns"
		}, {
			name:       "dns-udp"
			port:       53
			protocol:   "UDP"
			targetPort: "dns-udp"
		}]
		selector: {
			app:     "pihole"
			release: "pihole"
		}
		type: "ClusterIP"
	}
}
res: service: "coder-amanibhavam-district-cluster-pihole": pihole: "pihole-web": {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		labels: {
			app:      "pihole"
			chart:    "pihole-2.20.0"
			heritage: "Helm"
			release:  "pihole"
		}
		name:      "pihole-web"
		namespace: "pihole"
	}
	spec: {
		ports: [{
			name:       "http"
			port:       80
			protocol:   "TCP"
			targetPort: "http"
		}]
		selector: {
			app:     "pihole"
			release: "pihole"
		}
		type: "ClusterIP"
	}
}
res: persistentvolumeclaim: "coder-amanibhavam-district-cluster-pihole": pihole: pihole: {
	apiVersion: "v1"
	kind:       "PersistentVolumeClaim"
	metadata: {
		labels: {
			app:       "pihole"
			chart:     "pihole-2.20.0"
			component: ""
			heritage:  "Helm"
			release:   "pihole"
		}
		name:      "pihole"
		namespace: "pihole"
	}
	spec: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "500Mi"
	}
}
res: deployment: "coder-amanibhavam-district-cluster-pihole": pihole: pihole: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		labels: {
			app:      "pihole"
			chart:    "pihole-2.20.0"
			heritage: "Helm"
			release:  "pihole"
		}
		name:      "pihole"
		namespace: "pihole"
	}
	spec: {
		replicas: 1
		selector: matchLabels: {
			app:     "pihole"
			release: "pihole"
		}
		strategy: {
			rollingUpdate: {
				maxSurge:       1
				maxUnavailable: 1
			}
			type: "RollingUpdate"
		}
		template: {
			metadata: {
				annotations: {
					"checksum.config.adlists":          "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546"
					"checksum.config.blacklist":        "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546"
					"checksum.config.dnsmasqConfig":    "b4df7631e8217671134998cf2bab12cb90c812b8bd46dfbe172fa9919b61b20"
					"checksum.config.regex":            "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546"
					"checksum.config.staticDhcpConfig": "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546"
					"checksum.config.whitelist":        "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546"
				}
				labels: {
					app:     "pihole"
					release: "pihole"
				}
			}
			spec: {
				containers: [{
					env: [{
						name:  "WEB_PORT"
						value: "80"
					}, {
						name:  "VIRTUAL_HOST"
						value: "pi.hole"
					}, {
						name: "WEBPASSWORD"
						valueFrom: secretKeyRef: {
							key:  "password"
							name: "pihole-password"
						}
					}, {
						name:  "PIHOLE_DNS_"
						value: "10.250.128.10;10.250.128.10"
					}]
					image:           "pihole/pihole:2023.11.0"
					imagePullPolicy: "IfNotPresent"
					livenessProbe: {
						failureThreshold: 10
						httpGet: {
							path:   "/admin/index.php"
							port:   "http"
							scheme: "HTTP"
						}
						initialDelaySeconds: 60
						timeoutSeconds:      5
					}
					name: "pihole"
					ports: [{
						containerPort: 80
						name:          "http"
						protocol:      "TCP"
					}, {
						containerPort: 53
						name:          "dns"
						protocol:      "TCP"
					}, {
						containerPort: 53
						name:          "dns-udp"
						protocol:      "UDP"
					}, {
						containerPort: 443
						name:          "https"
						protocol:      "TCP"
					}, {
						containerPort: 67
						name:          "client-udp"
						protocol:      "UDP"
					}]
					readinessProbe: {
						failureThreshold: 3
						httpGet: {
							path:   "/admin/index.php"
							port:   "http"
							scheme: "HTTP"
						}
						initialDelaySeconds: 60
						timeoutSeconds:      5
					}
					resources: {}
					securityContext: privileged: false
					volumeMounts: [{
						mountPath: "/etc/pihole"
						name:      "config"
					}, {
						mountPath: "/etc/dnsmasq.d/02-custom.conf"
						name:      "custom-dnsmasq"
						subPath:   "02-custom.conf"
					}, {
						mountPath: "/etc/addn-hosts"
						name:      "custom-dnsmasq"
						subPath:   "addn-hosts"
					}]
				}]
				hostNetwork: false
				volumes: [{
					name: "config"
					persistentVolumeClaim: claimName: "pihole"
				}, {
					configMap: {
						defaultMode: 420
						name:        "pihole-custom-dnsmasq"
					}
					name: "custom-dnsmasq"
				}]
			}
		}
	}
}
res: ingress: "coder-amanibhavam-district-cluster-pihole": pihole: "pihole-web": {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: {
			"traefik.ingress.kubernetes.io/router.entrypoints": "websecure"
			"traefik.ingress.kubernetes.io/router.tls":         "true"
		}
		name:      "pihole-web"
		namespace: "pihole"
	}
	spec: {
		ingressClassName: "traefik"
		rules: [{
			host: "pihole.district.amanibhavam.defn.run"
			http: paths: [{
				backend: service: {
					name: "pihole-web"
					port: number: 80
				}
				path:     "/"
				pathType: "Prefix"
			}]
		}]
	}
}
res: pod: "coder-amanibhavam-district-cluster-pihole": pihole: "pihole-smoke-test": {
	apiVersion: "v1"
	kind:       "Pod"
	metadata: {
		annotations: "helm.sh/hook": "test"
		name:      "pihole-smoke-test"
		namespace: "pihole"
	}
	spec: {
		containers: [{
			command: [
				"sh",
				"-c",
				"curl http://pihole-web:80/",
			]
			image:           "curlimages/curl"
			imagePullPolicy: "IfNotPresent"
			name:            "hook1-container"
		}]
		restartPolicy:                 "Never"
		terminationGracePeriodSeconds: 0
	}
}