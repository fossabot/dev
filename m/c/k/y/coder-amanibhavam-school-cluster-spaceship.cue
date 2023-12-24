package y

res: service: "coder-amanibhavam-school-cluster-spaceship": default: deathstar: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		annotations: "io.cilium/global-service": "true"
		name:      "deathstar"
		namespace: "default"
	}
	spec: {
		ports: [{
			port: 80
		}]
		selector: {
			class: "deathstar"
			org:   "empire"
		}
		type: "ClusterIP"
	}
}
res: deployment: "coder-amanibhavam-school-cluster-spaceship": default: spaceship: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "spaceship"
		namespace: "default"
	}
	spec: {
		replicas: 4
		selector: matchLabels: {
			class: "spaceship"
			name:  "spaceship"
			org:   "empire"
		}
		template: {
			metadata: labels: {
				class: "spaceship"
				name:  "spaceship"
				org:   "empire"
			}
			spec: containers: [{
				image:           "docker.io/tgraf/netperf:v1.0"
				imagePullPolicy: "IfNotPresent"
				name:            "spaceship"
			}]
		}
	}
}