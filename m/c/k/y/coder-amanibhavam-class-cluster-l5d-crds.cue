package y

res: namespace: "coder-amanibhavam-class-cluster-l5d-crds": cluster: linkerd: {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: {
		annotations: "linkerd.io/inject": "disabled"
		labels: {
			"config.linkerd.io/admission-webhooks": "disabled"
			"linkerd.io/control-plane-ns":          "linkerd"
			"linkerd.io/is-control-plane":          "true"
		}
		name: "linkerd"
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "authorizationpolicies.policy.linkerd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "linkerd.io/created-by": "linkerd/helm %!s(<nil>)"
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "authorizationpolicies.policy.linkerd.io"
	}
	spec: {
		group: "policy.linkerd.io"
		names: {
			kind:   "AuthorizationPolicy"
			plural: "authorizationpolicies"
			shortNames: ["authzpolicy"]
			singular: "authorizationpolicy"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: spec: {
					description: "Authorizes clients to communicate with Linkerd-proxied server resources."

					properties: {
						requiredAuthenticationRefs: {
							description: "RequiredAuthenticationRefs enumerates a set of required authentications. ALL authentications must be satisfied for the authorization to apply. If any of the referred objects cannot be found, the authorization will be ignored."

							items: {
								properties: {
									group: {
										description: "Group is the group of the referent. When empty, the Kubernetes core API group is inferred.\""

										maxLength: 253
										pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
										type:      "string"
									}
									kind: {
										description: "Kind is the kind of the referent."
										maxLength:   63
										minLength:   1
										pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
										type:        "string"
									}
									name: {
										description: "Name is the name of the referent."
										maxLength:   253
										minLength:   1
										type:        "string"
									}
									namespace: {
										description: "Name is the name of the referent. When unspecified, this authentication refers to the local namespace."

										maxLength: 253
										type:      "string"
									}
								}
								required: [
									"kind",
									"name",
								]
								type: "object"
							}
							type: "array"
						}
						targetRef: {
							description: "TargetRef references a resource to which the authorization policy applies."

							properties: {
								group: {
									description: "Group is the group of the referent. When empty, the Kubernetes core API group is inferred."

									maxLength: 253
									pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								kind: {
									description: "Kind is the kind of the referent."
									maxLength:   63
									minLength:   1
									pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
									type:        "string"
								}
								name: {
									description: "Name is the name of the referent."
									maxLength:   253
									minLength:   1
									type:        "string"
								}
							}
							required: [
								"kind",
								"name",
							]
							type: "object"
						}
					}
					required: [
						"targetRef",
						"requiredAuthenticationRefs",
					]
					type: "object"
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "httproutes.gateway.networking.k8s.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: {
			"api-approved.kubernetes.io":               "https://github.com/kubernetes-sigs/gateway-api/pull/1923"
			"gateway.networking.k8s.io/bundle-version": "v0.7.1-dev"
			"gateway.networking.k8s.io/channel":        "experimental"
			"linkerd.io/created-by":                    "linkerd/helm %!s(<nil>)"
		}
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "httproutes.gateway.networking.k8s.io"
	}
	spec: {
		group: "gateway.networking.k8s.io"
		names: {
			categories: ["gateway-api"]
			kind:     "HTTPRoute"
			listKind: "HTTPRouteList"
			plural:   "httproutes"
			singular: "httproute"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			deprecated:         true
			deprecationWarning: "The v1alpha2 version of HTTPRoute has been deprecated and will be removed in a future release of the API. Please upgrade to v1beta1."

			name: "v1alpha2"
			schema: openAPIV3Schema: {
				description: "HTTPRoute provides a way to route HTTP requests. This includes the capability to match requests by hostname, path, header, or query param. Filters can be used to specify additional processing steps. Backends specify where matching requests should be routed."

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
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
		Hostnames defines a set of hostname that should match against the HTTP Host header to select a HTTPRoute used to process the request. Implementations MUST ignore any port value specified in the HTTP Host header while performing a match and (absent of any applicable header modification configuration) MUST forward this header unmodified to the backend. 
		 Valid values for Hostnames are determined by RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard label must appear by itself as the first label. 
		 If a hostname is specified by both the Listener and HTTPRoute, there must be at least one intersecting hostname for the HTTPRoute to be attached to the Listener. For example: 
		 * A Listener with `test.example.com` as the hostname matches HTTPRoutes that have either not specified any hostnames, or have specified at least one of `test.example.com` or `*.example.com`. * A Listener with `*.example.com` as the hostname matches HTTPRoutes that have either not specified any hostnames or have specified at least one hostname that matches the Listener hostname. For example, `*.example.com`, `test.example.com`, and `foo.test.example.com` would all match. On the other hand, `example.com` and `test.example.net` would not match. 
		 Hostnames that are prefixed with a wildcard label (`*.`) are interpreted as a suffix match. That means that a match for `*.example.com` would match both `test.example.com`, and `foo.test.example.com`, but not `example.com`. 
		 If both the Listener and HTTPRoute have specified hostnames, any HTTPRoute hostnames that do not match the Listener hostname MUST be ignored. For example, if a Listener specified `*.example.com`, and the HTTPRoute specified `test.example.com` and `test.example.net`, `test.example.net` must not be considered for a match. 
		 If both the Listener and HTTPRoute have specified hostnames, and none match with the criteria above, then the HTTPRoute is not accepted. The implementation must raise an 'Accepted' Condition with a status of `False` in the corresponding RouteParentStatus. 
		 In the event that multiple HTTPRoutes specify intersecting hostnames (e.g. overlapping wildcard matching and exact matching hostnames), precedence must be given to rules from the HTTPRoute with the largest number of: 
		 * Characters in a matching non-wildcard hostname. * Characters in a matching hostname. 
		 If ties exist across multiple Routes, the matching precedence rules for HTTPRouteMatches takes over. 
		 Support: Core
		"""

								items: {
									description: """
		Hostname is the fully qualified domain name of a network host. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard label must appear by itself as the first label. 
		 Hostname can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.example.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. `*.example.com`). 
		 Note that as per RFC1035 and RFC1123, a *label* must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character. No other punctuation is allowed.
		"""

									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
		ParentRefs references the resources (usually Gateways) that a Route wants to be attached to. Note that the referenced parent resource needs to allow this for the attachment to be complete. For Gateways, that means the Gateway needs to allow attachment from Routes of this kind and namespace. 
		 The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources such as one of the route kinds. 
		 It is invalid to reference an identical parent more than once. It is valid to reference multiple distinct sections within the same parent resource, such as 2 Listeners within a Gateway. 
		 It is possible to separately reference multiple distinct objects that may be collapsed by an implementation. For example, some implementations may choose to merge compatible Gateway Listeners together. If that is the case, the list of routes attached to those resources should also be merged. 
		 Note that for ParentRefs that cross namespace boundaries, there are specific rules. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example, Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference.
		"""

								items: {
									description: """
		ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
		 The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
		"""

									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
		Group is the group of the referent. When unspecified, \"gateway.networking.k8s.io\" is inferred. To set the core API group (such as for a \"Service\" kind referent), Group must be explicitly set to \"\" (empty string). 
		 Support: Core
		"""

											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) 
		 Support: Implementation-specific (Other Resources)
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
		Name is the name of the referent. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
		Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. 
		 Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. 
		 Support: Core
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
		Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. 
		 When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. 
		 For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Extended 
		 <gateway:experimental>
		"""

											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: "HTTPRouteRule defines semantics for matching an HTTP request based on conditions (matches), processing it (filters), and forwarding the request to an API object (backendRefs)."

									properties: {
										backendRefs: {
											description: """
		BackendRefs defines the backend(s) where matching requests should be sent. 
		 Failure behavior here depends on how many BackendRefs are specified and how many are invalid. 
		 If *all* entries in BackendRefs are invalid, and there are also no filters specified in this route rule, *all* traffic which matches this rule MUST receive a 500 status code. 
		 See the HTTPBackendRef definition for the rules about what makes a single HTTPBackendRef invalid. 
		 When a HTTPBackendRef is invalid, 500 status codes MUST be returned for requests that would have otherwise been routed to an invalid backend. If multiple backends are specified, and some are invalid, the proportion of requests that would otherwise have been routed to an invalid backend MUST receive a 500 status code. 
		 For example, if two backends are specified with equal weights, and one is invalid, 50 percent of traffic must receive a 500. Implementations may choose how that 50 percent is determined. 
		 Support: Core for Kubernetes Service 
		 Support: Extended for Kubernetes ServiceImport 
		 Support: Implementation-specific for any other resource 
		 Support for weight: Core
		"""

											items: {
												description: "HTTPBackendRef defines how a HTTPRoute should forward an HTTP request."

												properties: {
													filters: {
														description: """
		Filters defined at this level should be executed if and only if the request is being forwarded to the backend defined here. 
		 Support: Implementation-specific (For broader support of filters, use the Filters field in HTTPRouteRule.)
		"""

														items: {
															description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

															properties: {
																extensionRef: {
																	description: """
		ExtensionRef is an optional, implementation-specific extension to the \"filter\" behavior.  For example, resource \"myroutefilter\" in group \"networking.example.net\"). ExtensionRef MUST NOT be used for core and extended filters. 
		 Support: Implementation-specific
		"""

																	properties: {
																		group: {
																			description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																			maxLength: 253
																			pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		kind: {
																			description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."

																			maxLength: 63
																			minLength: 1
																			pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																			type:      "string"
																		}
																		name: {
																			description: "Name is the name of the referent."
																			maxLength:   253
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"group",
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																requestHeaderModifier: {
																	description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestMirror: {
																	description: """
		RequestMirror defines a schema for a filter that mirrors requests. Requests are sent to the specified destination, but responses from that destination are ignored. 
		 Support: Extended
		"""

																	properties: backendRef: {
																		description: """
		BackendRef references a resource where mirrored requests are sent. 
		 If the referent cannot be found, this BackendRef is invalid and must be dropped from the Gateway. The controller must ensure the \"ResolvedRefs\" condition on the Route status is set to `status: False` and not configure this backend in the underlying implementation. 
		 If there is a cross-namespace reference to an *existing* object that is not allowed by a ReferenceGrant, the controller must ensure the \"ResolvedRefs\"  condition on the Route is set to `status: False`, with the \"RefNotPermitted\" reason and not configure this backend in the underlying implementation. 
		 In either error case, the Message of the `ResolvedRefs` Condition should be used to provide more detail about the problem. 
		 Support: Extended for Kubernetes Service 
		 Support: Implementation-specific for any other resource
		"""

																		properties: {
																			group: {
																				default:     ""
																				description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																				maxLength: 253
																				pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																				type:      "string"
																			}
																			kind: {
																				default: "Service"
																				description: """
		Kind is the Kubernetes resource kind of the referent. For example \"Service\". 
		 Defaults to \"Service\" when not specified. 
		 ExternalName services can refer to CNAME DNS records that may live outside of the cluster and as such are difficult to reason about in terms of conformance. They also may not be safe to forward to (see CVE-2021-25740 for more information). Implementations SHOULD NOT support ExternalName Services. 
		 Support: Core (Services with a type other than ExternalName) 
		 Support: Implementation-specific (Services with type ExternalName)
		"""

																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																				type:      "string"
																			}
																			name: {
																				description: "Name is the name of the referent."
																				maxLength:   253
																				minLength:   1
																				type:        "string"
																			}
																			namespace: {
																				description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace different than the local namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																				type:      "string"
																			}
																			port: {
																				description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

																				format:  "int32"
																				maximum: 65535
																				minimum: 1
																				type:    "integer"
																			}
																		}
																		required: ["name"]
																		type: "object"
																	}
																	required: ["backendRef"]
																	type: "object"
																}
																requestRedirect: {
																	description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																		port: {
																			description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestMirror",
																		"RequestRedirect",
																		"URLRewrite",
																		"ExtensionRef",
																	]
																	type: "string"
																}
																urlRewrite: {
																	description: """
		URLRewrite defines a schema for a filter that modifies a request during forwarding. 
		 Support: Extended
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the value to be used to replace the Host header value during forwarding. 
		 Support: Extended
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines a path rewrite. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																	}
																	type: "object"
																}
															}
															required: ["type"]
															type: "object"
														}
														maxItems: 16
														type:     "array"
													}
													group: {
														default:     ""
														description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default: "Service"
														description: """
		Kind is the Kubernetes resource kind of the referent. For example \"Service\". 
		 Defaults to \"Service\" when not specified. 
		 ExternalName services can refer to CNAME DNS records that may live outside of the cluster and as such are difficult to reason about in terms of conformance. They also may not be safe to forward to (see CVE-2021-25740 for more information). Implementations SHOULD NOT support ExternalName Services. 
		 Support: Core (Services with a type other than ExternalName) 
		 Support: Implementation-specific (Services with type ExternalName)
		"""

														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace different than the local namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
		Weight specifies the proportion of requests forwarded to the referenced backend. This is computed as weight/(sum of all weights in this BackendRefs list). For non-zero values, there may be some epsilon from the exact proportion defined here depending on the precision an implementation supports. Weight is not a percentage and the sum of weights does not need to equal 100. 
		 If only one backend is specified and it has a weight greater than 0, 100% of the traffic is forwarded to that backend. If weight is set to 0, no traffic should be forwarded for this entry. If unspecified, weight defaults to 1. 
		 Support for this field varies based on the context where used.
		"""

														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
		Filters define the filters that are applied to requests that match this rule. 
		 The effects of ordering of multiple behaviors are currently unspecified. This can change in the future based on feedback during the alpha stage. 
		 Conformance-levels at this level are defined based on the type of filter: 
		 - ALL core filters MUST be supported by all implementations. - Implementers are encouraged to support extended filters. - Implementation-specific custom filters have no API guarantees across implementations. 
		 Specifying a core filter multiple times has unspecified or implementation-specific conformance. 
		 All filters are expected to be compatible with each other except for the URLRewrite and RequestRedirect filters, which may not be combined. If an implementation can not support other combinations of filters, they must clearly document that limitation. In all cases where incompatible or unsupported filters are specified, implementations MUST add a warning condition to status. 
		 Support: Core
		"""

											items: {
												description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

												properties: {
													extensionRef: {
														description: """
		ExtensionRef is an optional, implementation-specific extension to the \"filter\" behavior.  For example, resource \"myroutefilter\" in group \"networking.example.net\"). ExtensionRef MUST NOT be used for core and extended filters. 
		 Support: Implementation-specific
		"""

														properties: {
															group: {
																description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."

																maxLength: 63
																minLength: 1
																pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:      "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
														}
														required: [
															"group",
															"kind",
															"name",
														]
														type: "object"
													}
													requestHeaderModifier: {
														description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestMirror: {
														description: """
		RequestMirror defines a schema for a filter that mirrors requests. Requests are sent to the specified destination, but responses from that destination are ignored. 
		 Support: Extended
		"""

														properties: backendRef: {
															description: """
		BackendRef references a resource where mirrored requests are sent. 
		 If the referent cannot be found, this BackendRef is invalid and must be dropped from the Gateway. The controller must ensure the \"ResolvedRefs\" condition on the Route status is set to `status: False` and not configure this backend in the underlying implementation. 
		 If there is a cross-namespace reference to an *existing* object that is not allowed by a ReferenceGrant, the controller must ensure the \"ResolvedRefs\"  condition on the Route is set to `status: False`, with the \"RefNotPermitted\" reason and not configure this backend in the underlying implementation. 
		 In either error case, the Message of the `ResolvedRefs` Condition should be used to provide more detail about the problem. 
		 Support: Extended for Kubernetes Service 
		 Support: Implementation-specific for any other resource
		"""

															properties: {
																group: {
																	default:     ""
																	description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	default: "Service"
																	description: """
		Kind is the Kubernetes resource kind of the referent. For example \"Service\". 
		 Defaults to \"Service\" when not specified. 
		 ExternalName services can refer to CNAME DNS records that may live outside of the cluster and as such are difficult to reason about in terms of conformance. They also may not be safe to forward to (see CVE-2021-25740 for more information). Implementations SHOULD NOT support ExternalName Services. 
		 Support: Core (Services with a type other than ExternalName) 
		 Support: Implementation-specific (Services with type ExternalName)
		"""

																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:      "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace different than the local namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
																port: {
																	description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

																	format:  "int32"
																	maximum: 65535
																	minimum: 1
																	type:    "integer"
																}
															}
															required: ["name"]
															type: "object"
														}
														required: ["backendRef"]
														type: "object"
													}
													requestRedirect: {
														description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
															port: {
																description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													responseHeaderModifier: {
														description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													type: {
														description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

														enum: [
															"RequestHeaderModifier",
															"ResponseHeaderModifier",
															"RequestMirror",
															"RequestRedirect",
															"URLRewrite",
															"ExtensionRef",
														]
														type: "string"
													}
													urlRewrite: {
														description: """
		URLRewrite defines a schema for a filter that modifies a request during forwarding. 
		 Support: Extended
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the value to be used to replace the Host header value during forwarding. 
		 Support: Extended
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines a path rewrite. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["type"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
		Matches define conditions used for matching the rule against incoming HTTP requests. Each match is independent, i.e. this rule will be matched if **any** one of the matches is satisfied. 
		 For example, take the following matches configuration: 
		 ``` matches: - path: value: \"/foo\" headers: - name: \"version\" value: \"v2\" - path: value: \"/v2/foo\" ``` 
		 For a request to match against this rule, a request must satisfy EITHER of the two conditions: 
		 - path prefixed with `/foo` AND contains the header `version: v2` - path prefix of `/v2/foo` 
		 See the documentation for HTTPRouteMatch on how to specify multiple match conditions that should be ANDed together. 
		 If no matches are specified, the default is a prefix path match on \"/\", which has the effect of matching every HTTP request. 
		 Proxy or Load Balancer routing configuration generated from HTTPRoutes MUST prioritize matches based on the following criteria, continuing on ties. Across all rules specified on applicable Routes, precedence must be given to the match having: 
		 * \"Exact\" path match. * \"Prefix\" path match with largest number of characters. * Method match. * Largest number of header matches. * Largest number of query param matches. 
		 Note: The precedence of RegularExpression path matches are implementation-specific. 
		 If ties still exist across multiple Routes, matching precedence MUST be determined in order of the following criteria, continuing on ties: 
		 * The oldest Route based on creation timestamp. * The Route appearing first in alphabetical order by \"{namespace}/{name}\". 
		 If ties still exist within an HTTPRoute, matching precedence MUST be granted to the FIRST matching rule (in list order) with a match meeting the above criteria. 
		 When no rules matching a request have been successfully attached to the parent a request is coming from, a HTTP 404 status code MUST be returned.
		"""

											items: {
												description: """
		HTTPRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together, i.e. the match will evaluate to true only if all conditions are satisfied. 
		 For example, the match below will match a HTTP request only if its path starts with `/foo` AND it contains the `version: v1` header: 
		 ``` match: 
		 path: value: \"/foo\" headers: - name: \"version\" value \"v1\" 
		 ```
		"""

												properties: {
													headers: {
														description: "Headers specifies HTTP request header matchers. Multiple match values are ANDed together, meaning, a request must match all the specified headers to select the route."

														items: {
															description: "HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request headers."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent. 
		 When a header is repeated in an HTTP request, it is implementation-specific behavior as to how this is represented. Generally, proxies should follow the guidance from the RFC: https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding processing a repeated header, with special handling for \"Set-Cookie\".
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the header. 
		 Support: Core (Exact) 
		 Support: Implementation-specific (RegularExpression) 
		 Since RegularExpression HeaderMatchType has implementation-specific conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."

																	maxLength: 4096
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
		Method specifies HTTP method matcher. When specified, this route will be matched only if the request has the specified method. 
		 Support: Extended
		"""

														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: "Path specifies a HTTP request path matcher. If this field is not specified, a default prefix match on the \"/\" path is provided."

														properties: {
															type: {
																default: "PathPrefix"
																description: """
		Type specifies how to match against the path Value. 
		 Support: Core (Exact, PathPrefix) 
		 Support: Implementation-specific (RegularExpression)
		"""

																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
													}
													queryParams: {
														description: """
		QueryParams specifies HTTP query parameter matchers. Multiple match values are ANDed together, meaning, a request must match all the specified query parameters to select the route. 
		 Support: Extended
		"""

														items: {
															description: "HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP query parameters."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP query param to be matched. This must be an exact string match. (See https://tools.ietf.org/html/rfc7230#section-2.7.3). 
		 If multiple entries specify equivalent query param names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent query param name MUST be ignored. 
		 If a query param is repeated in an HTTP request, the behavior is purposely left undefined, since different data planes have different capabilities. However, it is *recommended* that implementations should match against the first value of the param if the data plane supports it, as this behavior is expected in other load balancing contexts outside of the Gateway API. 
		 Users SHOULD NOT route traffic based on repeated query params to guard themselves against potential differences in the implementations.
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the query parameter. 
		 Support: Extended (Exact) 
		 Support: Implementation-specific (RegularExpression) 
		 Since RegularExpression QueryParamMatchType has Implementation-specific conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."

																	maxLength: 1024
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
		Parents is a list of parent resources (usually Gateways) that are associated with the route, and the status of the route with respect to each parent. When this route attaches to a parent, the controller that manages the parent must add an entry to this list when the controller first sees the route and should update the entry as appropriate when the route or gateway is modified. 
		 Note that parent references that cannot be resolved by an implementation of this API will not be added to this list. Implementations of this API can only populate Route status for the Gateways/parent resources they are responsible for. 
		 A maximum of 32 Gateways will be represented in this list. An empty list means the route has not been attached to any Gateway.
		"""

							items: {
								description: "RouteParentStatus describes the status of a route with respect to an associated Parent."

								properties: {
									conditions: {
										description: """
		Conditions describes the status of the route with respect to the Gateway. Note that the route's availability is also subject to the Gateway's own status conditions and listener status. 
		 If the Route's ParentRef specifies an existing Gateway that supports Routes of this kind AND that Gateway's controller has sufficient access, then that Gateway's controller MUST set the \"Accepted\" condition on the Route, to indicate whether the route has been accepted or rejected by the Gateway, and why. 
		 A Route MUST be considered \"Accepted\" if at least one of the Route's rules is implemented by the Gateway. 
		 There are a number of cases where the \"Accepted\" condition may not be set due to lack of controller visibility, that includes when: 
		 * The Route refers to a non-existent parent. * The Route is of a type that the controller does not support. * The Route is in a namespace the controller does not have access to.
		"""

										items: {
											description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

											properties: {
												lastTransitionTime: {
													description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

													format: "date-time"
													type:   "string"
												}
												message: {
													description: "message is a human readable message indicating details about the transition. This may be an empty string."

													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."

													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
		ControllerName is a domain/path string that indicates the name of the controller that wrote this status. This corresponds with the controllerName field on GatewayClass. 
		 Example: \"example.net/gateway-controller\". 
		 The format of this field is DOMAIN \"/\" PATH, where DOMAIN and PATH are valid Kubernetes names (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names). 
		 Controllers MUST populate this field when writing status. Controllers should ensure that entries to status populated with their ControllerName are cleaned up when they are no longer necessary.
		"""

										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: "ParentRef corresponds with a ParentRef in the spec that this RouteParentStatus struct describes the status of."

										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
		Group is the group of the referent. When unspecified, \"gateway.networking.k8s.io\" is inferred. To set the core API group (such as for a \"Service\" kind referent), Group must be explicitly set to \"\" (empty string). 
		 Support: Core
		"""

												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) 
		 Support: Implementation-specific (Other Resources)
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
		Name is the name of the referent. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
		Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. 
		 Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. 
		 Support: Core
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
		Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. 
		 When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. 
		 For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Extended 
		 <gateway:experimental>
		"""

												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  false
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "HTTPRoute provides a way to route HTTP requests. This includes the capability to match requests by hostname, path, header, or query param. Filters can be used to specify additional processing steps. Backends specify where matching requests should be routed."

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
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
		Hostnames defines a set of hostname that should match against the HTTP Host header to select a HTTPRoute used to process the request. Implementations MUST ignore any port value specified in the HTTP Host header while performing a match and (absent of any applicable header modification configuration) MUST forward this header unmodified to the backend. 
		 Valid values for Hostnames are determined by RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard label must appear by itself as the first label. 
		 If a hostname is specified by both the Listener and HTTPRoute, there must be at least one intersecting hostname for the HTTPRoute to be attached to the Listener. For example: 
		 * A Listener with `test.example.com` as the hostname matches HTTPRoutes that have either not specified any hostnames, or have specified at least one of `test.example.com` or `*.example.com`. * A Listener with `*.example.com` as the hostname matches HTTPRoutes that have either not specified any hostnames or have specified at least one hostname that matches the Listener hostname. For example, `*.example.com`, `test.example.com`, and `foo.test.example.com` would all match. On the other hand, `example.com` and `test.example.net` would not match. 
		 Hostnames that are prefixed with a wildcard label (`*.`) are interpreted as a suffix match. That means that a match for `*.example.com` would match both `test.example.com`, and `foo.test.example.com`, but not `example.com`. 
		 If both the Listener and HTTPRoute have specified hostnames, any HTTPRoute hostnames that do not match the Listener hostname MUST be ignored. For example, if a Listener specified `*.example.com`, and the HTTPRoute specified `test.example.com` and `test.example.net`, `test.example.net` must not be considered for a match. 
		 If both the Listener and HTTPRoute have specified hostnames, and none match with the criteria above, then the HTTPRoute is not accepted. The implementation must raise an 'Accepted' Condition with a status of `False` in the corresponding RouteParentStatus. 
		 In the event that multiple HTTPRoutes specify intersecting hostnames (e.g. overlapping wildcard matching and exact matching hostnames), precedence must be given to rules from the HTTPRoute with the largest number of: 
		 * Characters in a matching non-wildcard hostname. * Characters in a matching hostname. 
		 If ties exist across multiple Routes, the matching precedence rules for HTTPRouteMatches takes over. 
		 Support: Core
		"""

								items: {
									description: """
		Hostname is the fully qualified domain name of a network host. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard label must appear by itself as the first label. 
		 Hostname can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.example.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. `*.example.com`). 
		 Note that as per RFC1035 and RFC1123, a *label* must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character. No other punctuation is allowed.
		"""

									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
		ParentRefs references the resources (usually Gateways) that a Route wants to be attached to. Note that the referenced parent resource needs to allow this for the attachment to be complete. For Gateways, that means the Gateway needs to allow attachment from Routes of this kind and namespace. 
		 The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources such as one of the route kinds. 
		 It is invalid to reference an identical parent more than once. It is valid to reference multiple distinct sections within the same parent resource, such as 2 Listeners within a Gateway. 
		 It is possible to separately reference multiple distinct objects that may be collapsed by an implementation. For example, some implementations may choose to merge compatible Gateway Listeners together. If that is the case, the list of routes attached to those resources should also be merged. 
		 Note that for ParentRefs that cross namespace boundaries, there are specific rules. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example, Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference.
		"""

								items: {
									description: """
		ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
		 The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
		"""

									properties: {
										group: {
											default: "gateway.networking.k8s.io"
											description: """
		Group is the group of the referent. When unspecified, \"gateway.networking.k8s.io\" is inferred. To set the core API group (such as for a \"Service\" kind referent), Group must be explicitly set to \"\" (empty string). 
		 Support: Core
		"""

											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) 
		 Support: Implementation-specific (Other Resources)
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
		Name is the name of the referent. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
		Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. 
		 Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. 
		 Support: Core
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
		Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. 
		 When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. 
		 For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Extended 
		 <gateway:experimental>
		"""

											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: "HTTPRouteRule defines semantics for matching an HTTP request based on conditions (matches), processing it (filters), and forwarding the request to an API object (backendRefs)."

									properties: {
										backendRefs: {
											description: """
		BackendRefs defines the backend(s) where matching requests should be sent. 
		 Failure behavior here depends on how many BackendRefs are specified and how many are invalid. 
		 If *all* entries in BackendRefs are invalid, and there are also no filters specified in this route rule, *all* traffic which matches this rule MUST receive a 500 status code. 
		 See the HTTPBackendRef definition for the rules about what makes a single HTTPBackendRef invalid. 
		 When a HTTPBackendRef is invalid, 500 status codes MUST be returned for requests that would have otherwise been routed to an invalid backend. If multiple backends are specified, and some are invalid, the proportion of requests that would otherwise have been routed to an invalid backend MUST receive a 500 status code. 
		 For example, if two backends are specified with equal weights, and one is invalid, 50 percent of traffic must receive a 500. Implementations may choose how that 50 percent is determined. 
		 Support: Core for Kubernetes Service 
		 Support: Extended for Kubernetes ServiceImport 
		 Support: Implementation-specific for any other resource 
		 Support for weight: Core
		"""

											items: {
												description: "HTTPBackendRef defines how a HTTPRoute should forward an HTTP request."

												properties: {
													filters: {
														description: """
		Filters defined at this level should be executed if and only if the request is being forwarded to the backend defined here. 
		 Support: Implementation-specific (For broader support of filters, use the Filters field in HTTPRouteRule.)
		"""

														items: {
															description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

															properties: {
																extensionRef: {
																	description: """
		ExtensionRef is an optional, implementation-specific extension to the \"filter\" behavior.  For example, resource \"myroutefilter\" in group \"networking.example.net\"). ExtensionRef MUST NOT be used for core and extended filters. 
		 Support: Implementation-specific
		"""

																	properties: {
																		group: {
																			description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																			maxLength: 253
																			pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		kind: {
																			description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."

																			maxLength: 63
																			minLength: 1
																			pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																			type:      "string"
																		}
																		name: {
																			description: "Name is the name of the referent."
																			maxLength:   253
																			minLength:   1
																			type:        "string"
																		}
																	}
																	required: [
																		"group",
																		"kind",
																		"name",
																	]
																	type: "object"
																}
																requestHeaderModifier: {
																	description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestMirror: {
																	description: """
		RequestMirror defines a schema for a filter that mirrors requests. Requests are sent to the specified destination, but responses from that destination are ignored. 
		 Support: Extended
		"""

																	properties: backendRef: {
																		description: """
		BackendRef references a resource where mirrored requests are sent. 
		 If the referent cannot be found, this BackendRef is invalid and must be dropped from the Gateway. The controller must ensure the \"ResolvedRefs\" condition on the Route status is set to `status: False` and not configure this backend in the underlying implementation. 
		 If there is a cross-namespace reference to an *existing* object that is not allowed by a ReferenceGrant, the controller must ensure the \"ResolvedRefs\"  condition on the Route is set to `status: False`, with the \"RefNotPermitted\" reason and not configure this backend in the underlying implementation. 
		 In either error case, the Message of the `ResolvedRefs` Condition should be used to provide more detail about the problem. 
		 Support: Extended for Kubernetes Service 
		 Support: Implementation-specific for any other resource
		"""

																		properties: {
																			group: {
																				default:     ""
																				description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																				maxLength: 253
																				pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																				type:      "string"
																			}
																			kind: {
																				default: "Service"
																				description: """
		Kind is the Kubernetes resource kind of the referent. For example \"Service\". 
		 Defaults to \"Service\" when not specified. 
		 ExternalName services can refer to CNAME DNS records that may live outside of the cluster and as such are difficult to reason about in terms of conformance. They also may not be safe to forward to (see CVE-2021-25740 for more information). Implementations SHOULD NOT support ExternalName Services. 
		 Support: Core (Services with a type other than ExternalName) 
		 Support: Implementation-specific (Services with type ExternalName)
		"""

																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																				type:      "string"
																			}
																			name: {
																				description: "Name is the name of the referent."
																				maxLength:   253
																				minLength:   1
																				type:        "string"
																			}
																			namespace: {
																				description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace different than the local namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

																				maxLength: 63
																				minLength: 1
																				pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																				type:      "string"
																			}
																			port: {
																				description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

																				format:  "int32"
																				maximum: 65535
																				minimum: 1
																				type:    "integer"
																			}
																		}
																		required: ["name"]
																		type: "object"
																	}
																	required: ["backendRef"]
																	type: "object"
																}
																requestRedirect: {
																	description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																		port: {
																			description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestMirror",
																		"RequestRedirect",
																		"URLRewrite",
																		"ExtensionRef",
																	]
																	type: "string"
																}
																urlRewrite: {
																	description: """
		URLRewrite defines a schema for a filter that modifies a request during forwarding. 
		 Support: Extended
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the value to be used to replace the Host header value during forwarding. 
		 Support: Extended
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines a path rewrite. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																	}
																	type: "object"
																}
															}
															required: ["type"]
															type: "object"
														}
														maxItems: 16
														type:     "array"
													}
													group: {
														default:     ""
														description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default: "Service"
														description: """
		Kind is the Kubernetes resource kind of the referent. For example \"Service\". 
		 Defaults to \"Service\" when not specified. 
		 ExternalName services can refer to CNAME DNS records that may live outside of the cluster and as such are difficult to reason about in terms of conformance. They also may not be safe to forward to (see CVE-2021-25740 for more information). Implementations SHOULD NOT support ExternalName Services. 
		 Support: Core (Services with a type other than ExternalName) 
		 Support: Implementation-specific (Services with type ExternalName)
		"""

														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace different than the local namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
		Weight specifies the proportion of requests forwarded to the referenced backend. This is computed as weight/(sum of all weights in this BackendRefs list). For non-zero values, there may be some epsilon from the exact proportion defined here depending on the precision an implementation supports. Weight is not a percentage and the sum of weights does not need to equal 100. 
		 If only one backend is specified and it has a weight greater than 0, 100% of the traffic is forwarded to that backend. If weight is set to 0, no traffic should be forwarded for this entry. If unspecified, weight defaults to 1. 
		 Support for this field varies based on the context where used.
		"""

														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
		Filters define the filters that are applied to requests that match this rule. 
		 The effects of ordering of multiple behaviors are currently unspecified. This can change in the future based on feedback during the alpha stage. 
		 Conformance-levels at this level are defined based on the type of filter: 
		 - ALL core filters MUST be supported by all implementations. - Implementers are encouraged to support extended filters. - Implementation-specific custom filters have no API guarantees across implementations. 
		 Specifying a core filter multiple times has unspecified or implementation-specific conformance. 
		 All filters are expected to be compatible with each other except for the URLRewrite and RequestRedirect filters, which may not be combined. If an implementation can not support other combinations of filters, they must clearly document that limitation. In all cases where incompatible or unsupported filters are specified, implementations MUST add a warning condition to status. 
		 Support: Core
		"""

											items: {
												description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

												properties: {
													extensionRef: {
														description: """
		ExtensionRef is an optional, implementation-specific extension to the \"filter\" behavior.  For example, resource \"myroutefilter\" in group \"networking.example.net\"). ExtensionRef MUST NOT be used for core and extended filters. 
		 Support: Implementation-specific
		"""

														properties: {
															group: {
																description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																maxLength: 253
																pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															kind: {
																description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\"."

																maxLength: 63
																minLength: 1
																pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																type:      "string"
															}
															name: {
																description: "Name is the name of the referent."
																maxLength:   253
																minLength:   1
																type:        "string"
															}
														}
														required: [
															"group",
															"kind",
															"name",
														]
														type: "object"
													}
													requestHeaderModifier: {
														description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestMirror: {
														description: """
		RequestMirror defines a schema for a filter that mirrors requests. Requests are sent to the specified destination, but responses from that destination are ignored. 
		 Support: Extended
		"""

														properties: backendRef: {
															description: """
		BackendRef references a resource where mirrored requests are sent. 
		 If the referent cannot be found, this BackendRef is invalid and must be dropped from the Gateway. The controller must ensure the \"ResolvedRefs\" condition on the Route status is set to `status: False` and not configure this backend in the underlying implementation. 
		 If there is a cross-namespace reference to an *existing* object that is not allowed by a ReferenceGrant, the controller must ensure the \"ResolvedRefs\"  condition on the Route is set to `status: False`, with the \"RefNotPermitted\" reason and not configure this backend in the underlying implementation. 
		 In either error case, the Message of the `ResolvedRefs` Condition should be used to provide more detail about the problem. 
		 Support: Extended for Kubernetes Service 
		 Support: Implementation-specific for any other resource
		"""

															properties: {
																group: {
																	default:     ""
																	description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

																	maxLength: 253
																	pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																	type:      "string"
																}
																kind: {
																	default: "Service"
																	description: """
		Kind is the Kubernetes resource kind of the referent. For example \"Service\". 
		 Defaults to \"Service\" when not specified. 
		 ExternalName services can refer to CNAME DNS records that may live outside of the cluster and as such are difficult to reason about in terms of conformance. They also may not be safe to forward to (see CVE-2021-25740 for more information). Implementations SHOULD NOT support ExternalName Services. 
		 Support: Core (Services with a type other than ExternalName) 
		 Support: Implementation-specific (Services with type ExternalName)
		"""

																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
																	type:      "string"
																}
																name: {
																	description: "Name is the name of the referent."
																	maxLength:   253
																	minLength:   1
																	type:        "string"
																}
																namespace: {
																	description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace different than the local namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

																	maxLength: 63
																	minLength: 1
																	pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
																	type:      "string"
																}
																port: {
																	description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

																	format:  "int32"
																	maximum: 65535
																	minimum: 1
																	type:    "integer"
																}
															}
															required: ["name"]
															type: "object"
														}
														required: ["backendRef"]
														type: "object"
													}
													requestRedirect: {
														description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
															port: {
																description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													responseHeaderModifier: {
														description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													type: {
														description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

														enum: [
															"RequestHeaderModifier",
															"ResponseHeaderModifier",
															"RequestMirror",
															"RequestRedirect",
															"URLRewrite",
															"ExtensionRef",
														]
														type: "string"
													}
													urlRewrite: {
														description: """
		URLRewrite defines a schema for a filter that modifies a request during forwarding. 
		 Support: Extended
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the value to be used to replace the Host header value during forwarding. 
		 Support: Extended
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines a path rewrite. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["type"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
		Matches define conditions used for matching the rule against incoming HTTP requests. Each match is independent, i.e. this rule will be matched if **any** one of the matches is satisfied. 
		 For example, take the following matches configuration: 
		 ``` matches: - path: value: \"/foo\" headers: - name: \"version\" value: \"v2\" - path: value: \"/v2/foo\" ``` 
		 For a request to match against this rule, a request must satisfy EITHER of the two conditions: 
		 - path prefixed with `/foo` AND contains the header `version: v2` - path prefix of `/v2/foo` 
		 See the documentation for HTTPRouteMatch on how to specify multiple match conditions that should be ANDed together. 
		 If no matches are specified, the default is a prefix path match on \"/\", which has the effect of matching every HTTP request. 
		 Proxy or Load Balancer routing configuration generated from HTTPRoutes MUST prioritize matches based on the following criteria, continuing on ties. Across all rules specified on applicable Routes, precedence must be given to the match having: 
		 * \"Exact\" path match. * \"Prefix\" path match with largest number of characters. * Method match. * Largest number of header matches. * Largest number of query param matches. 
		 Note: The precedence of RegularExpression path matches are implementation-specific. 
		 If ties still exist across multiple Routes, matching precedence MUST be determined in order of the following criteria, continuing on ties: 
		 * The oldest Route based on creation timestamp. * The Route appearing first in alphabetical order by \"{namespace}/{name}\". 
		 If ties still exist within an HTTPRoute, matching precedence MUST be granted to the FIRST matching rule (in list order) with a match meeting the above criteria. 
		 When no rules matching a request have been successfully attached to the parent a request is coming from, a HTTP 404 status code MUST be returned.
		"""

											items: {
												description: """
		HTTPRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together, i.e. the match will evaluate to true only if all conditions are satisfied. 
		 For example, the match below will match a HTTP request only if its path starts with `/foo` AND it contains the `version: v1` header: 
		 ``` match: 
		 path: value: \"/foo\" headers: - name: \"version\" value \"v1\" 
		 ```
		"""

												properties: {
													headers: {
														description: "Headers specifies HTTP request header matchers. Multiple match values are ANDed together, meaning, a request must match all the specified headers to select the route."

														items: {
															description: "HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request headers."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent. 
		 When a header is repeated in an HTTP request, it is implementation-specific behavior as to how this is represented. Generally, proxies should follow the guidance from the RFC: https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding processing a repeated header, with special handling for \"Set-Cookie\".
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the header. 
		 Support: Core (Exact) 
		 Support: Implementation-specific (RegularExpression) 
		 Since RegularExpression HeaderMatchType has implementation-specific conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."

																	maxLength: 4096
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
		Method specifies HTTP method matcher. When specified, this route will be matched only if the request has the specified method. 
		 Support: Extended
		"""

														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: "Path specifies a HTTP request path matcher. If this field is not specified, a default prefix match on the \"/\" path is provided."

														properties: {
															type: {
																default: "PathPrefix"
																description: """
		Type specifies how to match against the path Value. 
		 Support: Core (Exact, PathPrefix) 
		 Support: Implementation-specific (RegularExpression)
		"""

																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
													}
													queryParams: {
														description: """
		QueryParams specifies HTTP query parameter matchers. Multiple match values are ANDed together, meaning, a request must match all the specified query parameters to select the route. 
		 Support: Extended
		"""

														items: {
															description: "HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP query parameters."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP query param to be matched. This must be an exact string match. (See https://tools.ietf.org/html/rfc7230#section-2.7.3). 
		 If multiple entries specify equivalent query param names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent query param name MUST be ignored. 
		 If a query param is repeated in an HTTP request, the behavior is purposely left undefined, since different data planes have different capabilities. However, it is *recommended* that implementations should match against the first value of the param if the data plane supports it, as this behavior is expected in other load balancing contexts outside of the Gateway API. 
		 Users SHOULD NOT route traffic based on repeated query params to guard themselves against potential differences in the implementations.
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the query parameter. 
		 Support: Extended (Exact) 
		 Support: Implementation-specific (RegularExpression) 
		 Since RegularExpression QueryParamMatchType has Implementation-specific conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."

																	maxLength: 1024
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
		Parents is a list of parent resources (usually Gateways) that are associated with the route, and the status of the route with respect to each parent. When this route attaches to a parent, the controller that manages the parent must add an entry to this list when the controller first sees the route and should update the entry as appropriate when the route or gateway is modified. 
		 Note that parent references that cannot be resolved by an implementation of this API will not be added to this list. Implementations of this API can only populate Route status for the Gateways/parent resources they are responsible for. 
		 A maximum of 32 Gateways will be represented in this list. An empty list means the route has not been attached to any Gateway.
		"""

							items: {
								description: "RouteParentStatus describes the status of a route with respect to an associated Parent."

								properties: {
									conditions: {
										description: """
		Conditions describes the status of the route with respect to the Gateway. Note that the route's availability is also subject to the Gateway's own status conditions and listener status. 
		 If the Route's ParentRef specifies an existing Gateway that supports Routes of this kind AND that Gateway's controller has sufficient access, then that Gateway's controller MUST set the \"Accepted\" condition on the Route, to indicate whether the route has been accepted or rejected by the Gateway, and why. 
		 A Route MUST be considered \"Accepted\" if at least one of the Route's rules is implemented by the Gateway. 
		 There are a number of cases where the \"Accepted\" condition may not be set due to lack of controller visibility, that includes when: 
		 * The Route refers to a non-existent parent. * The Route is of a type that the controller does not support. * The Route is in a namespace the controller does not have access to.
		"""

										items: {
											description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

											properties: {
												lastTransitionTime: {
													description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

													format: "date-time"
													type:   "string"
												}
												message: {
													description: "message is a human readable message indicating details about the transition. This may be an empty string."

													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."

													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
		ControllerName is a domain/path string that indicates the name of the controller that wrote this status. This corresponds with the controllerName field on GatewayClass. 
		 Example: \"example.net/gateway-controller\". 
		 The format of this field is DOMAIN \"/\" PATH, where DOMAIN and PATH are valid Kubernetes names (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names). 
		 Controllers MUST populate this field when writing status. Controllers should ensure that entries to status populated with their ControllerName are cleaned up when they are no longer necessary.
		"""

										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: "ParentRef corresponds with a ParentRef in the spec that this RouteParentStatus struct describes the status of."

										properties: {
											group: {
												default: "gateway.networking.k8s.io"
												description: """
		Group is the group of the referent. When unspecified, \"gateway.networking.k8s.io\" is inferred. To set the core API group (such as for a \"Service\" kind referent), Group must be explicitly set to \"\" (empty string). 
		 Support: Core
		"""

												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) 
		 Support: Implementation-specific (Other Resources)
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
		Name is the name of the referent. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
		Namespace is the namespace of the referent. When unspecified, this refers to the local namespace of the Route. 
		 Note that there are specific rules for ParentRefs which cross namespace boundaries. Cross-namespace references are only valid if they are explicitly allowed by something in the namespace they are referring to. For example: Gateway has the AllowedRoutes field, and ReferenceGrant provides a generic way to enable any other kind of cross-namespace reference. 
		 Support: Core
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											port: {
												description: """
		Port is the network port this Route targets. It can be interpreted differently based on the type of parent resource. 
		 When the parent resource is a Gateway, this targets all listeners listening on the specified port that also support this kind of Route(and select this Route). It's not recommended to set `Port` unless the networking behaviors specified in a Route must apply to a specific port as opposed to a listener(s) whose port(s) may be changed. When both Port and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support other parent resources. Implementations supporting other types of parent resources MUST clearly document how/if Port is interpreted. 
		 For the purpose of status, an attachment is considered successful as long as the parent resource accepts it partially. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Extended 
		 <gateway:experimental>
		"""

												format:  "int32"
												maximum: 65535
												minimum: 1
												type:    "integer"
											}
											sectionName: {
												description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
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
	status: {
		acceptedNames: {
			kind:   ""
			plural: ""
		}
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "httproutes.policy.linkerd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "linkerd.io/created-by": "linkerd/helm %!s(<nil>)"
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "httproutes.policy.linkerd.io"
	}
	spec: {
		group: "policy.linkerd.io"
		names: {
			kind:     "HTTPRoute"
			listKind: "HTTPRouteList"
			plural:   "httproutes"
			singular: "httproute"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "HTTPRoute provides a way to route HTTP requests. This includes the capability to match requests by hostname, path, header, or query param. Filters can be used to specify additional processing steps. Backends specify where matching requests should be routed."

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
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
		Hostnames defines a set of hostname that should match against the HTTP Host header to select a HTTPRoute to process the request. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 If a hostname is specified by both the Listener and HTTPRoute, there must be at least one intersecting hostname for the HTTPRoute to be attached to the Listener. For example: 
		 * A Listener with `test.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames, or have specified at   least one of `test.example.com` or `*.example.com`. * A Listener with `*.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames or have specified at least   one hostname that matches the Listener hostname. For example,   `*.example.com`, `test.example.com`, and `foo.test.example.com` would   all match. On the other hand, `example.com` and `test.example.net` would   not match. 
		 Hostnames that are prefixed with a wildcard label (`*.`) are interpreted as a suffix match. That means that a match for `*.example.com` would match both `test.example.com`, and `foo.test.example.com`, but not `example.com`. 
		 If both the Listener and HTTPRoute have specified hostnames, any HTTPRoute hostnames that do not match the Listener hostname MUST be ignored. For example, if a Listener specified `*.example.com`, and the HTTPRoute specified `test.example.com` and `test.example.net`, `test.example.net` must not be considered for a match. 
		 If both the Listener and HTTPRoute have specified hostnames, and none match with the criteria above, then the HTTPRoute is not accepted. The implementation must raise an 'Accepted' Condition with a status of `False` in the corresponding RouteParentStatus. 
		 Support: Core
		"""

								items: {
									description: """
		Hostname is the fully qualified domain name of a network host. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 Hostname can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.example.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. `*.example.com`). 
		 Note that as per RFC1035 and RFC1123, a *label* must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character. No other punctuation is allowed.
		"""

									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
		ParentRefs references the resources (usually Gateways) that a Route wants to be attached to. Note that the referenced parent resource needs to allow this for the attachment to be complete. For Gateways, that means the Gateway needs to allow attachment from Routes of this kind and namespace. 
		 The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources such as one of the route kinds. 
		 It is invalid to reference an identical parent more than once. It is valid to reference multiple distinct sections within the same parent resource, such as 2 Listeners within a Gateway. 
		 It is possible to separately reference multiple distinct objects that may be collapsed by an implementation. For example, some implementations may choose to merge compatible Gateway Listeners together. If that is the case, the list of routes attached to those resources should also be merged.
		"""

								items: {
									description: """
		ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
		 The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
		"""

									properties: {
										group: {
											default: "policy.linkerd.io"
											description: """
		Group is the group of the referent. 
		 Support: Core
		"""

											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
		Name is the name of the referent. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: "port"
											type:        "integer"
										}
										sectionName: {
											description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: "HTTPRouteRule defines semantics for matching an HTTP request based on conditions (matches) and processing it (filters)."

									properties: {
										backendRefs: {
											items: {
												properties: {
													filters: {
														description: """
		Filters defined at this level should be executed if and only if the request is being forwarded to the backend defined here. 
		 Support: Implementation-specific (For broader support of filters, use the Filters field in HTTPRouteRule.)
		"""

														items: {
															description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

															properties: {
																requestHeaderModifier: {
																	description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestRedirect: {
																	description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																		port: {
																			description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestRedirect",
																	]
																	type: "string"
																}
															}
															required: ["type"]
															type: "object"
														}
														maxItems: 16
														type:     "array"
													}
													name: type: "string"
													namespace: {
														default: "default"
														type:    "string"
													}
													port: type: "integer"
												}
												type: "object"
											}
											type: "array"
										}
										filters: {
											description: """
		Filters define the filters that are applied to requests that match this rule. 
		 The effects of ordering of multiple behaviors are currently unspecified. This can change in the future based on feedback during the alpha stage. 
		 Conformance-levels at this level are defined based on the type of filter: 
		 - ALL core filters MUST be supported by all implementations. - Implementers are encouraged to support extended filters. - Implementation-specific custom filters have no API guarantees across   implementations. 
		 Specifying a core filter multiple times has unspecified or custom conformance. 
		 All filters are expected to be compatible with each other except for the URLRewrite and RequestRedirect filters, which may not be combined. If an implementation can not support other combinations of filters, they must clearly document that limitation. In all cases where incompatible or unsupported filters are specified, implementations MUST add a warning condition to status. 
		 Support: Core
		"""

											items: {
												description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

												properties: {
													requestHeaderModifier: {
														description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   add:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: foo   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input:   GET /foo HTTP/1.1   my-header1: foo   my-header2: bar   my-header3: baz 
		 Config:   remove: [\"my-header1\", \"my-header3\"] 
		 Output:   GET /foo HTTP/1.1   my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   set:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestRedirect: {
														description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname of the request is used. 
		 Support: Core
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
															port: {
																description: """
		Port is the port to be used in the value of the `Location` header in the response. When empty, port (if specified) of the request is used. 
		 Support: Extended
		"""

																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Support: Extended
		"""

																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
		StatusCode is the HTTP status code to be used in response. 
		 Support: Core
		"""

																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													type: {
														description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by   \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All   implementations must support core filters. 

		 
		"""

														enum: [
															"RequestHeaderModifier",
															"RequestRedirect",
														]
														type: "string"
													}
												}
												required: ["type"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
		Matches define conditions used for matching the rule against incoming HTTP requests. Each match is independent, i.e. this rule will be matched if **any** one of the matches is satisfied. 
		 For example, take the following matches configuration: 
		 ``` matches: - path:     value: \"/foo\"   headers:   - name: \"version\"     value: \"v2\" - path:     value: \"/v2/foo\" ``` 
		 For a request to match against this rule, a request must satisfy EITHER of the two conditions: 
		 - path prefixed with `/foo` AND contains the header `version: v2` - path prefix of `/v2/foo` 
		 See the documentation for HTTPRouteMatch on how to specify multiple match conditions that should be ANDed together. 
		 If no matches are specified, the default is a prefix path match on \"/\", which has the effect of matching every HTTP request. 
		 Proxy or Load Balancer routing configuration generated from HTTPRoutes MUST prioritize rules based on the following criteria, continuing on ties. Precedence must be given to the the Rule with the largest number of: 
		 * Characters in a matching non-wildcard hostname. * Characters in a matching hostname. * Characters in a matching path. * Header matches. * Query param matches. 
		 If ties still exist across multiple Routes, matching precedence MUST be determined in order of the following criteria, continuing on ties: 
		 * The oldest Route based on creation timestamp. * The Route appearing first in alphabetical order by   \"{namespace}/{name}\". 
		 If ties still exist within the Route that has been given precedence, matching precedence MUST be granted to the first matching rule meeting the above criteria. 
		 When no rules matching a request have been successfully attached to the parent a request is coming from, a HTTP 404 status code MUST be returned.
		"""

											items: {
												description: """
		HTTPRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together, i.e. the match will evaluate to true only if all conditions are satisfied. 
		 For example, the match below will match a HTTP request only if its path starts with `/foo` AND it contains the `version: v1` header: 
		 ``` match:   path:     value: \"/foo\"   headers:   - name: \"version\"     value \"v1\" ```
		"""

												properties: {
													headers: {
														description: "Headers specifies HTTP request header matchers. Multiple match values are ANDed together, meaning, a request must match all the specified headers to select the route."

														items: {
															description: "HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request headers."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent. 
		 When a header is repeated in an HTTP request, it is implementation-specific behavior as to how this is represented. Generally, proxies should follow the guidance from the RFC: https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding processing a repeated header, with special handling for \"Set-Cookie\".
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the header. 
		 Support: Core (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression HeaderMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."

																	maxLength: 4096
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
		Method specifies HTTP method matcher. When specified, this route will be matched only if the request has the specified method. 
		 Support: Extended
		"""

														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: "Path specifies a HTTP request path matcher. If this field is not specified, a default prefix match on the \"/\" path is provided."

														properties: {
															type: {
																default: "PathPrefix"
																description: """
		Type specifies how to match against the path Value. 
		 Support: Core (Exact, PathPrefix) 
		 Support: Custom (RegularExpression)
		"""

																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
													}
													queryParams: {
														description: "QueryParams specifies HTTP query parameter matchers. Multiple match values are ANDed together, meaning, a request must match all the specified query parameters to select the route."

														items: {
															description: "HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP query parameters."

															properties: {
																name: {
																	description: "Name is the name of the HTTP query param to be matched. This must be an exact string match. (See https://tools.ietf.org/html/rfc7230#section-2.7.3)."

																	maxLength: 256
																	minLength: 1
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the query parameter. 
		 Support: Extended (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression QueryParamMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."

																	maxLength: 1024
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
		Parents is a list of parent resources (usually Gateways) that are associated with the route, and the status of the route with respect to each parent. When this route attaches to a parent, the controller that manages the parent must add an entry to this list when the controller first sees the route and should update the entry as appropriate when the route or gateway is modified. 
		 Note that parent references that cannot be resolved by an implementation of this API will not be added to this list. Implementations of this API can only populate Route status for the Gateways/parent resources they are responsible for. 
		 A maximum of 32 Gateways will be represented in this list. An empty list means the route has not been attached to any Gateway.
		"""

							items: {
								description: "RouteParentStatus describes the status of a route with respect to an associated Parent."

								properties: {
									conditions: {
										description: """
		Conditions describes the status of the route with respect to the Gateway. Note that the route's availability is also subject to the Gateway's own status conditions and listener status. 
		 If the Route's ParentRef specifies an existing Gateway that supports Routes of this kind AND that Gateway's controller has sufficient access, then that Gateway's controller MUST set the \"Accepted\" condition on the Route, to indicate whether the route has been accepted or rejected by the Gateway, and why. 
		 A Route MUST be considered \"Accepted\" if at least one of the Route's rules is implemented by the Gateway. 
		 There are a number of cases where the \"Accepted\" condition may not be set due to lack of controller visibility, that includes when: 
		 * The Route refers to a non-existent parent. * The Route is of a type that the controller does not support. * The Route is in a namespace the the controller does not have access to.
		"""

										items: {
											description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		     // other fields }
		"""

											properties: {
												lastTransitionTime: {
													description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

													format: "date-time"
													type:   "string"
												}
												message: {
													description: "message is a human readable message indicating details about the transition. This may be an empty string."

													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."

													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
		ControllerName is a domain/path string that indicates the name of the controller that wrote this status. This corresponds with the controllerName field on GatewayClass. 
		 Example: \"example.net/gateway-controller\". 
		 The format of this field is DOMAIN \"/\" PATH, where DOMAIN and PATH are valid Kubernetes names (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names). 
		 Controllers MUST populate this field when writing status. Controllers should ensure that entries to status populated with their ControllerName are cleaned up when they are no longer necessary.
		"""

										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: "ParentRef corresponds with a ParentRef in the spec that this RouteParentStatus struct describes the status of."

										properties: {
											group: {
												default: "policy.linkerd.io"
												description: """
		Group is the group of the referent. 
		 Support: Core
		"""

												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
		Name is the name of the referent. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											sectionName: {
												description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "HTTPRoute provides a way to route HTTP requests. This includes the capability to match requests by hostname, path, header, or query param. Filters can be used to specify additional processing steps. Backends specify where matching requests should be routed."

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
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
		Hostnames defines a set of hostname that should match against the HTTP Host header to select a HTTPRoute to process the request. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 If a hostname is specified by both the Listener and HTTPRoute, there must be at least one intersecting hostname for the HTTPRoute to be attached to the Listener. For example: 
		 * A Listener with `test.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames, or have specified at   least one of `test.example.com` or `*.example.com`. * A Listener with `*.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames or have specified at least   one hostname that matches the Listener hostname. For example,   `*.example.com`, `test.example.com`, and `foo.test.example.com` would   all match. On the other hand, `example.com` and `test.example.net` would   not match. 
		 Hostnames that are prefixed with a wildcard label (`*.`) are interpreted as a suffix match. That means that a match for `*.example.com` would match both `test.example.com`, and `foo.test.example.com`, but not `example.com`. 
		 If both the Listener and HTTPRoute have specified hostnames, any HTTPRoute hostnames that do not match the Listener hostname MUST be ignored. For example, if a Listener specified `*.example.com`, and the HTTPRoute specified `test.example.com` and `test.example.net`, `test.example.net` must not be considered for a match. 
		 If both the Listener and HTTPRoute have specified hostnames, and none match with the criteria above, then the HTTPRoute is not accepted. The implementation must raise an 'Accepted' Condition with a status of `False` in the corresponding RouteParentStatus. 
		 Support: Core
		"""

								items: {
									description: """
		Hostname is the fully qualified domain name of a network host. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 Hostname can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.example.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. `*.example.com`). 
		 Note that as per RFC1035 and RFC1123, a *label* must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character. No other punctuation is allowed.
		"""

									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
		ParentRefs references the resources (usually Gateways) that a Route wants to be attached to. Note that the referenced parent resource needs to allow this for the attachment to be complete. For Gateways, that means the Gateway needs to allow attachment from Routes of this kind and namespace. 
		 The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources such as one of the route kinds. 
		 It is invalid to reference an identical parent more than once. It is valid to reference multiple distinct sections within the same parent resource, such as 2 Listeners within a Gateway. 
		 It is possible to separately reference multiple distinct objects that may be collapsed by an implementation. For example, some implementations may choose to merge compatible Gateway Listeners together. If that is the case, the list of routes attached to those resources should also be merged.
		"""

								items: {
									description: """
		ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
		 The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
		"""

									properties: {
										group: {
											default: "policy.linkerd.io"
											description: """
		Group is the group of the referent. 
		 Support: Core
		"""

											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
		Name is the name of the referent. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: "port"
											type:        "integer"
										}
										sectionName: {
											description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: "HTTPRouteRule defines semantics for matching an HTTP request based on conditions (matches) and processing it (filters)."

									properties: {
										backendRefs: {
											items: {
												properties: {
													filters: {
														description: """
		Filters defined at this level should be executed if and only if the request is being forwarded to the backend defined here. 
		 Support: Implementation-specific (For broader support of filters, use the Filters field in HTTPRouteRule.)
		"""

														items: {
															description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

															properties: {
																requestHeaderModifier: {
																	description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestRedirect: {
																	description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																		port: {
																			description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestRedirect",
																	]
																	type: "string"
																}
															}
															required: ["type"]
															type: "object"
														}
														maxItems: 16
														type:     "array"
													}
													name: type: "string"
													namespace: {
														default: "default"
														type:    "string"
													}
													port: type: "integer"
												}
												type: "object"
											}
											type: "array"
										}
										filters: {
											description: """
		Filters define the filters that are applied to requests that match this rule. 
		 The effects of ordering of multiple behaviors are currently unspecified. This can change in the future based on feedback during the alpha stage. 
		 Conformance-levels at this level are defined based on the type of filter: 
		 - ALL core filters MUST be supported by all implementations. - Implementers are encouraged to support extended filters. - Implementation-specific custom filters have no API guarantees across   implementations. 
		 Specifying a core filter multiple times has unspecified or custom conformance. 
		 All filters are expected to be compatible with each other except for the URLRewrite and RequestRedirect filters, which may not be combined. If an implementation can not support other combinations of filters, they must clearly document that limitation. In all cases where incompatible or unsupported filters are specified, implementations MUST add a warning condition to status. 
		 Support: Core
		"""

											items: {
												description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

												properties: {
													requestHeaderModifier: {
														description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   add:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: foo   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input:   GET /foo HTTP/1.1   my-header1: foo   my-header2: bar   my-header3: baz 
		 Config:   remove: [\"my-header1\", \"my-header3\"] 
		 Output:   GET /foo HTTP/1.1   my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   set:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestRedirect: {
														description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname of the request is used. 
		 Support: Core
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
															port: {
																description: """
		Port is the port to be used in the value of the `Location` header in the response. When empty, port (if specified) of the request is used. 
		 Support: Extended
		"""

																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Support: Extended
		"""

																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
		StatusCode is the HTTP status code to be used in response. 
		 Support: Core
		"""

																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													type: {
														description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by   \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\".
		"""

														enum: [
															"RequestHeaderModifier",
															"RequestRedirect",
														]
														type: "string"
													}
												}
												required: ["type"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
		Matches define conditions used for matching the rule against incoming HTTP requests. Each match is independent, i.e. this rule will be matched if **any** one of the matches is satisfied. 
		 For example, take the following matches configuration: 
		 ``` matches: - path:     value: \"/foo\"   headers:   - name: \"version\"     value: \"v2\" - path:     value: \"/v2/foo\" ``` 
		 For a request to match against this rule, a request must satisfy EITHER of the two conditions: 
		 - path prefixed with `/foo` AND contains the header `version: v2` - path prefix of `/v2/foo` 
		 See the documentation for HTTPRouteMatch on how to specify multiple match conditions that should be ANDed together. 
		 If no matches are specified, the default is a prefix path match on \"/\", which has the effect of matching every HTTP request. 
		 Proxy or Load Balancer routing configuration generated from HTTPRoutes MUST prioritize rules based on the following criteria, continuing on ties. Precedence must be given to the the Rule with the largest number of: 
		 * Characters in a matching non-wildcard hostname. * Characters in a matching hostname. * Characters in a matching path. * Header matches. * Query param matches. 
		 If ties still exist across multiple Routes, matching precedence MUST be determined in order of the following criteria, continuing on ties: 
		 * The oldest Route based on creation timestamp. * The Route appearing first in alphabetical order by   \"{namespace}/{name}\". 
		 If ties still exist within the Route that has been given precedence, matching precedence MUST be granted to the first matching rule meeting the above criteria. 
		 When no rules matching a request have been successfully attached to the parent a request is coming from, a HTTP 404 status code MUST be returned.
		"""

											items: {
												description: """
		HTTPRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together, i.e. the match will evaluate to true only if all conditions are satisfied. 
		 For example, the match below will match a HTTP request only if its path starts with `/foo` AND it contains the `version: v1` header: 
		 ``` match:   path:     value: \"/foo\"   headers:   - name: \"version\"     value \"v1\" ```
		"""

												properties: {
													headers: {
														description: "Headers specifies HTTP request header matchers. Multiple match values are ANDed together, meaning, a request must match all the specified headers to select the route."

														items: {
															description: "HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request headers."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent. 
		 When a header is repeated in an HTTP request, it is implementation-specific behavior as to how this is represented. Generally, proxies should follow the guidance from the RFC: https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding processing a repeated header, with special handling for \"Set-Cookie\".
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the header. 
		 Support: Core (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression HeaderMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."

																	maxLength: 4096
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
		Method specifies HTTP method matcher. When specified, this route will be matched only if the request has the specified method. 
		 Support: Extended
		"""

														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: "Path specifies a HTTP request path matcher. If this field is not specified, a default prefix match on the \"/\" path is provided."

														properties: {
															type: {
																default: "PathPrefix"
																description: """
		Type specifies how to match against the path Value. 
		 Support: Core (Exact, PathPrefix) 
		 Support: Custom (RegularExpression)
		"""

																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
													}
													queryParams: {
														description: "QueryParams specifies HTTP query parameter matchers. Multiple match values are ANDed together, meaning, a request must match all the specified query parameters to select the route."

														items: {
															description: "HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP query parameters."

															properties: {
																name: {
																	description: "Name is the name of the HTTP query param to be matched. This must be an exact string match. (See https://tools.ietf.org/html/rfc7230#section-2.7.3)."

																	maxLength: 256
																	minLength: 1
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the query parameter. 
		 Support: Extended (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression QueryParamMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."

																	maxLength: 1024
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
		Parents is a list of parent resources (usually Gateways) that are associated with the route, and the status of the route with respect to each parent. When this route attaches to a parent, the controller that manages the parent must add an entry to this list when the controller first sees the route and should update the entry as appropriate when the route or gateway is modified. 
		 Note that parent references that cannot be resolved by an implementation of this API will not be added to this list. Implementations of this API can only populate Route status for the Gateways/parent resources they are responsible for. 
		 A maximum of 32 Gateways will be represented in this list. An empty list means the route has not been attached to any Gateway.
		"""

							items: {
								description: "RouteParentStatus describes the status of a route with respect to an associated Parent."

								properties: {
									conditions: {
										description: """
		Conditions describes the status of the route with respect to the Gateway. Note that the route's availability is also subject to the Gateway's own status conditions and listener status. 
		 If the Route's ParentRef specifies an existing Gateway that supports Routes of this kind AND that Gateway's controller has sufficient access, then that Gateway's controller MUST set the \"Accepted\" condition on the Route, to indicate whether the route has been accepted or rejected by the Gateway, and why. 
		 A Route MUST be considered \"Accepted\" if at least one of the Route's rules is implemented by the Gateway. 
		 There are a number of cases where the \"Accepted\" condition may not be set due to lack of controller visibility, that includes when: 
		 * The Route refers to a non-existent parent. * The Route is of a type that the controller does not support. * The Route is in a namespace the the controller does not have access to.
		"""

										items: {
											description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		     // other fields }
		"""

											properties: {
												lastTransitionTime: {
													description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

													format: "date-time"
													type:   "string"
												}
												message: {
													description: "message is a human readable message indicating details about the transition. This may be an empty string."

													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."

													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
		ControllerName is a domain/path string that indicates the name of the controller that wrote this status. This corresponds with the controllerName field on GatewayClass. 
		 Example: \"example.net/gateway-controller\". 
		 The format of this field is DOMAIN \"/\" PATH, where DOMAIN and PATH are valid Kubernetes names (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names). 
		 Controllers MUST populate this field when writing status. Controllers should ensure that entries to status populated with their ControllerName are cleaned up when they are no longer necessary.
		"""

										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: "ParentRef corresponds with a ParentRef in the spec that this RouteParentStatus struct describes the status of."

										properties: {
											group: {
												default: "policy.linkerd.io"
												description: """
		Group is the group of the referent. 
		 Support: Core
		"""

												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
		Name is the name of the referent. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											sectionName: {
												description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "HTTPRoute provides a way to route HTTP requests. This includes the capability to match requests by hostname, path, header, or query param. Filters can be used to specify additional processing steps. Backends specify where matching requests should be routed."

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
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
		Hostnames defines a set of hostname that should match against the HTTP Host header to select a HTTPRoute to process the request. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 If a hostname is specified by both the Listener and HTTPRoute, there must be at least one intersecting hostname for the HTTPRoute to be attached to the Listener. For example: 
		 * A Listener with `test.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames, or have specified at   least one of `test.example.com` or `*.example.com`. * A Listener with `*.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames or have specified at least   one hostname that matches the Listener hostname. For example,   `*.example.com`, `test.example.com`, and `foo.test.example.com` would   all match. On the other hand, `example.com` and `test.example.net` would   not match. 
		 Hostnames that are prefixed with a wildcard label (`*.`) are interpreted as a suffix match. That means that a match for `*.example.com` would match both `test.example.com`, and `foo.test.example.com`, but not `example.com`. 
		 If both the Listener and HTTPRoute have specified hostnames, any HTTPRoute hostnames that do not match the Listener hostname MUST be ignored. For example, if a Listener specified `*.example.com`, and the HTTPRoute specified `test.example.com` and `test.example.net`, `test.example.net` must not be considered for a match. 
		 If both the Listener and HTTPRoute have specified hostnames, and none match with the criteria above, then the HTTPRoute is not accepted. The implementation must raise an 'Accepted' Condition with a status of `False` in the corresponding RouteParentStatus. 
		 Support: Core
		"""

								items: {
									description: """
		Hostname is the fully qualified domain name of a network host. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 Hostname can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.example.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. `*.example.com`). 
		 Note that as per RFC1035 and RFC1123, a *label* must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character. No other punctuation is allowed.
		"""

									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
		ParentRefs references the resources (usually Gateways) that a Route wants to be attached to. Note that the referenced parent resource needs to allow this for the attachment to be complete. For Gateways, that means the Gateway needs to allow attachment from Routes of this kind and namespace. 
		 The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources such as one of the route kinds. 
		 It is invalid to reference an identical parent more than once. It is valid to reference multiple distinct sections within the same parent resource, such as 2 Listeners within a Gateway. 
		 It is possible to separately reference multiple distinct objects that may be collapsed by an implementation. For example, some implementations may choose to merge compatible Gateway Listeners together. If that is the case, the list of routes attached to those resources should also be merged.
		"""

								items: {
									description: """
		ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
		 The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
		"""

									properties: {
										group: {
											default: "policy.linkerd.io"
											description: """
		Group is the group of the referent. 
		 Support: Core
		"""

											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
		Name is the name of the referent. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
		Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field. 
		 Support: Extended
		"""

											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: "HTTPRouteRule defines semantics for matching an HTTP request based on conditions (matches) and processing it (filters)."

									properties: {
										backendRefs: {
											description: """
		BackendRefs defines the backend(s) where matching requests should be sent. 
		 Failure behavior here depends on how many BackendRefs are specified and how many are invalid. 
		 If *all* entries in BackendRefs are invalid, and there are also no filters specified in this route rule, *all* traffic which matches this rule MUST receive a 500 status code. 
		 See the HTTPBackendRef definition for the rules about what makes a single HTTPBackendRef invalid. 
		 When a HTTPBackendRef is invalid, 500 status codes MUST be returned for requests that would have otherwise been routed to an invalid backend. If multiple backends are specified, and some are invalid, the proportion of requests that would otherwise have been routed to an invalid backend MUST receive a 500 status code. 
		 For example, if two backends are specified with equal weights, and one is invalid, 50 percent of traffic must receive a 500. Implementations may choose how that 50 percent is determined. 
		 Support: Core for Kubernetes Service 
		 Support: Implementation-specific for any other resource 
		 Support for weight: Core
		"""

											items: {
												description: "HTTPBackendRef defines how a HTTPRoute should forward an HTTP request."

												properties: {
													filters: {
														description: """
		Filters defined at this level should be executed if and only if the request is being forwarded to the backend defined here. 
		 Support: Implementation-specific (For broader support of filters, use the Filters field in HTTPRouteRule.)
		"""

														items: {
															description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

															properties: {
																requestHeaderModifier: {
																	description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestRedirect: {
																	description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																		port: {
																			description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestRedirect",
																	]
																	type: "string"
																}
															}
															required: ["type"]
															type: "object"
														}
														maxItems: 16
														type:     "array"
													}
													group: {
														default:     ""
														description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default:     "Service"
														description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\". Defaults to \"Service\" when not specified."

														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
		Weight specifies the proportion of requests forwarded to the referenced backend. This is computed as weight/(sum of all weights in this BackendRefs list). For non-zero values, there may be some epsilon from the exact proportion defined here depending on the precision an implementation supports. Weight is not a percentage and the sum of weights does not need to equal 100. 
		 If only one backend is specified and it has a weight greater than 0, 100% of the traffic is forwarded to that backend. If weight is set to 0, no traffic should be forwarded for this entry. If unspecified, weight defaults to 1. 
		 Support for this field varies based on the context where used.
		"""

														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
		Filters define the filters that are applied to requests that match this rule. 
		 The effects of ordering of multiple behaviors are currently unspecified. This can change in the future based on feedback during the alpha stage. 
		 Conformance-levels at this level are defined based on the type of filter: 
		 - ALL core filters MUST be supported by all implementations. - Implementers are encouraged to support extended filters. - Implementation-specific custom filters have no API guarantees across   implementations. 
		 Specifying a core filter multiple times has unspecified or custom conformance. 
		 All filters are expected to be compatible with each other except for the URLRewrite and RequestRedirect filters, which may not be combined. If an implementation can not support other combinations of filters, they must clearly document that limitation. In all cases where incompatible or unsupported filters are specified, implementations MUST add a warning condition to status. 
		 Support: Core
		"""

											items: {
												description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

												properties: {
													requestHeaderModifier: {
														description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   add:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: foo   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input:   GET /foo HTTP/1.1   my-header1: foo   my-header2: bar   my-header3: baz 
		 Config:   remove: [\"my-header1\", \"my-header3\"] 
		 Output:   GET /foo HTTP/1.1   my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   set:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestRedirect: {
														description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname of the request is used. 
		 Support: Core
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
															port: {
																description: """
		Port is the port to be used in the value of the `Location` header in the response. When empty, port (if specified) of the request is used. 
		 Support: Extended
		"""

																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Support: Extended
		"""

																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
		StatusCode is the HTTP status code to be used in response. 
		 Support: Core
		"""

																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													type: {
														description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by   \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\".
		"""

														enum: [
															"RequestHeaderModifier",
															"RequestRedirect",
														]
														type: "string"
													}
												}
												required: ["type"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
		Matches define conditions used for matching the rule against incoming HTTP requests. Each match is independent, i.e. this rule will be matched if **any** one of the matches is satisfied. 
		 For example, take the following matches configuration: 
		 ``` matches: - path:     value: \"/foo\"   headers:   - name: \"version\"     value: \"v2\" - path:     value: \"/v2/foo\" ``` 
		 For a request to match against this rule, a request must satisfy EITHER of the two conditions: 
		 - path prefixed with `/foo` AND contains the header `version: v2` - path prefix of `/v2/foo` 
		 See the documentation for HTTPRouteMatch on how to specify multiple match conditions that should be ANDed together. 
		 If no matches are specified, the default is a prefix path match on \"/\", which has the effect of matching every HTTP request. 
		 Proxy or Load Balancer routing configuration generated from HTTPRoutes MUST prioritize rules based on the following criteria, continuing on ties. Precedence must be given to the the Rule with the largest number of: 
		 * Characters in a matching non-wildcard hostname. * Characters in a matching hostname. * Characters in a matching path. * Header matches. * Query param matches. 
		 If ties still exist across multiple Routes, matching precedence MUST be determined in order of the following criteria, continuing on ties: 
		 * The oldest Route based on creation timestamp. * The Route appearing first in alphabetical order by   \"{namespace}/{name}\". 
		 If ties still exist within the Route that has been given precedence, matching precedence MUST be granted to the first matching rule meeting the above criteria. 
		 When no rules matching a request have been successfully attached to the parent a request is coming from, a HTTP 404 status code MUST be returned.
		"""

											items: {
												description: """
		HTTPRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together, i.e. the match will evaluate to true only if all conditions are satisfied. 
		 For example, the match below will match a HTTP request only if its path starts with `/foo` AND it contains the `version: v1` header: 
		 ``` match:   path:     value: \"/foo\"   headers:   - name: \"version\"     value \"v1\" ```
		"""

												properties: {
													headers: {
														description: "Headers specifies HTTP request header matchers. Multiple match values are ANDed together, meaning, a request must match all the specified headers to select the route."

														items: {
															description: "HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request headers."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent. 
		 When a header is repeated in an HTTP request, it is implementation-specific behavior as to how this is represented. Generally, proxies should follow the guidance from the RFC: https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding processing a repeated header, with special handling for \"Set-Cookie\".
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the header. 
		 Support: Core (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression HeaderMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."

																	maxLength: 4096
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
		Method specifies HTTP method matcher. When specified, this route will be matched only if the request has the specified method. 
		 Support: Extended
		"""

														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: "Path specifies a HTTP request path matcher. If this field is not specified, a default prefix match on the \"/\" path is provided."

														properties: {
															type: {
																default: "PathPrefix"
																description: """
		Type specifies how to match against the path Value. 
		 Support: Core (Exact, PathPrefix) 
		 Support: Custom (RegularExpression)
		"""

																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
													}
													queryParams: {
														description: "QueryParams specifies HTTP query parameter matchers. Multiple match values are ANDed together, meaning, a request must match all the specified query parameters to select the route."

														items: {
															description: "HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP query parameters."

															properties: {
																name: {
																	description: "Name is the name of the HTTP query param to be matched. This must be an exact string match. (See https://tools.ietf.org/html/rfc7230#section-2.7.3)."

																	maxLength: 256
																	minLength: 1
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the query parameter. 
		 Support: Extended (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression QueryParamMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."

																	maxLength: 1024
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
		Parents is a list of parent resources (usually Gateways) that are associated with the route, and the status of the route with respect to each parent. When this route attaches to a parent, the controller that manages the parent must add an entry to this list when the controller first sees the route and should update the entry as appropriate when the route or gateway is modified. 
		 Note that parent references that cannot be resolved by an implementation of this API will not be added to this list. Implementations of this API can only populate Route status for the Gateways/parent resources they are responsible for. 
		 A maximum of 32 Gateways will be represented in this list. An empty list means the route has not been attached to any Gateway.
		"""

							items: {
								description: "RouteParentStatus describes the status of a route with respect to an associated Parent."

								properties: {
									conditions: {
										description: """
		Conditions describes the status of the route with respect to the Gateway. Note that the route's availability is also subject to the Gateway's own status conditions and listener status. 
		 If the Route's ParentRef specifies an existing Gateway that supports Routes of this kind AND that Gateway's controller has sufficient access, then that Gateway's controller MUST set the \"Accepted\" condition on the Route, to indicate whether the route has been accepted or rejected by the Gateway, and why. 
		 A Route MUST be considered \"Accepted\" if at least one of the Route's rules is implemented by the Gateway. 
		 There are a number of cases where the \"Accepted\" condition may not be set due to lack of controller visibility, that includes when: 
		 * The Route refers to a non-existent parent. * The Route is of a type that the controller does not support. * The Route is in a namespace the the controller does not have access to.
		"""

										items: {
											description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		     // other fields }
		"""

											properties: {
												lastTransitionTime: {
													description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

													format: "date-time"
													type:   "string"
												}
												message: {
													description: "message is a human readable message indicating details about the transition. This may be an empty string."

													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."

													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
		ControllerName is a domain/path string that indicates the name of the controller that wrote this status. This corresponds with the controllerName field on GatewayClass. 
		 Example: \"example.net/gateway-controller\". 
		 The format of this field is DOMAIN \"/\" PATH, where DOMAIN and PATH are valid Kubernetes names (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names). 
		 Controllers MUST populate this field when writing status. Controllers should ensure that entries to status populated with their ControllerName are cleaned up when they are no longer necessary.
		"""

										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: "ParentRef corresponds with a ParentRef in the spec that this RouteParentStatus struct describes the status of."

										properties: {
											group: {
												default: "policy.linkerd.io"
												description: """
		Group is the group of the referent. 
		 Support: Core
		"""

												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
		Name is the name of the referent. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											sectionName: {
												description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
						type: "object"
					}
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.hostnames"
				name:     "Hostnames"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta3"
			schema: openAPIV3Schema: {
				description: "HTTPRoute provides a way to route HTTP requests. This includes the capability to match requests by hostname, path, header, or query param. Filters can be used to specify additional processing steps. Backends specify where matching requests should be routed."

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
						description: "Spec defines the desired state of HTTPRoute."
						properties: {
							hostnames: {
								description: """
		Hostnames defines a set of hostname that should match against the HTTP Host header to select a HTTPRoute to process the request. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 If a hostname is specified by both the Listener and HTTPRoute, there must be at least one intersecting hostname for the HTTPRoute to be attached to the Listener. For example: 
		 * A Listener with `test.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames, or have specified at   least one of `test.example.com` or `*.example.com`. * A Listener with `*.example.com` as the hostname matches HTTPRoutes   that have either not specified any hostnames or have specified at least   one hostname that matches the Listener hostname. For example,   `*.example.com`, `test.example.com`, and `foo.test.example.com` would   all match. On the other hand, `example.com` and `test.example.net` would   not match. 
		 Hostnames that are prefixed with a wildcard label (`*.`) are interpreted as a suffix match. That means that a match for `*.example.com` would match both `test.example.com`, and `foo.test.example.com`, but not `example.com`. 
		 If both the Listener and HTTPRoute have specified hostnames, any HTTPRoute hostnames that do not match the Listener hostname MUST be ignored. For example, if a Listener specified `*.example.com`, and the HTTPRoute specified `test.example.com` and `test.example.net`, `test.example.net` must not be considered for a match. 
		 If both the Listener and HTTPRoute have specified hostnames, and none match with the criteria above, then the HTTPRoute is not accepted. The implementation must raise an 'Accepted' Condition with a status of `False` in the corresponding RouteParentStatus. 
		 Support: Core
		"""

								items: {
									description: """
		Hostname is the fully qualified domain name of a network host. This matches the RFC 1123 definition of a hostname with 2 notable exceptions: 
		 1. IPs are not allowed. 2. A hostname may be prefixed with a wildcard label (`*.`). The wildcard    label must appear by itself as the first label. 
		 Hostname can be \"precise\" which is a domain name without the terminating dot of a network host (e.g. \"foo.example.com\") or \"wildcard\", which is a domain name prefixed with a single wildcard label (e.g. `*.example.com`). 
		 Note that as per RFC1035 and RFC1123, a *label* must consist of lower case alphanumeric characters or '-', and must start and end with an alphanumeric character. No other punctuation is allowed.
		"""

									maxLength: 253
									minLength: 1
									pattern:   "^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
									type:      "string"
								}
								maxItems: 16
								type:     "array"
							}
							parentRefs: {
								description: """
		ParentRefs references the resources (usually Gateways) that a Route wants to be attached to. Note that the referenced parent resource needs to allow this for the attachment to be complete. For Gateways, that means the Gateway needs to allow attachment from Routes of this kind and namespace. 
		 The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources such as one of the route kinds. 
		 It is invalid to reference an identical parent more than once. It is valid to reference multiple distinct sections within the same parent resource, such as 2 Listeners within a Gateway. 
		 It is possible to separately reference multiple distinct objects that may be collapsed by an implementation. For example, some implementations may choose to merge compatible Gateway Listeners together. If that is the case, the list of routes attached to those resources should also be merged.
		"""

								items: {
									description: """
		ParentReference identifies an API object (usually a Gateway) that can be considered a parent of this resource (usually a route). The only kind of parent resource with \"Core\" support is Gateway. This API may be extended in the future to support additional kinds of parent resources, such as HTTPRoute. 
		 The API object must be valid in the cluster; the Group and Kind must be registered in the cluster for this reference to be valid.
		"""

									properties: {
										group: {
											default: "policy.linkerd.io"
											description: """
		Group is the group of the referent. 
		 Support: Core
		"""

											maxLength: 253
											pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
										kind: {
											default: "Gateway"
											description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
											type:      "string"
										}
										name: {
											description: """
		Name is the name of the referent. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

											maxLength: 63
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
											type:      "string"
										}
										port: {
											description: """
		Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field. 
		 Support: Extended
		"""

											format:  "int32"
											maximum: 65535
											minimum: 1
											type:    "integer"
										}
										sectionName: {
											description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

											maxLength: 253
											minLength: 1
											pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
											type:      "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								maxItems: 32
								type:     "array"
							}
							rules: {
								default: [{
									matches: [{
										path: {
											type:  "PathPrefix"
											value: "/"
										}
									}]
								}]
								description: "Rules are a list of HTTP matchers, filters and actions."
								items: {
									description: "HTTPRouteRule defines semantics for matching an HTTP request based on conditions (matches) and processing it (filters)."

									properties: {
										backendRefs: {
											description: """
		BackendRefs defines the backend(s) where matching requests should be sent. 
		 Failure behavior here depends on how many BackendRefs are specified and how many are invalid. 
		 If *all* entries in BackendRefs are invalid, and there are also no filters specified in this route rule, *all* traffic which matches this rule MUST receive a 500 status code. 
		 See the HTTPBackendRef definition for the rules about what makes a single HTTPBackendRef invalid. 
		 When a HTTPBackendRef is invalid, 500 status codes MUST be returned for requests that would have otherwise been routed to an invalid backend. If multiple backends are specified, and some are invalid, the proportion of requests that would otherwise have been routed to an invalid backend MUST receive a 500 status code. 
		 For example, if two backends are specified with equal weights, and one is invalid, 50 percent of traffic must receive a 500. Implementations may choose how that 50 percent is determined. 
		 Support: Core for Kubernetes Service 
		 Support: Implementation-specific for any other resource 
		 Support for weight: Core
		"""

											items: {
												description: "HTTPBackendRef defines how a HTTPRoute should forward an HTTP request."

												properties: {
													filters: {
														description: """
		Filters defined at this level should be executed if and only if the request is being forwarded to the backend defined here. 
		 Support: Implementation-specific (For broader support of filters, use the Filters field in HTTPRouteRule.)
		"""

														items: {
															description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

															properties: {
																requestHeaderModifier: {
																	description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																requestRedirect: {
																	description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

																	properties: {
																		hostname: {
																			description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname in the `Host` header of the request is used. 
		 Support: Core
		"""

																			maxLength: 253
																			minLength: 1
																			pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																			type:      "string"
																		}
																		path: {
																			description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																			properties: {
																				replaceFullPath: {
																					description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																					maxLength: 1024
																					type:      "string"
																				}
																				replacePrefixMatch: {
																					description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																					maxLength: 1024
																					type:      "string"
																				}
																				type: {
																					description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																					enum: [
																						"ReplaceFullPath",
																						"ReplacePrefixMatch",
																					]
																					type: "string"
																				}
																			}
																			required: ["type"]
																			type: "object"
																		}
																		port: {
																			description: """
		Port is the port to be used in the value of the `Location` header in the response. 
		 If no port is specified, the redirect port MUST be derived using the following rules: 
		 * If redirect scheme is not-empty, the redirect port MUST be the well-known port associated with the redirect scheme. Specifically \"http\" to port 80 and \"https\" to port 443. If the redirect scheme does not have a well-known port, the listener port of the Gateway SHOULD be used. * If redirect scheme is empty, the redirect port MUST be the Gateway Listener port. 
		 Implementations SHOULD NOT add the port number in the 'Location' header in the following cases: 
		 * A Location header that will use HTTP (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 80. * A Location header that will use HTTPS (whether that is determined via the Listener protocol or the Scheme field) _and_ use port 443. 
		 Support: Extended
		"""

																			format:  "int32"
																			maximum: 65535
																			minimum: 1
																			type:    "integer"
																		}
																		scheme: {
																			description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Scheme redirects can affect the port of the redirect, for more information, refer to the documentation for the port field of this filter. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Extended
		"""

																			enum: [
																				"http",
																				"https",
																			]
																			type: "string"
																		}
																		statusCode: {
																			default: 302
																			description: """
		StatusCode is the HTTP status code to be used in response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`. 
		 Support: Core
		"""

																			enum: [
																				301,
																				302,
																			]
																			type: "integer"
																		}
																	}
																	type: "object"
																}
																responseHeaderModifier: {
																	description: """
		ResponseHeaderModifier defines a schema for a filter that modifies response headers. 
		 Support: Extended
		"""

																	properties: {
																		add: {
																			description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: add: - name: \"my-header\" value: \"bar,baz\" 
		 Output: GET /foo HTTP/1.1 my-header: foo,bar,baz
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																		remove: {
																			description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input: GET /foo HTTP/1.1 my-header1: foo my-header2: bar my-header3: baz 
		 Config: remove: [\"my-header1\", \"my-header3\"] 
		 Output: GET /foo HTTP/1.1 my-header2: bar
		"""

																			items: type: "string"
																			maxItems: 16
																			type:     "array"
																		}
																		set: {
																			description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input: GET /foo HTTP/1.1 my-header: foo 
		 Config: set: - name: \"my-header\" value: \"bar\" 
		 Output: GET /foo HTTP/1.1 my-header: bar
		"""

																			items: {
																				description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																				properties: {
																					name: {
																						description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																						maxLength: 256
																						minLength: 1
																						pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																						type:      "string"
																					}
																					value: {
																						description: "Value is the value of HTTP Header to be matched."

																						maxLength: 4096
																						minLength: 1
																						type:      "string"
																					}
																				}
																				required: [
																					"name",
																					"value",
																				]
																				type: "object"
																			}
																			maxItems: 16
																			type:     "array"
																			"x-kubernetes-list-map-keys": ["name"]
																			"x-kubernetes-list-type": "map"
																		}
																	}
																	type: "object"
																}
																type: {
																	description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\". All implementations must support core filters. 
		 - Extended: Filter types and their corresponding configuration defined by \"Support: Extended\" in this package, e.g. \"RequestMirror\". Implementers are encouraged to support extended filters. 
		 - Implementation-specific: Filters that are defined and supported by specific vendors. In the future, filters showing convergence in behavior across multiple implementations will be considered for inclusion in extended or core conformance levels. Filter-specific configuration for such filters is specified using the ExtensionRef field. `Type` should be set to \"ExtensionRef\" for custom filters. 
		 Implementers are encouraged to define custom implementation types to extend the core API with implementation-specific behavior. 
		 If a reference to a custom filter type cannot be resolved, the filter MUST NOT be skipped. Instead, requests that would have been processed by that filter MUST receive a HTTP error response. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																	enum: [
																		"RequestHeaderModifier",
																		"ResponseHeaderModifier",
																		"RequestRedirect",
																	]
																	type: "string"
																}
															}
															required: ["type"]
															type: "object"
														}
														maxItems: 16
														type:     "array"
													}
													group: {
														default:     ""
														description: "Group is the group of the referent. For example, \"gateway.networking.k8s.io\". When unspecified or empty string, core API group is inferred."

														maxLength: 253
														pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
														type:      "string"
													}
													kind: {
														default:     "Service"
														description: "Kind is kind of the referent. For example \"HTTPRoute\" or \"Service\". Defaults to \"Service\" when not specified."

														maxLength: 63
														minLength: 1
														pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
														type:      "string"
													}
													name: {
														description: "Name is the name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: """
		Namespace is the namespace of the backend. When unspecified, the local namespace is inferred. 
		 Note that when a namespace is specified, a ReferenceGrant object is required in the referent namespace to allow that namespace's owner to accept the reference. See the ReferenceGrant documentation for details. 
		 Support: Core
		"""

														maxLength: 63
														minLength: 1
														pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:      "string"
													}
													port: {
														description: "Port specifies the destination port number to use for this resource. Port is required when the referent is a Kubernetes Service. In this case, the port number is the service port number, not the target port. For other resources, destination port might be derived from the referent resource or this field."

														format:  "int32"
														maximum: 65535
														minimum: 1
														type:    "integer"
													}
													weight: {
														default: 1
														description: """
		Weight specifies the proportion of requests forwarded to the referenced backend. This is computed as weight/(sum of all weights in this BackendRefs list). For non-zero values, there may be some epsilon from the exact proportion defined here depending on the precision an implementation supports. Weight is not a percentage and the sum of weights does not need to equal 100. 
		 If only one backend is specified and it has a weight greater than 0, 100% of the traffic is forwarded to that backend. If weight is set to 0, no traffic should be forwarded for this entry. If unspecified, weight defaults to 1. 
		 Support for this field varies based on the context where used.
		"""

														format:  "int32"
														maximum: 1000000
														minimum: 0
														type:    "integer"
													}
												}
												required: ["name"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										filters: {
											description: """
		Filters define the filters that are applied to requests that match this rule. 
		 The effects of ordering of multiple behaviors are currently unspecified. This can change in the future based on feedback during the alpha stage. 
		 Conformance-levels at this level are defined based on the type of filter: 
		 - ALL core filters MUST be supported by all implementations. - Implementers are encouraged to support extended filters. - Implementation-specific custom filters have no API guarantees across   implementations. 
		 Specifying a core filter multiple times has unspecified or custom conformance. 
		 All filters are expected to be compatible with each other except for the URLRewrite and RequestRedirect filters, which may not be combined. If an implementation can not support other combinations of filters, they must clearly document that limitation. In all cases where incompatible or unsupported filters are specified, implementations MUST add a warning condition to status. 
		 Support: Core
		"""

											items: {
												description: "HTTPRouteFilter defines processing steps that must be completed during the request or response lifecycle. HTTPRouteFilters are meant as an extension point to express processing that may be done in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping. API guarantee/conformance is defined based on the type of the filter."

												properties: {
													requestHeaderModifier: {
														description: """
		RequestHeaderModifier defines a schema for a filter that modifies request headers. 
		 Support: Core
		"""

														properties: {
															add: {
																description: """
		Add adds the given header(s) (name, value) to the request before the action. It appends to any existing values associated with the header name. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   add:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: foo   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
															remove: {
																description: """
		Remove the given header(s) from the HTTP request before the action. The value of Remove is a list of HTTP header names. Note that the header names are case-insensitive (see https://datatracker.ietf.org/doc/html/rfc2616#section-4.2). 
		 Input:   GET /foo HTTP/1.1   my-header1: foo   my-header2: bar   my-header3: baz 
		 Config:   remove: [\"my-header1\", \"my-header3\"] 
		 Output:   GET /foo HTTP/1.1   my-header2: bar
		"""

																items: type: "string"
																maxItems: 16
																type:     "array"
															}
															set: {
																description: """
		Set overwrites the request with the given header (name, value) before the action. 
		 Input:   GET /foo HTTP/1.1   my-header: foo 
		 Config:   set:   - name: \"my-header\"     value: \"bar\" 
		 Output:   GET /foo HTTP/1.1   my-header: bar
		"""

																items: {
																	description: "HTTPHeader represents an HTTP Header name and value as defined by RFC 7230."

																	properties: {
																		name: {
																			description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent.
		"""

																			maxLength: 256
																			minLength: 1
																			pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																			type:      "string"
																		}
																		value: {
																			description: "Value is the value of HTTP Header to be matched."

																			maxLength: 4096
																			minLength: 1
																			type:      "string"
																		}
																	}
																	required: [
																		"name",
																		"value",
																	]
																	type: "object"
																}
																maxItems: 16
																type:     "array"
																"x-kubernetes-list-map-keys": ["name"]
																"x-kubernetes-list-type": "map"
															}
														}
														type: "object"
													}
													requestRedirect: {
														description: """
		RequestRedirect defines a schema for a filter that responds to the request with an HTTP redirection. 
		 Support: Core
		"""

														properties: {
															hostname: {
																description: """
		Hostname is the hostname to be used in the value of the `Location` header in the response. When empty, the hostname of the request is used. 
		 Support: Core
		"""

																maxLength: 253
																minLength: 1
																pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
																type:      "string"
															}
															path: {
																description: """
		Path defines parameters used to modify the path of the incoming request. The modified path is then used to construct the `Location` header. When empty, the request path is used as-is. 
		 Support: Extended
		"""

																properties: {
																	replaceFullPath: {
																		description: "ReplaceFullPath specifies the value with which to replace the full path of a request during a rewrite or redirect."

																		maxLength: 1024
																		type:      "string"
																	}
																	replacePrefixMatch: {
																		description: """
		ReplacePrefixMatch specifies the value with which to replace the prefix match of a request during a rewrite or redirect. For example, a request to \"/foo/bar\" with a prefix match of \"/foo\" and a ReplacePrefixMatch of \"/xyz\" would be modified to \"/xyz/bar\". 
		 Note that this matches the behavior of the PathPrefix match type. This matches full path elements. A path element refers to the list of labels in the path split by the `/` separator. When specified, a trailing `/` is ignored. For example, the paths `/abc`, `/abc/`, and `/abc/def` would all match the prefix `/abc`, but the path `/abcd` would not. 
		 Request Path | Prefix Match | Replace Prefix | Modified Path -------------|--------------|----------------|---------- /foo/bar     | /foo         | /xyz           | /xyz/bar /foo/bar     | /foo         | /xyz/          | /xyz/bar /foo/bar     | /foo/        | /xyz           | /xyz/bar /foo/bar     | /foo/        | /xyz/          | /xyz/bar /foo         | /foo         | /xyz           | /xyz /foo/        | /foo         | /xyz           | /xyz/ /foo/bar     | /foo         | <empty string> | /bar /foo/        | /foo         | <empty string> | / /foo         | /foo         | <empty string> | / /foo/        | /foo         | /              | / /foo         | /foo         | /              | /
		"""

																		maxLength: 1024
																		type:      "string"
																	}
																	type: {
																		description: """
		Type defines the type of path modifier. Additional types may be added in a future release of the API. 
		 Note that values may be added to this enum, implementations must ensure that unknown values will not cause a crash. 
		 Unknown values here must result in the implementation setting the Accepted Condition for the Route to `status: False`, with a Reason of `UnsupportedValue`.
		"""

																		enum: [
																			"ReplaceFullPath",
																			"ReplacePrefixMatch",
																		]
																		type: "string"
																	}
																}
																required: ["type"]
																type: "object"
															}
															port: {
																description: """
		Port is the port to be used in the value of the `Location` header in the response. When empty, port (if specified) of the request is used. 
		 Support: Extended
		"""

																format:  "int32"
																maximum: 65535
																minimum: 1
																type:    "integer"
															}
															scheme: {
																description: """
		Scheme is the scheme to be used in the value of the `Location` header in the response. When empty, the scheme of the request is used. 
		 Support: Extended
		"""

																enum: [
																	"http",
																	"https",
																]
																type: "string"
															}
															statusCode: {
																default: 302
																description: """
		StatusCode is the HTTP status code to be used in response. 
		 Support: Core
		"""

																enum: [
																	301,
																	302,
																]
																type: "integer"
															}
														}
														type: "object"
													}
													type: {
														description: """
		Type identifies the type of filter to apply. As with other API fields, types are classified into three conformance levels: 
		 - Core: Filter types and their corresponding configuration defined by   \"Support: Core\" in this package, e.g. \"RequestHeaderModifier\".
		"""

														enum: [
															"RequestHeaderModifier",
															"RequestRedirect",
														]
														type: "string"
													}
												}
												required: ["type"]
												type: "object"
											}
											maxItems: 16
											type:     "array"
										}
										matches: {
											default: [{
												path: {
													type:  "PathPrefix"
													value: "/"
												}
											}]
											description: """
		Matches define conditions used for matching the rule against incoming HTTP requests. Each match is independent, i.e. this rule will be matched if **any** one of the matches is satisfied. 
		 For example, take the following matches configuration: 
		 ``` matches: - path:     value: \"/foo\"   headers:   - name: \"version\"     value: \"v2\" - path:     value: \"/v2/foo\" ``` 
		 For a request to match against this rule, a request must satisfy EITHER of the two conditions: 
		 - path prefixed with `/foo` AND contains the header `version: v2` - path prefix of `/v2/foo` 
		 See the documentation for HTTPRouteMatch on how to specify multiple match conditions that should be ANDed together. 
		 If no matches are specified, the default is a prefix path match on \"/\", which has the effect of matching every HTTP request. 
		 Proxy or Load Balancer routing configuration generated from HTTPRoutes MUST prioritize rules based on the following criteria, continuing on ties. Precedence must be given to the the Rule with the largest number of: 
		 * Characters in a matching non-wildcard hostname. * Characters in a matching hostname. * Characters in a matching path. * Header matches. * Query param matches. 
		 If ties still exist across multiple Routes, matching precedence MUST be determined in order of the following criteria, continuing on ties: 
		 * The oldest Route based on creation timestamp. * The Route appearing first in alphabetical order by   \"{namespace}/{name}\". 
		 If ties still exist within the Route that has been given precedence, matching precedence MUST be granted to the first matching rule meeting the above criteria. 
		 When no rules matching a request have been successfully attached to the parent a request is coming from, a HTTP 404 status code MUST be returned.
		"""

											items: {
												description: """
		HTTPRouteMatch defines the predicate used to match requests to a given action. Multiple match types are ANDed together, i.e. the match will evaluate to true only if all conditions are satisfied. 
		 For example, the match below will match a HTTP request only if its path starts with `/foo` AND it contains the `version: v1` header: 
		 ``` match:   path:     value: \"/foo\"   headers:   - name: \"version\"     value \"v1\" ```
		"""

												properties: {
													headers: {
														description: "Headers specifies HTTP request header matchers. Multiple match values are ANDed together, meaning, a request must match all the specified headers to select the route."

														items: {
															description: "HTTPHeaderMatch describes how to select a HTTP route by matching HTTP request headers."

															properties: {
																name: {
																	description: """
		Name is the name of the HTTP Header to be matched. Name matching MUST be case insensitive. (See https://tools.ietf.org/html/rfc7230#section-3.2). 
		 If multiple entries specify equivalent header names, only the first entry with an equivalent name MUST be considered for a match. Subsequent entries with an equivalent header name MUST be ignored. Due to the case-insensitivity of header names, \"foo\" and \"Foo\" are considered equivalent. 
		 When a header is repeated in an HTTP request, it is implementation-specific behavior as to how this is represented. Generally, proxies should follow the guidance from the RFC: https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2.2 regarding processing a repeated header, with special handling for \"Set-Cookie\".
		"""

																	maxLength: 256
																	minLength: 1
																	pattern:   "^[A-Za-z0-9!#$%&'*+\\-.^_\\x60|~]+$"
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the header. 
		 Support: Core (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression HeaderMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP Header to be matched."

																	maxLength: 4096
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
													method: {
														description: """
		Method specifies HTTP method matcher. When specified, this route will be matched only if the request has the specified method. 
		 Support: Extended
		"""

														enum: [
															"GET",
															"HEAD",
															"POST",
															"PUT",
															"DELETE",
															"CONNECT",
															"OPTIONS",
															"TRACE",
															"PATCH",
														]
														type: "string"
													}
													path: {
														default: {
															type:  "PathPrefix"
															value: "/"
														}
														description: "Path specifies a HTTP request path matcher. If this field is not specified, a default prefix match on the \"/\" path is provided."

														properties: {
															type: {
																default: "PathPrefix"
																description: """
		Type specifies how to match against the path Value. 
		 Support: Core (Exact, PathPrefix) 
		 Support: Custom (RegularExpression)
		"""

																enum: [
																	"Exact",
																	"PathPrefix",
																	"RegularExpression",
																]
																type: "string"
															}
															value: {
																default:     "/"
																description: "Value of the HTTP path to match against."
																maxLength:   1024
																type:        "string"
															}
														}
														type: "object"
													}
													queryParams: {
														description: "QueryParams specifies HTTP query parameter matchers. Multiple match values are ANDed together, meaning, a request must match all the specified query parameters to select the route."

														items: {
															description: "HTTPQueryParamMatch describes how to select a HTTP route by matching HTTP query parameters."

															properties: {
																name: {
																	description: "Name is the name of the HTTP query param to be matched. This must be an exact string match. (See https://tools.ietf.org/html/rfc7230#section-2.7.3)."

																	maxLength: 256
																	minLength: 1
																	type:      "string"
																}
																type: {
																	default: "Exact"
																	description: """
		Type specifies how to match against the value of the query parameter. 
		 Support: Extended (Exact) 
		 Support: Custom (RegularExpression) 
		 Since RegularExpression QueryParamMatchType has custom conformance, implementations can support POSIX, PCRE or any other dialects of regular expressions. Please read the implementation's documentation to determine the supported dialect.
		"""

																	enum: [
																		"Exact",
																		"RegularExpression",
																	]
																	type: "string"
																}
																value: {
																	description: "Value is the value of HTTP query param to be matched."

																	maxLength: 1024
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"name",
																"value",
															]
															type: "object"
														}
														maxItems: 16
														type:     "array"
														"x-kubernetes-list-map-keys": ["name"]
														"x-kubernetes-list-type": "map"
													}
												}
												type: "object"
											}
											maxItems: 8
											type:     "array"
										}
										timeouts: {
											description: """
		Timeouts defines the timeouts that can be configured for an HTTP request. 
		 Support: Core 
		 <gateway:experimental>
		"""

											properties: {
												backendRequest: {
													description: """
		BackendRequest specifies a timeout for an individual request from the gateway to a backend service. Typically used in conjunction with automatic retries, if supported by an implementation. Default is the value of Request timeout. 
		 Support: Extended
		"""

													format: "duration"
													type:   "string"
												}
												request: {
													description: """
		Request specifies a timeout for responding to client HTTP requests, disabled by default. 
		 For example, the following rule will timeout if a client request is taking longer than 10 seconds to complete: 
		 ``` rules: - timeouts: request: 10s backendRefs: ... ``` 
		 Support: Core
		"""

													format: "duration"
													type:   "string"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								maxItems: 16
								type:     "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Status defines the current state of HTTPRoute."
						properties: parents: {
							description: """
		Parents is a list of parent resources (usually Gateways) that are associated with the route, and the status of the route with respect to each parent. When this route attaches to a parent, the controller that manages the parent must add an entry to this list when the controller first sees the route and should update the entry as appropriate when the route or gateway is modified. 
		 Note that parent references that cannot be resolved by an implementation of this API will not be added to this list. Implementations of this API can only populate Route status for the Gateways/parent resources they are responsible for. 
		 A maximum of 32 Gateways will be represented in this list. An empty list means the route has not been attached to any Gateway.
		"""

							items: {
								description: "RouteParentStatus describes the status of a route with respect to an associated Parent."

								properties: {
									conditions: {
										description: """
		Conditions describes the status of the route with respect to the Gateway. Note that the route's availability is also subject to the Gateway's own status conditions and listener status. 
		 If the Route's ParentRef specifies an existing Gateway that supports Routes of this kind AND that Gateway's controller has sufficient access, then that Gateway's controller MUST set the \"Accepted\" condition on the Route, to indicate whether the route has been accepted or rejected by the Gateway, and why. 
		 A Route MUST be considered \"Accepted\" if at least one of the Route's rules is implemented by the Gateway. 
		 There are a number of cases where the \"Accepted\" condition may not be set due to lack of controller visibility, that includes when: 
		 * The Route refers to a non-existent parent. * The Route is of a type that the controller does not support. * The Route is in a namespace the the controller does not have access to.
		"""

										items: {
											description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		     // other fields }
		"""

											properties: {
												lastTransitionTime: {
													description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

													format: "date-time"
													type:   "string"
												}
												message: {
													description: "message is a human readable message indicating details about the transition. This may be an empty string."

													maxLength: 32768
													type:      "string"
												}
												observedGeneration: {
													description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

													format:  "int64"
													minimum: 0
													type:    "integer"
												}
												reason: {
													description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

													maxLength: 1024
													minLength: 1
													pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
													type:      "string"
												}
												status: {
													description: "status of the condition, one of True, False, Unknown."

													enum: [
														"True",
														"False",
														"Unknown",
													]
													type: "string"
												}
												type: {
													description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

													maxLength: 316
													pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
													type:      "string"
												}
											}
											required: [
												"lastTransitionTime",
												"message",
												"reason",
												"status",
												"type",
											]
											type: "object"
										}
										maxItems: 8
										minItems: 1
										type:     "array"
										"x-kubernetes-list-map-keys": ["type"]
										"x-kubernetes-list-type": "map"
									}
									controllerName: {
										description: """
		ControllerName is a domain/path string that indicates the name of the controller that wrote this status. This corresponds with the controllerName field on GatewayClass. 
		 Example: \"example.net/gateway-controller\". 
		 The format of this field is DOMAIN \"/\" PATH, where DOMAIN and PATH are valid Kubernetes names (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names). 
		 Controllers MUST populate this field when writing status. Controllers should ensure that entries to status populated with their ControllerName are cleaned up when they are no longer necessary.
		"""

										maxLength: 253
										minLength: 1
										pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"
										type:      "string"
									}
									parentRef: {
										description: "ParentRef corresponds with a ParentRef in the spec that this RouteParentStatus struct describes the status of."

										properties: {
											group: {
												default: "policy.linkerd.io"
												description: """
		Group is the group of the referent. 
		 Support: Core
		"""

												maxLength: 253
												pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
											kind: {
												default: "Gateway"
												description: """
		Kind is kind of the referent. 
		 Support: Core (Gateway) Support: Custom (Other Resources)
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
												type:      "string"
											}
											name: {
												description: """
		Name is the name of the referent. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												type:      "string"
											}
											namespace: {
												description: """
		Namespace is the namespace of the referent. When unspecified (or empty string), this refers to the local namespace of the Route. 
		 Support: Core
		"""

												maxLength: 63
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
												type:      "string"
											}
											sectionName: {
												description: """
		SectionName is the name of a section within the target resource. In the following resources, SectionName is interpreted as the following: 
		 * Gateway: Listener Name. When both Port (experimental) and SectionName are specified, the name and port of the selected listener must match both specified values. 
		 Implementations MAY choose to support attaching Routes to other resources. If that is the case, they MUST clearly document how SectionName is interpreted. 
		 When unspecified (empty string), this will reference the entire resource. For the purpose of status, an attachment is considered successful if at least one section in the parent resource accepts it. For example, Gateway listeners can restrict which Routes can attach to them by Route kind, namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from the referencing Route, the Route MUST be considered successfully attached. If no Gateway listeners accept attachment from this Route, the Route MUST be considered detached from the Gateway. 
		 Support: Core
		"""

												maxLength: 253
												minLength: 1
												pattern:   "^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:      "string"
											}
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"controllerName",
									"parentRef",
								]
								type: "object"
							}
							maxItems: 32
							type:     "array"
						}
						required: ["parents"]
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
	status: {
		acceptedNames: {
			kind:   ""
			plural: ""
		}
		conditions: []
		storedVersions: []
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "meshtlsauthentications.policy.linkerd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "linkerd.io/created-by": "linkerd/helm %!s(<nil>)"
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "meshtlsauthentications.policy.linkerd.io"
	}
	spec: {
		group: "policy.linkerd.io"
		names: {
			kind:   "MeshTLSAuthentication"
			plural: "meshtlsauthentications"
			shortNames: ["meshtlsauthn"]
			singular: "meshtlsauthentication"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: spec: {
					description: "MeshTLSAuthentication defines a list of authenticated client IDs to be referenced by an `AuthorizationPolicy`. If a client connection has the mutually-authenticated identity that matches ANY of the of the provided identities, the connection is considered authenticated."

					oneOf: [{
						required: ["identities"]
					}, {
						required: ["identityRefs"]
					}]
					properties: {
						identities: {
							description: """
		Authorizes clients with the provided proxy identity strings (as provided via MTLS)
		The `*` prefix can be used to match all identities in a domain. An identity string of `*` indicates that all authentication clients are authorized.
		"""

							items: {
								pattern: "^(\\*|[a-z0-9]([-a-z0-9]*[a-z0-9])?)(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
								type:    "string"
							}
							minItems: 1
							type:     "array"
						}
						identityRefs: {
							items: {
								properties: {
									group: {
										description: "Group is the group of the referent. When empty, the Kubernetes core API group is inferred.\""

										maxLength: 253
										pattern:   "^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
										type:      "string"
									}
									kind: {
										description: "Kind is the kind of the referent."
										maxLength:   63
										minLength:   1
										pattern:     "^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"
										type:        "string"
									}
									name: {
										description: "Name is the name of the referent. When unspecified, this refers to all resources of the specified Group and Kind in the specified namespace."

										maxLength: 253
										minLength: 1
										type:      "string"
									}
									namespace: {
										description: "Name is the name of the referent. When unspecified, this authentication refers to the local namespace."

										maxLength: 253
										type:      "string"
									}
								}
								required: ["kind"]
								type: "object"
							}
							minItems: 1
							type:     "array"
						}
					}
					type: "object"
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "networkauthentications.policy.linkerd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "linkerd.io/created-by": "linkerd/helm %!s(<nil>)"
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "networkauthentications.policy.linkerd.io"
	}
	spec: {
		group: "policy.linkerd.io"
		names: {
			kind:   "NetworkAuthentication"
			plural: "networkauthentications"
			shortNames: [
				"netauthn",
				"networkauthn",
			]
			singular: "networkauthentication"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: spec: {
					description: "NetworkAuthentication defines a list of authenticated client networks to be referenced by an `AuthorizationPolicy`. If a client connection originates from ANY of the of the provided networks, the connection is considered authenticated."

					properties: networks: {
						items: {
							properties: {
								cidr: {
									description: "The CIDR of the network to be authorized."
									type:        "string"
								}
								except: {
									description: "A list of IP networks/addresses not to be included in the above `cidr`."

									items: type: "string"
									type: "array"
								}
							}
							required: ["cidr"]
							type: "object"
						}
						type: "array"
					}
					required: ["networks"]
					type: "object"
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "serverauthorizations.policy.linkerd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "linkerd.io/created-by": "linkerd/helm %!s(<nil>)"
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "serverauthorizations.policy.linkerd.io"
	}
	spec: {
		group: "policy.linkerd.io"
		names: {
			kind:   "ServerAuthorization"
			plural: "serverauthorizations"
			shortNames: [
				"saz",
				"serverauthz",
				"srvauthz",
			]
			singular: "serverauthorization"
		}
		scope: "Namespaced"
		versions: [{
			deprecated:         true
			deprecationWarning: "policy.linkerd.io/v1alpha1 ServerAuthorization is deprecated; use policy.linkerd.io/v1beta1 ServerAuthorization"

			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: spec: {
					description: "Authorizes clients to communicate with Linkerd-proxied servers."
					properties: {
						client: {
							description: "Describes clients authorized to access a server."
							properties: {
								meshTLS: {
									properties: {
										identities: {
											description: """
		Authorizes clients with the provided proxy identity strings (as provided via MTLS)
		The `*` prefix can be used to match all identities in a domain. An identity string of `*` indicates that all authentication clients are authorized.
		"""

											items: {
												pattern: "^(\\*|[a-z0-9]([-a-z0-9]*[a-z0-9])?)(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:    "string"
											}
											type: "array"
										}
										serviceAccounts: {
											description: "Authorizes clients with the provided proxy identity service accounts (as provided via MTLS)"

											items: {
												properties: {
													name: {
														description: "The ServiceAccount's name."
														pattern:     "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:        "string"
													}
													namespace: {
														description: "The ServiceAccount's namespace. If unset, the authorization's namespace is used."

														pattern: "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:    "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										unauthenticatedTLS: {
											description: """
		Indicates that no client identity is required for communication.
		This is mostly important for the identity controller, which must terminate TLS connections from clients that do not yet have a certificate.
		"""

											type: "boolean"
										}
									}
									type: "object"
								}
								networks: {
									description: "Limits the client IP addresses to which this authorization applies. If unset, the server chooses a default (typically, all IPs or the cluster's pod network)."

									items: {
										properties: {
											cidr: type: "string"
											except: {
												items: type: "string"
												type: "array"
											}
										}
										required: ["cidr"]
										type: "object"
									}
									type: "array"
								}
								unauthenticated: {
									description: "Authorizes unauthenticated clients to access a server."
									type:        "boolean"
								}
							}
							type: "object"
						}
						server: {
							description: """
		Identifies servers in the same namespace for which this authorization applies.
		Only one of `name` or `selector` may be specified.
		"""

							oneOf: [{
								required: ["name"]
							}, {
								required: ["selector"]
							}]
							properties: {
								name: {
									description: "References a `Server` instance by name"
									pattern:     "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
									type:        "string"
								}
								selector: {
									description: "A label query over servers on which this authorization applies."

									properties: {
										matchExpressions: {
											items: {
												properties: {
													key: type: "string"
													operator: {
														enum: [
															"In",
															"NotIn",
															"Exists",
															"DoesNotExist",
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
							}
							type: "object"
						}
					}
					required: [
						"server",
						"client",
					]
					type: "object"
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
		}, {
			additionalPrinterColumns: [{
				description: "The server that this grants access to"
				jsonPath:    ".spec.server.name"
				name:        "Server"
				type:        "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				properties: spec: {
					description: "Authorizes clients to communicate with Linkerd-proxied servers."
					properties: {
						client: {
							description: "Describes clients authorized to access a server."
							properties: {
								meshTLS: {
									properties: {
										identities: {
											description: """
		Authorizes clients with the provided proxy identity strings (as provided via MTLS)
		The `*` prefix can be used to match all identities in a domain. An identity string of `*` indicates that all authentication clients are authorized.
		"""

											items: {
												pattern: "^(\\*|[a-z0-9]([-a-z0-9]*[a-z0-9])?)(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
												type:    "string"
											}
											type: "array"
										}
										serviceAccounts: {
											description: "Authorizes clients with the provided proxy identity service accounts (as provided via MTLS)"

											items: {
												properties: {
													name: {
														description: "The ServiceAccount's name."
														pattern:     "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:        "string"
													}
													namespace: {
														description: "The ServiceAccount's namespace. If unset, the authorization's namespace is used."

														pattern: "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
														type:    "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										unauthenticatedTLS: {
											description: """
		Indicates that no client identity is required for communication.
		This is mostly important for the identity controller, which must terminate TLS connections from clients that do not yet have a certificate.
		"""

											type: "boolean"
										}
									}
									type: "object"
								}
								networks: {
									description: "Limits the client IP addresses to which this authorization applies. If unset, the server chooses a default (typically, all IPs or the cluster's pod network)."

									items: {
										properties: {
											cidr: type: "string"
											except: {
												items: type: "string"
												type: "array"
											}
										}
										required: ["cidr"]
										type: "object"
									}
									type: "array"
								}
								unauthenticated: {
									description: "Authorizes unauthenticated clients to access a server."
									type:        "boolean"
								}
							}
							type: "object"
						}
						server: {
							description: """
		Identifies servers in the same namespace for which this authorization applies.
		Only one of `name` or `selector` may be specified.
		"""

							oneOf: [{
								required: ["name"]
							}, {
								required: ["selector"]
							}]
							properties: {
								name: {
									description: "References a `Server` instance by name"
									pattern:     "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
									type:        "string"
								}
								selector: {
									description: "A label query over servers on which this authorization applies."

									properties: {
										matchExpressions: {
											items: {
												properties: {
													key: type: "string"
													operator: {
														enum: [
															"In",
															"NotIn",
															"Exists",
															"DoesNotExist",
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
							}
							type: "object"
						}
					}
					required: [
						"server",
						"client",
					]
					type: "object"
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "servers.policy.linkerd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "linkerd.io/created-by": "linkerd/helm %!s(<nil>)"
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "servers.policy.linkerd.io"
	}
	spec: {
		group: "policy.linkerd.io"
		names: {
			kind:   "Server"
			plural: "servers"
			shortNames: ["srv"]
			singular: "server"
		}
		scope: "Namespaced"
		versions: [{
			deprecated:         true
			deprecationWarning: "policy.linkerd.io/v1alpha1 Server is deprecated; use policy.linkerd.io/v1beta1 Server"

			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: spec: {
					properties: {
						podSelector: {
							description: "Selects pods in the same namespace."
							oneOf: [{
								required: ["matchExpressions"]
							}, {
								required: ["matchLabels"]
							}]
							properties: {
								matchExpressions: {
									items: {
										properties: {
											key: type: "string"
											operator: {
												enum: [
													"In",
													"NotIn",
													"Exists",
													"DoesNotExist",
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
						port: {
							description:                  "A port name or number. Must exist in a pod spec."
							"x-kubernetes-int-or-string": true
						}
						proxyProtocol: {
							default: "unknown"
							description: """
		Configures protocol discovery for inbound connections.
		Supersedes the `config.linkerd.io/opaque-ports` annotation.
		"""

							type: "string"
						}
					}
					required: [
						"podSelector",
						"port",
					]
					type: "object"
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: false
		}, {
			additionalPrinterColumns: [{
				description: "The port the server is listening on"
				jsonPath:    ".spec.port"
				name:        "Port"
				type:        "string"
			}, {
				description: "The protocol of the server"
				jsonPath:    ".spec.proxyProtocol"
				name:        "Protocol"
				type:        "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				properties: spec: {
					properties: {
						podSelector: {
							description: """
		Selects pods in the same namespace.
		The result of matchLabels and matchExpressions are ANDed. Selects all if empty.
		"""

							properties: {
								matchExpressions: {
									items: {
										properties: {
											key: type: "string"
											operator: {
												enum: [
													"In",
													"NotIn",
													"Exists",
													"DoesNotExist",
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
						port: {
							description:                  "A port name or number. Must exist in a pod spec."
							"x-kubernetes-int-or-string": true
						}
						proxyProtocol: {
							default: "unknown"
							description: """
		Configures protocol discovery for inbound connections.
		Supersedes the `config.linkerd.io/opaque-ports` annotation.
		"""

							type: "string"
						}
					}
					required: [
						"podSelector",
						"port",
					]
					type: "object"
				}
				required: ["spec"]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}
res: customresourcedefinition: "coder-amanibhavam-class-cluster-l5d-crds": cluster: "serviceprofiles.linkerd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "linkerd.io/created-by": "linkerd/helm %!s(<nil>)"
		labels: {
			"helm.sh/chart":               "linkerd-crds-1.8.0"
			"linkerd.io/control-plane-ns": "linkerd"
		}
		name: "serviceprofiles.linkerd.io"
	}
	spec: {
		group: "linkerd.io"
		names: {
			kind:   "ServiceProfile"
			plural: "serviceprofiles"
			shortNames: ["sp"]
			singular: "serviceprofile"
		}
		preserveUnknownFields: false
		scope:                 "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				properties: spec: {
					description: "Spec is the custom resource spec"
					properties: {
						dstOverrides: {
							items: {
								description: "WeightedDst is a weighted alternate destination."
								properties: {
									authority: type: "string"
									weight: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
								}
								type: "object"
							}
							required: [
								"authority",
								"weight",
							]
							type: "array"
						}
						opaquePorts: {
							items: type: "string"
							type: "array"
						}
						retryBudget: {
							description: "RetryBudget describes the maximum number of retries that should be issued to this service."

							properties: {
								minRetriesPerSecond: {
									format: "int32"
									type:   "integer"
								}
								retryRatio: {
									format: "float"
									type:   "number"
								}
								ttl: type: "string"
							}
							required: [
								"minRetriesPerSecond",
								"retryRatio",
								"ttl",
							]
							type: "object"
						}
						routes: {
							items: {
								description: "RouteSpec specifies a Route resource."
								properties: {
									condition: {
										description: "RequestMatch describes the conditions under which to match a Route."

										properties: {
											all: {
												items: {
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												type: "array"
											}
											any: {
												items: {
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												type: "array"
											}
											method: type: "string"
											not: {
												items: {
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												type: "array"
											}
											pathRegex: type: "string"
										}
										type: "object"
									}
									isRetryable: type: "boolean"
									name: type: "string"
									responseClasses: {
										items: {
											description: "ResponseClass describes how to classify a response (e.g. success or failures)."

											properties: {
												condition: {
													description: "ResponseMatch describes the conditions under which to classify a response."

													properties: {
														all: {
															items: {
																type:                                   "object"
																"x-kubernetes-preserve-unknown-fields": true
															}
															type: "array"
														}
														any: {
															items: {
																type:                                   "object"
																"x-kubernetes-preserve-unknown-fields": true
															}
															type: "array"
														}
														not: {
															items: {
																type:                                   "object"
																"x-kubernetes-preserve-unknown-fields": true
															}
															type: "array"
														}
														status: {
															description: "Range describes a range of integers (e.g. status codes)."

															properties: {
																max: {
																	format: "int32"
																	type:   "integer"
																}
																min: {
																	format: "int32"
																	type:   "integer"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												isFailure: type: "boolean"
											}
											required: ["condition"]
											type: "object"
										}
										type: "array"
									}
									timeout: type: "string"
								}
								required: [
									"condition",
									"name",
								]
								type: "object"
							}
							type: "array"
						}
					}
					required: ["routes"]
					type: "object"
				}
				type: "object"
			}
			served:  true
			storage: false
		}, {
			name: "v1alpha2"
			schema: openAPIV3Schema: {
				properties: spec: {
					description: "Spec is the custom resource spec"
					properties: {
						dstOverrides: {
							items: {
								description: "WeightedDst is a weighted alternate destination."
								properties: {
									authority: type: "string"
									weight: {
										anyOf: [{
											type: "integer"
										}, {
											type: "string"
										}]
										pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
										"x-kubernetes-int-or-string": true
									}
								}
								type: "object"
							}
							required: [
								"authority",
								"weight",
							]
							type: "array"
						}
						opaquePorts: {
							items: type: "string"
							type: "array"
						}
						retryBudget: {
							description: "RetryBudget describes the maximum number of retries that should be issued to this service."

							properties: {
								minRetriesPerSecond: {
									format: "int32"
									type:   "integer"
								}
								retryRatio: {
									format: "float"
									type:   "number"
								}
								ttl: type: "string"
							}
							required: [
								"minRetriesPerSecond",
								"retryRatio",
								"ttl",
							]
							type: "object"
						}
						routes: {
							items: {
								description: "RouteSpec specifies a Route resource."
								properties: {
									condition: {
										description: "RequestMatch describes the conditions under which to match a Route."

										properties: {
											all: {
												items: {
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												type: "array"
											}
											any: {
												items: {
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												type: "array"
											}
											method: type: "string"
											not: {
												items: {
													type:                                   "object"
													"x-kubernetes-preserve-unknown-fields": true
												}
												type: "array"
											}
											pathRegex: type: "string"
										}
										type: "object"
									}
									isRetryable: type: "boolean"
									name: type: "string"
									responseClasses: {
										items: {
											description: "ResponseClass describes how to classify a response (e.g. success or failures)."

											properties: {
												condition: {
													description: "ResponseMatch describes the conditions under which to classify a response."

													properties: {
														all: {
															items: {
																type:                                   "object"
																"x-kubernetes-preserve-unknown-fields": true
															}
															type: "array"
														}
														any: {
															items: {
																type:                                   "object"
																"x-kubernetes-preserve-unknown-fields": true
															}
															type: "array"
														}
														not: {
															items: {
																type:                                   "object"
																"x-kubernetes-preserve-unknown-fields": true
															}
															type: "array"
														}
														status: {
															description: "Range describes a range of integers (e.g. status codes)."

															properties: {
																max: {
																	format: "int32"
																	type:   "integer"
																}
																min: {
																	format: "int32"
																	type:   "integer"
																}
															}
															type: "object"
														}
													}
													type: "object"
												}
												isFailure: type: "boolean"
											}
											required: ["condition"]
											type: "object"
										}
										type: "array"
									}
									timeout: type: "string"
								}
								required: [
									"condition",
									"name",
								]
								type: "object"
							}
							type: "array"
						}
					}
					type: "object"
				}
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
}