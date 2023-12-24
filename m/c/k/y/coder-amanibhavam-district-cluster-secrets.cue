package y

res: clustersecretstore: "coder-amanibhavam-district-cluster-secrets": cluster: "coder-amanibhavam-district": {
	apiVersion: "external-secrets.io/v1beta1"
	kind:       "ClusterSecretStore"
	metadata: name: "coder-amanibhavam-district"
	spec: provider: aws: {
		region:  "us-west-2"
		service: "SecretsManager"
	}
}