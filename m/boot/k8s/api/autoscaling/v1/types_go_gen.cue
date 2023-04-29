// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/api/autoscaling/v1

package v1

import (
	metav1 "github.com/defn/m/boot/k8s/apimachinery/pkg/apis/meta/v1"
	"github.com/defn/m/boot/k8s/apimachinery/pkg/api/resource"
	"github.com/defn/m/boot/k8s/api/core/v1"
)

// CrossVersionObjectReference contains enough information to let you identify the referred resource.
// +structType=atomic
#CrossVersionObjectReference: {
	// kind is the kind of the referent; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind: string @go(Kind) @protobuf(1,bytes,opt)

	// name is the name of the referent; More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
	name: string @go(Name) @protobuf(2,bytes,opt)

	// apiVersion is the API version of the referent
	// +optional
	apiVersion?: string @go(APIVersion) @protobuf(3,bytes,opt)
}

// specification of a horizontal pod autoscaler.
#HorizontalPodAutoscalerSpec: {
	// reference to scaled resource; horizontal pod autoscaler will learn the current resource consumption
	// and will set the desired number of pods by using its Scale subresource.
	scaleTargetRef: #CrossVersionObjectReference @go(ScaleTargetRef) @protobuf(1,bytes,opt)

	// minReplicas is the lower limit for the number of replicas to which the autoscaler
	// can scale down.  It defaults to 1 pod.  minReplicas is allowed to be 0 if the
	// alpha feature gate HPAScaleToZero is enabled and at least one Object or External
	// metric is configured.  Scaling is active as long as at least one metric value is
	// available.
	// +optional
	minReplicas?: null | int32 @go(MinReplicas,*int32) @protobuf(2,varint,opt)

	// maxReplicas is the upper limit for the number of pods that can be set by the autoscaler; cannot be smaller than MinReplicas.
	maxReplicas: int32 @go(MaxReplicas) @protobuf(3,varint,opt)

	// targetCPUUtilizationPercentage is the target average CPU utilization (represented as a percentage of requested CPU) over all the pods;
	// if not specified the default autoscaling policy will be used.
	// +optional
	targetCPUUtilizationPercentage?: null | int32 @go(TargetCPUUtilizationPercentage,*int32) @protobuf(4,varint,opt)
}

// current status of a horizontal pod autoscaler
#HorizontalPodAutoscalerStatus: {
	// observedGeneration is the most recent generation observed by this autoscaler.
	// +optional
	observedGeneration?: null | int64 @go(ObservedGeneration,*int64) @protobuf(1,varint,opt)

	// lastScaleTime is the last time the HorizontalPodAutoscaler scaled the number of pods;
	// used by the autoscaler to control how often the number of pods is changed.
	// +optional
	lastScaleTime?: null | metav1.#Time @go(LastScaleTime,*metav1.Time) @protobuf(2,bytes,opt)

	// currentReplicas is the current number of replicas of pods managed by this autoscaler.
	currentReplicas: int32 @go(CurrentReplicas) @protobuf(3,varint,opt)

	// desiredReplicas is the  desired number of replicas of pods managed by this autoscaler.
	desiredReplicas: int32 @go(DesiredReplicas) @protobuf(4,varint,opt)

	// currentCPUUtilizationPercentage is the current average CPU utilization over all pods, represented as a percentage of requested CPU,
	// e.g. 70 means that an average pod is using now 70% of its requested CPU.
	// +optional
	currentCPUUtilizationPercentage?: null | int32 @go(CurrentCPUUtilizationPercentage,*int32) @protobuf(5,varint,opt)
}

// configuration of a horizontal pod autoscaler.
#HorizontalPodAutoscaler: {
	metav1.#TypeMeta

	// Standard object metadata. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// spec defines the behaviour of autoscaler. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
	// +optional
	spec?: #HorizontalPodAutoscalerSpec @go(Spec) @protobuf(2,bytes,opt)

	// status is the current information about the autoscaler.
	// +optional
	status?: #HorizontalPodAutoscalerStatus @go(Status) @protobuf(3,bytes,opt)
}

// list of horizontal pod autoscaler objects.
#HorizontalPodAutoscalerList: {
	metav1.#TypeMeta

	// Standard list metadata.
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of horizontal pod autoscaler objects.
	items: [...#HorizontalPodAutoscaler] @go(Items,[]HorizontalPodAutoscaler) @protobuf(2,bytes,rep)
}

// Scale represents a scaling request for a resource.
#Scale: {
	metav1.#TypeMeta

	// Standard object metadata; More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata.
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// spec defines the behavior of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status.
	// +optional
	spec?: #ScaleSpec @go(Spec) @protobuf(2,bytes,opt)

	// status is the current status of the scale. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status. Read-only.
	// +optional
	status?: #ScaleStatus @go(Status) @protobuf(3,bytes,opt)
}

// ScaleSpec describes the attributes of a scale subresource.
#ScaleSpec: {
	// replicas is the desired number of instances for the scaled object.
	// +optional
	replicas?: int32 @go(Replicas) @protobuf(1,varint,opt)
}

// ScaleStatus represents the current status of a scale subresource.
#ScaleStatus: {
	// replicas is the actual number of observed instances of the scaled object.
	replicas: int32 @go(Replicas) @protobuf(1,varint,opt)

	// selector is the label query over pods that should match the replicas count. This is same
	// as the label selector but in the string format to avoid introspection
	// by clients. The string will be in the same format as the query-param syntax.
	// More info about label selectors: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
	// +optional
	selector?: string @go(Selector) @protobuf(2,bytes,opt)
}

// MetricSourceType indicates the type of metric.
// +enum
#MetricSourceType: string // #enumMetricSourceType

#enumMetricSourceType:
	#ObjectMetricSourceType |
	#PodsMetricSourceType |
	#ResourceMetricSourceType |
	#ContainerResourceMetricSourceType |
	#ExternalMetricSourceType

// ObjectMetricSourceType is a metric describing a kubernetes object
// (for example, hits-per-second on an Ingress object).
#ObjectMetricSourceType: #MetricSourceType & "Object"

// PodsMetricSourceType is a metric describing each pod in the current scale
// target (for example, transactions-processed-per-second).  The values
// will be averaged together before being compared to the target value.
#PodsMetricSourceType: #MetricSourceType & "Pods"

// ResourceMetricSourceType is a resource metric known to Kubernetes, as
// specified in requests and limits, describing each pod in the current
// scale target (e.g. CPU or memory).  Such metrics are built in to
// Kubernetes, and have special scaling options on top of those available
// to normal per-pod metrics (the "pods" source).
#ResourceMetricSourceType: #MetricSourceType & "Resource"

// ContainerResourceMetricSourceType is a resource metric known to Kubernetes, as
// specified in requests and limits, describing a single container in each pod in the current
// scale target (e.g. CPU or memory).  Such metrics are built in to
// Kubernetes, and have special scaling options on top of those available
// to normal per-pod metrics (the "pods" source).
#ContainerResourceMetricSourceType: #MetricSourceType & "ContainerResource"

// ExternalMetricSourceType is a global metric that is not associated
// with any Kubernetes object. It allows autoscaling based on information
// coming from components running outside of cluster
// (for example length of queue in cloud messaging service, or
// QPS from loadbalancer running outside of cluster).
#ExternalMetricSourceType: #MetricSourceType & "External"

// MetricSpec specifies how to scale based on a single metric
// (only `type` and one other matching field should be set at once).
#MetricSpec: {
	// type is the type of metric source.  It should be one of "ContainerResource",
	// "External", "Object", "Pods" or "Resource", each mapping to a matching field in the object.
	// Note: "ContainerResource" type is available on when the feature-gate
	// HPAContainerMetrics is enabled
	type: #MetricSourceType @go(Type) @protobuf(1,bytes)

	// object refers to a metric describing a single kubernetes object
	// (for example, hits-per-second on an Ingress object).
	// +optional
	object?: null | #ObjectMetricSource @go(Object,*ObjectMetricSource) @protobuf(2,bytes,opt)

	// pods refers to a metric describing each pod in the current scale target
	// (for example, transactions-processed-per-second).  The values will be
	// averaged together before being compared to the target value.
	// +optional
	pods?: null | #PodsMetricSource @go(Pods,*PodsMetricSource) @protobuf(3,bytes,opt)

	// resource refers to a resource metric (such as those specified in
	// requests and limits) known to Kubernetes describing each pod in the
	// current scale target (e.g. CPU or memory). Such metrics are built in to
	// Kubernetes, and have special scaling options on top of those available
	// to normal per-pod metrics using the "pods" source.
	// +optional
	resource?: null | #ResourceMetricSource @go(Resource,*ResourceMetricSource) @protobuf(4,bytes,opt)

	// containerResource refers to a resource metric (such as those specified in
	// requests and limits) known to Kubernetes describing a single container in each pod of the
	// current scale target (e.g. CPU or memory). Such metrics are built in to
	// Kubernetes, and have special scaling options on top of those available
	// to normal per-pod metrics using the "pods" source.
	// This is an alpha feature and can be enabled by the HPAContainerMetrics feature flag.
	// +optional
	containerResource?: null | #ContainerResourceMetricSource @go(ContainerResource,*ContainerResourceMetricSource) @protobuf(7,bytes,opt)

	// external refers to a global metric that is not associated
	// with any Kubernetes object. It allows autoscaling based on information
	// coming from components running outside of cluster
	// (for example length of queue in cloud messaging service, or
	// QPS from loadbalancer running outside of cluster).
	// +optional
	external?: null | #ExternalMetricSource @go(External,*ExternalMetricSource) @protobuf(5,bytes,opt)
}

// ObjectMetricSource indicates how to scale on a metric describing a
// kubernetes object (for example, hits-per-second on an Ingress object).
#ObjectMetricSource: {
	// target is the described Kubernetes object.
	target: #CrossVersionObjectReference @go(Target) @protobuf(1,bytes)

	// metricName is the name of the metric in question.
	metricName: string @go(MetricName) @protobuf(2,bytes)

	// targetValue is the target value of the metric (as a quantity).
	targetValue: resource.#Quantity @go(TargetValue) @protobuf(3,bytes)

	// selector is the string-encoded form of a standard kubernetes label selector for the given metric.
	// When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping
	// When unset, just the metricName will be used to gather metrics.
	// +optional
	selector?: null | metav1.#LabelSelector @go(Selector,*metav1.LabelSelector) @protobuf(4,bytes)

	// averageValue is the target value of the average of the
	// metric across all relevant pods (as a quantity)
	// +optional
	averageValue?: null | resource.#Quantity @go(AverageValue,*resource.Quantity) @protobuf(5,bytes)
}

// PodsMetricSource indicates how to scale on a metric describing each pod in
// the current scale target (for example, transactions-processed-per-second).
// The values will be averaged together before being compared to the target
// value.
#PodsMetricSource: {
	// metricName is the name of the metric in question
	metricName: string @go(MetricName) @protobuf(1,bytes)

	// targetAverageValue is the target value of the average of the
	// metric across all relevant pods (as a quantity)
	targetAverageValue: resource.#Quantity @go(TargetAverageValue) @protobuf(2,bytes)

	// selector is the string-encoded form of a standard kubernetes label selector for the given metric
	// When set, it is passed as an additional parameter to the metrics server for more specific metrics scoping
	// When unset, just the metricName will be used to gather metrics.
	// +optional
	selector?: null | metav1.#LabelSelector @go(Selector,*metav1.LabelSelector) @protobuf(3,bytes)
}

// ResourceMetricSource indicates how to scale on a resource metric known to
// Kubernetes, as specified in requests and limits, describing each pod in the
// current scale target (e.g. CPU or memory).  The values will be averaged
// together before being compared to the target.  Such metrics are built in to
// Kubernetes, and have special scaling options on top of those available to
// normal per-pod metrics using the "pods" source.  Only one "target" type
// should be set.
#ResourceMetricSource: {
	// name is the name of the resource in question.
	name: v1.#ResourceName @go(Name) @protobuf(1,bytes)

	// targetAverageUtilization is the target value of the average of the
	// resource metric across all relevant pods, represented as a percentage of
	// the requested value of the resource for the pods.
	// +optional
	targetAverageUtilization?: null | int32 @go(TargetAverageUtilization,*int32) @protobuf(2,varint,opt)

	// targetAverageValue is the target value of the average of the
	// resource metric across all relevant pods, as a raw value (instead of as
	// a percentage of the request), similar to the "pods" metric source type.
	// +optional
	targetAverageValue?: null | resource.#Quantity @go(TargetAverageValue,*resource.Quantity) @protobuf(3,bytes,opt)
}

// ContainerResourceMetricSource indicates how to scale on a resource metric known to
// Kubernetes, as specified in the requests and limits, describing a single container in
// each of the pods of the current scale target(e.g. CPU or memory). The values will be
// averaged together before being compared to the target. Such metrics are built into
// Kubernetes, and have special scaling options on top of those available to
// normal per-pod metrics using the "pods" source. Only one "target" type
// should be set.
#ContainerResourceMetricSource: {
	// name is the name of the resource in question.
	name: v1.#ResourceName @go(Name) @protobuf(1,bytes)

	// targetAverageUtilization is the target value of the average of the
	// resource metric across all relevant pods, represented as a percentage of
	// the requested value of the resource for the pods.
	// +optional
	targetAverageUtilization?: null | int32 @go(TargetAverageUtilization,*int32) @protobuf(2,varint,opt)

	// targetAverageValue is the target value of the average of the
	// resource metric across all relevant pods, as a raw value (instead of as
	// a percentage of the request), similar to the "pods" metric source type.
	// +optional
	targetAverageValue?: null | resource.#Quantity @go(TargetAverageValue,*resource.Quantity) @protobuf(3,bytes,opt)

	// container is the name of the container in the pods of the scaling target.
	container: string @go(Container) @protobuf(5,bytes,opt)
}

// ExternalMetricSource indicates how to scale on a metric not associated with
// any Kubernetes object (for example length of queue in cloud
// messaging service, or QPS from loadbalancer running outside of cluster).
#ExternalMetricSource: {
	// metricName is the name of the metric in question.
	metricName: string @go(MetricName) @protobuf(1,bytes)

	// metricSelector is used to identify a specific time series
	// within a given metric.
	// +optional
	metricSelector?: null | metav1.#LabelSelector @go(MetricSelector,*metav1.LabelSelector) @protobuf(2,bytes,opt)

	// targetValue is the target value of the metric (as a quantity).
	// Mutually exclusive with TargetAverageValue.
	// +optional
	targetValue?: null | resource.#Quantity @go(TargetValue,*resource.Quantity) @protobuf(3,bytes,opt)

	// targetAverageValue is the target per-pod value of global metric (as a quantity).
	// Mutually exclusive with TargetValue.
	// +optional
	targetAverageValue?: null | resource.#Quantity @go(TargetAverageValue,*resource.Quantity) @protobuf(4,bytes,opt)
}

// MetricStatus describes the last-read state of a single metric.
#MetricStatus: {
	// type is the type of metric source.  It will be one of "ContainerResource",
	// "External", "Object", "Pods" or "Resource", each corresponds to a matching field in the object.
	// Note: "ContainerResource" type is available on when the feature-gate
	// HPAContainerMetrics is enabled
	type: #MetricSourceType @go(Type) @protobuf(1,bytes)

	// object refers to a metric describing a single kubernetes object
	// (for example, hits-per-second on an Ingress object).
	// +optional
	object?: null | #ObjectMetricStatus @go(Object,*ObjectMetricStatus) @protobuf(2,bytes,opt)

	// pods refers to a metric describing each pod in the current scale target
	// (for example, transactions-processed-per-second).  The values will be
	// averaged together before being compared to the target value.
	// +optional
	pods?: null | #PodsMetricStatus @go(Pods,*PodsMetricStatus) @protobuf(3,bytes,opt)

	// resource refers to a resource metric (such as those specified in
	// requests and limits) known to Kubernetes describing each pod in the
	// current scale target (e.g. CPU or memory). Such metrics are built in to
	// Kubernetes, and have special scaling options on top of those available
	// to normal per-pod metrics using the "pods" source.
	// +optional
	resource?: null | #ResourceMetricStatus @go(Resource,*ResourceMetricStatus) @protobuf(4,bytes,opt)

	// containerResource refers to a resource metric (such as those specified in
	// requests and limits) known to Kubernetes describing a single container in each pod in the
	// current scale target (e.g. CPU or memory). Such metrics are built in to
	// Kubernetes, and have special scaling options on top of those available
	// to normal per-pod metrics using the "pods" source.
	// +optional
	containerResource?: null | #ContainerResourceMetricStatus @go(ContainerResource,*ContainerResourceMetricStatus) @protobuf(7,bytes,opt)

	// external refers to a global metric that is not associated
	// with any Kubernetes object. It allows autoscaling based on information
	// coming from components running outside of cluster
	// (for example length of queue in cloud messaging service, or
	// QPS from loadbalancer running outside of cluster).
	// +optional
	external?: null | #ExternalMetricStatus @go(External,*ExternalMetricStatus) @protobuf(5,bytes,opt)
}

// HorizontalPodAutoscalerConditionType are the valid conditions of
// a HorizontalPodAutoscaler.
#HorizontalPodAutoscalerConditionType: string // #enumHorizontalPodAutoscalerConditionType

#enumHorizontalPodAutoscalerConditionType:
	#ScalingActive |
	#AbleToScale |
	#ScalingLimited

// ScalingActive indicates that the HPA controller is able to scale if necessary:
// it's correctly configured, can fetch the desired metrics, and isn't disabled.
#ScalingActive: #HorizontalPodAutoscalerConditionType & "ScalingActive"

// AbleToScale indicates a lack of transient issues which prevent scaling from occurring,
// such as being in a backoff window, or being unable to access/update the target scale.
#AbleToScale: #HorizontalPodAutoscalerConditionType & "AbleToScale"

// ScalingLimited indicates that the calculated scale based on metrics would be above or
// below the range for the HPA, and has thus been capped.
#ScalingLimited: #HorizontalPodAutoscalerConditionType & "ScalingLimited"

// HorizontalPodAutoscalerCondition describes the state of
// a HorizontalPodAutoscaler at a certain point.
#HorizontalPodAutoscalerCondition: {
	// type describes the current condition
	type: #HorizontalPodAutoscalerConditionType @go(Type) @protobuf(1,bytes)

	// status is the status of the condition (True, False, Unknown)
	status: v1.#ConditionStatus @go(Status) @protobuf(2,bytes)

	// lastTransitionTime is the last time the condition transitioned from
	// one status to another
	// +optional
	lastTransitionTime?: metav1.#Time @go(LastTransitionTime) @protobuf(3,bytes,opt)

	// reason is the reason for the condition's last transition.
	// +optional
	reason?: string @go(Reason) @protobuf(4,bytes,opt)

	// message is a human-readable explanation containing details about
	// the transition
	// +optional
	message?: string @go(Message) @protobuf(5,bytes,opt)
}

// ObjectMetricStatus indicates the current value of a metric describing a
// kubernetes object (for example, hits-per-second on an Ingress object).
#ObjectMetricStatus: {
	// target is the described Kubernetes object.
	target: #CrossVersionObjectReference @go(Target) @protobuf(1,bytes)

	// metricName is the name of the metric in question.
	metricName: string @go(MetricName) @protobuf(2,bytes)

	// currentValue is the current value of the metric (as a quantity).
	currentValue: resource.#Quantity @go(CurrentValue) @protobuf(3,bytes)

	// selector is the string-encoded form of a standard kubernetes label selector for the given metric
	// When set in the ObjectMetricSource, it is passed as an additional parameter to the metrics server for more specific metrics scoping.
	// When unset, just the metricName will be used to gather metrics.
	// +optional
	selector?: null | metav1.#LabelSelector @go(Selector,*metav1.LabelSelector) @protobuf(4,bytes)

	// averageValue is the current value of the average of the
	// metric across all relevant pods (as a quantity)
	// +optional
	averageValue?: null | resource.#Quantity @go(AverageValue,*resource.Quantity) @protobuf(5,bytes)
}

// PodsMetricStatus indicates the current value of a metric describing each pod in
// the current scale target (for example, transactions-processed-per-second).
#PodsMetricStatus: {
	// metricName is the name of the metric in question
	metricName: string @go(MetricName) @protobuf(1,bytes)

	// currentAverageValue is the current value of the average of the
	// metric across all relevant pods (as a quantity)
	currentAverageValue: resource.#Quantity @go(CurrentAverageValue) @protobuf(2,bytes)

	// selector is the string-encoded form of a standard kubernetes label selector for the given metric
	// When set in the PodsMetricSource, it is passed as an additional parameter to the metrics server for more specific metrics scoping.
	// When unset, just the metricName will be used to gather metrics.
	// +optional
	selector?: null | metav1.#LabelSelector @go(Selector,*metav1.LabelSelector) @protobuf(3,bytes)
}

// ResourceMetricStatus indicates the current value of a resource metric known to
// Kubernetes, as specified in requests and limits, describing each pod in the
// current scale target (e.g. CPU or memory).  Such metrics are built in to
// Kubernetes, and have special scaling options on top of those available to
// normal per-pod metrics using the "pods" source.
#ResourceMetricStatus: {
	// name is the name of the resource in question.
	name: v1.#ResourceName @go(Name) @protobuf(1,bytes)

	// currentAverageUtilization is the current value of the average of the
	// resource metric across all relevant pods, represented as a percentage of
	// the requested value of the resource for the pods.  It will only be
	// present if `targetAverageValue` was set in the corresponding metric
	// specification.
	// +optional
	currentAverageUtilization?: null | int32 @go(CurrentAverageUtilization,*int32) @protobuf(2,bytes,opt)

	// currentAverageValue is the current value of the average of the
	// resource metric across all relevant pods, as a raw value (instead of as
	// a percentage of the request), similar to the "pods" metric source type.
	// It will always be set, regardless of the corresponding metric specification.
	currentAverageValue: resource.#Quantity @go(CurrentAverageValue) @protobuf(3,bytes)
}

// ContainerResourceMetricStatus indicates the current value of a resource metric known to
// Kubernetes, as specified in requests and limits, describing a single container in each pod in the
// current scale target (e.g. CPU or memory).  Such metrics are built in to
// Kubernetes, and have special scaling options on top of those available to
// normal per-pod metrics using the "pods" source.
#ContainerResourceMetricStatus: {
	// name is the name of the resource in question.
	name: v1.#ResourceName @go(Name) @protobuf(1,bytes)

	// currentAverageUtilization is the current value of the average of the
	// resource metric across all relevant pods, represented as a percentage of
	// the requested value of the resource for the pods.  It will only be
	// present if `targetAverageValue` was set in the corresponding metric
	// specification.
	// +optional
	currentAverageUtilization?: null | int32 @go(CurrentAverageUtilization,*int32) @protobuf(2,bytes,opt)

	// currentAverageValue is the current value of the average of the
	// resource metric across all relevant pods, as a raw value (instead of as
	// a percentage of the request), similar to the "pods" metric source type.
	// It will always be set, regardless of the corresponding metric specification.
	currentAverageValue: resource.#Quantity @go(CurrentAverageValue) @protobuf(3,bytes)

	// container is the name of the container in the pods of the scaling taget
	container: string @go(Container) @protobuf(4,bytes,opt)
}

// ExternalMetricStatus indicates the current value of a global metric
// not associated with any Kubernetes object.
#ExternalMetricStatus: {
	// metricName is the name of a metric used for autoscaling in
	// metric system.
	metricName: string @go(MetricName) @protobuf(1,bytes)

	// metricSelector is used to identify a specific time series
	// within a given metric.
	// +optional
	metricSelector?: null | metav1.#LabelSelector @go(MetricSelector,*metav1.LabelSelector) @protobuf(2,bytes,opt)

	// currentValue is the current value of the metric (as a quantity)
	currentValue: resource.#Quantity @go(CurrentValue) @protobuf(3,bytes)

	// currentAverageValue is the current value of metric averaged over autoscaled pods.
	// +optional
	currentAverageValue?: null | resource.#Quantity @go(CurrentAverageValue,*resource.Quantity) @protobuf(4,bytes,opt)
}
