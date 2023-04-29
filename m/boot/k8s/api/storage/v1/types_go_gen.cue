// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/api/storage/v1

package v1

import (
	metav1 "github.com/defn/m/boot/k8s/apimachinery/pkg/apis/meta/v1"
	"github.com/defn/m/boot/k8s/api/core/v1"
	"github.com/defn/m/boot/k8s/apimachinery/pkg/api/resource"
)

// StorageClass describes the parameters for a class of storage for
// which PersistentVolumes can be dynamically provisioned.
//
// StorageClasses are non-namespaced; the name of the storage class
// according to etcd is in ObjectMeta.Name.
#StorageClass: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// provisioner indicates the type of the provisioner.
	provisioner: string @go(Provisioner) @protobuf(2,bytes,opt)

	// parameters holds the parameters for the provisioner that should
	// create volumes of this storage class.
	// +optional
	parameters?: {[string]: string} @go(Parameters,map[string]string) @protobuf(3,bytes,rep)

	// reclaimPolicy controls the reclaimPolicy for dynamically provisioned PersistentVolumes of this storage class.
	// Defaults to Delete.
	// +optional
	reclaimPolicy?: null | v1.#PersistentVolumeReclaimPolicy @go(ReclaimPolicy,*v1.PersistentVolumeReclaimPolicy) @protobuf(4,bytes,opt,casttype=k8s.io/api/core/v1.PersistentVolumeReclaimPolicy)

	// mountOptions controls the mountOptions for dynamically provisioned PersistentVolumes of this storage class.
	// e.g. ["ro", "soft"]. Not validated -
	// mount of the PVs will simply fail if one is invalid.
	// +optional
	mountOptions?: [...string] @go(MountOptions,[]string) @protobuf(5,bytes,opt)

	// allowVolumeExpansion shows whether the storage class allow volume expand.
	// +optional
	allowVolumeExpansion?: null | bool @go(AllowVolumeExpansion,*bool) @protobuf(6,varint,opt)

	// volumeBindingMode indicates how PersistentVolumeClaims should be
	// provisioned and bound.  When unset, VolumeBindingImmediate is used.
	// This field is only honored by servers that enable the VolumeScheduling feature.
	// +optional
	volumeBindingMode?: null | #VolumeBindingMode @go(VolumeBindingMode,*VolumeBindingMode) @protobuf(7,bytes,opt)

	// allowedTopologies restrict the node topologies where volumes can be dynamically provisioned.
	// Each volume plugin defines its own supported topology specifications.
	// An empty TopologySelectorTerm list means there is no topology restriction.
	// This field is only honored by servers that enable the VolumeScheduling feature.
	// +optional
	// +listType=atomic
	allowedTopologies?: [...v1.#TopologySelectorTerm] @go(AllowedTopologies,[]v1.TopologySelectorTerm) @protobuf(8,bytes,rep)
}

// StorageClassList is a collection of storage classes.
#StorageClassList: {
	metav1.#TypeMeta

	// Standard list metadata
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of StorageClasses
	items: [...#StorageClass] @go(Items,[]StorageClass) @protobuf(2,bytes,rep)
}

// VolumeBindingMode indicates how PersistentVolumeClaims should be bound.
// +enum
#VolumeBindingMode: string // #enumVolumeBindingMode

#enumVolumeBindingMode:
	#VolumeBindingImmediate |
	#VolumeBindingWaitForFirstConsumer

// VolumeBindingImmediate indicates that PersistentVolumeClaims should be
// immediately provisioned and bound.  This is the default mode.
#VolumeBindingImmediate: #VolumeBindingMode & "Immediate"

// VolumeBindingWaitForFirstConsumer indicates that PersistentVolumeClaims
// should not be provisioned and bound until the first Pod is created that
// references the PeristentVolumeClaim.  The volume provisioning and
// binding will occur during Pod scheduing.
#VolumeBindingWaitForFirstConsumer: #VolumeBindingMode & "WaitForFirstConsumer"

// VolumeAttachment captures the intent to attach or detach the specified volume
// to/from the specified node.
//
// VolumeAttachment objects are non-namespaced.
#VolumeAttachment: {
	metav1.#TypeMeta

	// Standard object metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// spec represents specification of the desired attach/detach volume behavior.
	// Populated by the Kubernetes system.
	spec: #VolumeAttachmentSpec @go(Spec) @protobuf(2,bytes,opt)

	// status represents status of the VolumeAttachment request.
	// Populated by the entity completing the attach or detach
	// operation, i.e. the external-attacher.
	// +optional
	status?: #VolumeAttachmentStatus @go(Status) @protobuf(3,bytes,opt)
}

// VolumeAttachmentList is a collection of VolumeAttachment objects.
#VolumeAttachmentList: {
	metav1.#TypeMeta

	// Standard list metadata
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of VolumeAttachments
	items: [...#VolumeAttachment] @go(Items,[]VolumeAttachment) @protobuf(2,bytes,rep)
}

// VolumeAttachmentSpec is the specification of a VolumeAttachment request.
#VolumeAttachmentSpec: {
	// attacher indicates the name of the volume driver that MUST handle this
	// request. This is the name returned by GetPluginName().
	attacher: string @go(Attacher) @protobuf(1,bytes,opt)

	// source represents the volume that should be attached.
	source: #VolumeAttachmentSource @go(Source) @protobuf(2,bytes,opt)

	// nodeName represents the node that the volume should be attached to.
	nodeName: string @go(NodeName) @protobuf(3,bytes,opt)
}

// VolumeAttachmentSource represents a volume that should be attached.
// Right now only PersistenVolumes can be attached via external attacher,
// in future we may allow also inline volumes in pods.
// Exactly one member can be set.
#VolumeAttachmentSource: {
	// persistentVolumeName represents the name of the persistent volume to attach.
	// +optional
	persistentVolumeName?: null | string @go(PersistentVolumeName,*string) @protobuf(1,bytes,opt)

	// inlineVolumeSpec contains all the information necessary to attach
	// a persistent volume defined by a pod's inline VolumeSource. This field
	// is populated only for the CSIMigration feature. It contains
	// translated fields from a pod's inline VolumeSource to a
	// PersistentVolumeSpec. This field is beta-level and is only
	// honored by servers that enabled the CSIMigration feature.
	// +optional
	inlineVolumeSpec?: null | v1.#PersistentVolumeSpec @go(InlineVolumeSpec,*v1.PersistentVolumeSpec) @protobuf(2,bytes,opt)
}

// VolumeAttachmentStatus is the status of a VolumeAttachment request.
#VolumeAttachmentStatus: {
	// attached indicates the volume is successfully attached.
	// This field must only be set by the entity completing the attach
	// operation, i.e. the external-attacher.
	attached: bool @go(Attached) @protobuf(1,varint,opt)

	// attachmentMetadata is populated with any
	// information returned by the attach operation, upon successful attach, that must be passed
	// into subsequent WaitForAttach or Mount calls.
	// This field must only be set by the entity completing the attach
	// operation, i.e. the external-attacher.
	// +optional
	attachmentMetadata?: {[string]: string} @go(AttachmentMetadata,map[string]string) @protobuf(2,bytes,rep)

	// attachError represents the last error encountered during attach operation, if any.
	// This field must only be set by the entity completing the attach
	// operation, i.e. the external-attacher.
	// +optional
	attachError?: null | #VolumeError @go(AttachError,*VolumeError) @protobuf(3,bytes,opt,casttype=VolumeError)

	// detachError represents the last error encountered during detach operation, if any.
	// This field must only be set by the entity completing the detach
	// operation, i.e. the external-attacher.
	// +optional
	detachError?: null | #VolumeError @go(DetachError,*VolumeError) @protobuf(4,bytes,opt,casttype=VolumeError)
}

// VolumeError captures an error encountered during a volume operation.
#VolumeError: {
	// time represents the time the error was encountered.
	// +optional
	time?: metav1.#Time @go(Time) @protobuf(1,bytes,opt)

	// message represents the error encountered during Attach or Detach operation.
	// This string may be logged, so it should not contain sensitive
	// information.
	// +optional
	message?: string @go(Message) @protobuf(2,bytes,opt)
}

// CSIDriver captures information about a Container Storage Interface (CSI)
// volume driver deployed on the cluster.
// Kubernetes attach detach controller uses this object to determine whether attach is required.
// Kubelet uses this object to determine whether pod information needs to be passed on mount.
// CSIDriver objects are non-namespaced.
#CSIDriver: {
	metav1.#TypeMeta

	// Standard object metadata.
	// metadata.Name indicates the name of the CSI driver that this object
	// refers to; it MUST be the same name returned by the CSI GetPluginName()
	// call for that driver.
	// The driver name must be 63 characters or less, beginning and ending with
	// an alphanumeric character ([a-z0-9A-Z]) with dashes (-), dots (.), and
	// alphanumerics between.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// spec represents the specification of the CSI Driver.
	spec: #CSIDriverSpec @go(Spec) @protobuf(2,bytes,opt)
}

// CSIDriverList is a collection of CSIDriver objects.
#CSIDriverList: {
	metav1.#TypeMeta

	// Standard list metadata
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of CSIDriver
	items: [...#CSIDriver] @go(Items,[]CSIDriver) @protobuf(2,bytes,rep)
}

// CSIDriverSpec is the specification of a CSIDriver.
#CSIDriverSpec: {
	// attachRequired indicates this CSI volume driver requires an attach
	// operation (because it implements the CSI ControllerPublishVolume()
	// method), and that the Kubernetes attach detach controller should call
	// the attach volume interface which checks the volumeattachment status
	// and waits until the volume is attached before proceeding to mounting.
	// The CSI external-attacher coordinates with CSI volume driver and updates
	// the volumeattachment status when the attach operation is complete.
	// If the CSIDriverRegistry feature gate is enabled and the value is
	// specified to false, the attach operation will be skipped.
	// Otherwise the attach operation will be called.
	//
	// This field is immutable.
	//
	// +optional
	attachRequired?: null | bool @go(AttachRequired,*bool) @protobuf(1,varint,opt)

	// podInfoOnMount indicates this CSI volume driver requires additional pod information (like podName, podUID, etc.)
	// during mount operations, if set to true.
	// If set to false, pod information will not be passed on mount.
	// Default is false.
	//
	// The CSI driver specifies podInfoOnMount as part of driver deployment.
	// If true, Kubelet will pass pod information as VolumeContext in the CSI NodePublishVolume() calls.
	// The CSI driver is responsible for parsing and validating the information passed in as VolumeContext.
	//
	// The following VolumeConext will be passed if podInfoOnMount is set to true.
	// This list might grow, but the prefix will be used.
	// "csi.storage.k8s.io/pod.name": pod.Name
	// "csi.storage.k8s.io/pod.namespace": pod.Namespace
	// "csi.storage.k8s.io/pod.uid": string(pod.UID)
	// "csi.storage.k8s.io/ephemeral": "true" if the volume is an ephemeral inline volume
	//                                 defined by a CSIVolumeSource, otherwise "false"
	//
	// "csi.storage.k8s.io/ephemeral" is a new feature in Kubernetes 1.16. It is only
	// required for drivers which support both the "Persistent" and "Ephemeral" VolumeLifecycleMode.
	// Other drivers can leave pod info disabled and/or ignore this field.
	// As Kubernetes 1.15 doesn't support this field, drivers can only support one mode when
	// deployed on such a cluster and the deployment determines which mode that is, for example
	// via a command line parameter of the driver.
	//
	// This field is immutable.
	//
	// +optional
	podInfoOnMount?: null | bool @go(PodInfoOnMount,*bool) @protobuf(2,bytes,opt)

	// volumeLifecycleModes defines what kind of volumes this CSI volume driver supports.
	// The default if the list is empty is "Persistent", which is the usage defined by the
	// CSI specification and implemented in Kubernetes via the usual PV/PVC mechanism.
	//
	// The other mode is "Ephemeral". In this mode, volumes are defined inline inside the pod spec
	// with CSIVolumeSource and their lifecycle is tied to the lifecycle of that pod.
	// A driver has to be aware of this because it is only going to get a NodePublishVolume call for such a volume.
	//
	// For more information about implementing this mode, see
	// https://kubernetes-csi.github.io/docs/ephemeral-local-volumes.html
	// A driver can support one or more of these modes and more modes may be added in the future.
	//
	// This field is beta.
	// This field is immutable.
	//
	// +optional
	// +listType=set
	volumeLifecycleModes?: [...#VolumeLifecycleMode] @go(VolumeLifecycleModes,[]VolumeLifecycleMode) @protobuf(3,bytes,opt)

	// storageCapacity indicates that the CSI volume driver wants pod scheduling to consider the storage
	// capacity that the driver deployment will report by creating
	// CSIStorageCapacity objects with capacity information, if set to true.
	//
	// The check can be enabled immediately when deploying a driver.
	// In that case, provisioning new volumes with late binding
	// will pause until the driver deployment has published
	// some suitable CSIStorageCapacity object.
	//
	// Alternatively, the driver can be deployed with the field
	// unset or false and it can be flipped later when storage
	// capacity information has been published.
	//
	// This field was immutable in Kubernetes <= 1.22 and now is mutable.
	//
	// +optional
	// +featureGate=CSIStorageCapacity
	storageCapacity?: null | bool @go(StorageCapacity,*bool) @protobuf(4,bytes,opt)

	// fsGroupPolicy defines if the underlying volume supports changing ownership and
	// permission of the volume before being mounted.
	// Refer to the specific FSGroupPolicy values for additional details.
	//
	// This field is immutable.
	//
	// Defaults to ReadWriteOnceWithFSType, which will examine each volume
	// to determine if Kubernetes should modify ownership and permissions of the volume.
	// With the default policy the defined fsGroup will only be applied
	// if a fstype is defined and the volume's access mode contains ReadWriteOnce.
	//
	// +optional
	fsGroupPolicy?: null | #FSGroupPolicy @go(FSGroupPolicy,*FSGroupPolicy) @protobuf(5,bytes,opt)

	// tokenRequests indicates the CSI driver needs pods' service account
	// tokens it is mounting volume for to do necessary authentication. Kubelet
	// will pass the tokens in VolumeContext in the CSI NodePublishVolume calls.
	// The CSI driver should parse and validate the following VolumeContext:
	// "csi.storage.k8s.io/serviceAccount.tokens": {
	//   "<audience>": {
	//     "token": <token>,
	//     "expirationTimestamp": <expiration timestamp in RFC3339>,
	//   },
	//   ...
	// }
	//
	// Note: Audience in each TokenRequest should be different and at
	// most one token is empty string. To receive a new token after expiry,
	// RequiresRepublish can be used to trigger NodePublishVolume periodically.
	//
	// +optional
	// +listType=atomic
	tokenRequests?: [...#TokenRequest] @go(TokenRequests,[]TokenRequest) @protobuf(6,bytes,opt)

	// requiresRepublish indicates the CSI driver wants `NodePublishVolume`
	// being periodically called to reflect any possible change in the mounted
	// volume. This field defaults to false.
	//
	// Note: After a successful initial NodePublishVolume call, subsequent calls
	// to NodePublishVolume should only update the contents of the volume. New
	// mount points will not be seen by a running container.
	//
	// +optional
	requiresRepublish?: null | bool @go(RequiresRepublish,*bool) @protobuf(7,varint,opt)

	// seLinuxMount specifies if the CSI driver supports "-o context"
	// mount option.
	//
	// When "true", the CSI driver must ensure that all volumes provided by this CSI
	// driver can be mounted separately with different `-o context` options. This is
	// typical for storage backends that provide volumes as filesystems on block
	// devices or as independent shared volumes.
	// Kubernetes will call NodeStage / NodePublish with "-o context=xyz" mount
	// option when mounting a ReadWriteOncePod volume used in Pod that has
	// explicitly set SELinux context. In the future, it may be expanded to other
	// volume AccessModes. In any case, Kubernetes will ensure that the volume is
	// mounted only with a single SELinux context.
	//
	// When "false", Kubernetes won't pass any special SELinux mount options to the driver.
	// This is typical for volumes that represent subdirectories of a bigger shared filesystem.
	//
	// Default is "false".
	//
	// +featureGate=SELinuxMountReadWriteOncePod
	// +optional
	seLinuxMount?: null | bool @go(SELinuxMount,*bool) @protobuf(8,varint,opt)
}

// FSGroupPolicy specifies if a CSI Driver supports modifying
// volume ownership and permissions of the volume to be mounted.
// More modes may be added in the future.
#FSGroupPolicy: string // #enumFSGroupPolicy

#enumFSGroupPolicy:
	#ReadWriteOnceWithFSTypeFSGroupPolicy |
	#FileFSGroupPolicy |
	#NoneFSGroupPolicy

// ReadWriteOnceWithFSTypeFSGroupPolicy indicates that each volume will be examined
// to determine if the volume ownership and permissions
// should be modified. If a fstype is defined and the volume's access mode
// contains ReadWriteOnce, then the defined fsGroup will be applied.
// This mode should be defined if it's expected that the
// fsGroup may need to be modified depending on the pod's SecurityPolicy.
// This is the default behavior if no other FSGroupPolicy is defined.
#ReadWriteOnceWithFSTypeFSGroupPolicy: #FSGroupPolicy & "ReadWriteOnceWithFSType"

// FileFSGroupPolicy indicates that CSI driver supports volume ownership
// and permission change via fsGroup, and Kubernetes will change the permissions
// and ownership of every file in the volume to match the user requested fsGroup in
// the pod's SecurityPolicy regardless of fstype or access mode.
// Use this mode if Kubernetes should modify the permissions and ownership
// of the volume.
#FileFSGroupPolicy: #FSGroupPolicy & "File"

// NoneFSGroupPolicy indicates that volumes will be mounted without performing
// any ownership or permission modifications, as the CSIDriver does not support
// these operations.
// This mode should be selected if the CSIDriver does not support fsGroup modifications,
// for example when Kubernetes cannot change ownership and permissions on a volume due
// to root-squash settings on a NFS volume.
#NoneFSGroupPolicy: #FSGroupPolicy & "None"

// VolumeLifecycleMode is an enumeration of possible usage modes for a volume
// provided by a CSI driver. More modes may be added in the future.
#VolumeLifecycleMode: string // #enumVolumeLifecycleMode

#enumVolumeLifecycleMode:
	#VolumeLifecyclePersistent |
	#VolumeLifecycleEphemeral

// TokenRequest contains parameters of a service account token.
#TokenRequest: {
	// audience is the intended audience of the token in "TokenRequestSpec".
	// It will default to the audiences of kube apiserver.
	audience: string @go(Audience) @protobuf(1,bytes,opt)

	// expirationSeconds is the duration of validity of the token in "TokenRequestSpec".
	// It has the same default value of "ExpirationSeconds" in "TokenRequestSpec".
	//
	// +optional
	expirationSeconds?: null | int64 @go(ExpirationSeconds,*int64) @protobuf(2,varint,opt)
}

// VolumeLifecyclePersistent explicitly confirms that the driver implements
// the full CSI spec. It is the default when CSIDriverSpec.VolumeLifecycleModes is not
// set. Such volumes are managed in Kubernetes via the persistent volume
// claim mechanism and have a lifecycle that is independent of the pods which
// use them.
#VolumeLifecyclePersistent: #VolumeLifecycleMode & "Persistent"

// VolumeLifecycleEphemeral indicates that the driver can be used for
// ephemeral inline volumes. Such volumes are specified inside the pod
// spec with a CSIVolumeSource and, as far as Kubernetes is concerned, have
// a lifecycle that is tied to the lifecycle of the pod. For example, such
// a volume might contain data that gets created specifically for that pod,
// like secrets.
// But how the volume actually gets created and managed is entirely up to
// the driver. It might also use reference counting to share the same volume
// instance among different pods if the CSIVolumeSource of those pods is
// identical.
#VolumeLifecycleEphemeral: #VolumeLifecycleMode & "Ephemeral"

// CSINode holds information about all CSI drivers installed on a node.
// CSI drivers do not need to create the CSINode object directly. As long as
// they use the node-driver-registrar sidecar container, the kubelet will
// automatically populate the CSINode object for the CSI driver as part of
// kubelet plugin registration.
// CSINode has the same name as a node. If the object is missing, it means either
// there are no CSI Drivers available on the node, or the Kubelet version is low
// enough that it doesn't create this object.
// CSINode has an OwnerReference that points to the corresponding node object.
#CSINode: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// metadata.name must be the Kubernetes node name.
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// spec is the specification of CSINode
	spec: #CSINodeSpec @go(Spec) @protobuf(2,bytes,opt)
}

// CSINodeSpec holds information about the specification of all CSI drivers installed on a node
#CSINodeSpec: {
	// drivers is a list of information of all CSI Drivers existing on a node.
	// If all drivers in the list are uninstalled, this can become empty.
	// +patchMergeKey=name
	// +patchStrategy=merge
	drivers: [...#CSINodeDriver] @go(Drivers,[]CSINodeDriver) @protobuf(1,bytes,rep)
}

// CSINodeDriver holds information about the specification of one CSI driver installed on a node
#CSINodeDriver: {
	// name represents the name of the CSI driver that this object refers to.
	// This MUST be the same name returned by the CSI GetPluginName() call for
	// that driver.
	name: string @go(Name) @protobuf(1,bytes,opt)

	// nodeID of the node from the driver point of view.
	// This field enables Kubernetes to communicate with storage systems that do
	// not share the same nomenclature for nodes. For example, Kubernetes may
	// refer to a given node as "node1", but the storage system may refer to
	// the same node as "nodeA". When Kubernetes issues a command to the storage
	// system to attach a volume to a specific node, it can use this field to
	// refer to the node name using the ID that the storage system will
	// understand, e.g. "nodeA" instead of "node1". This field is required.
	nodeID: string @go(NodeID) @protobuf(2,bytes,opt)

	// topologyKeys is the list of keys supported by the driver.
	// When a driver is initialized on a cluster, it provides a set of topology
	// keys that it understands (e.g. "company.com/zone", "company.com/region").
	// When a driver is initialized on a node, it provides the same topology keys
	// along with values. Kubelet will expose these topology keys as labels
	// on its own node object.
	// When Kubernetes does topology aware provisioning, it can use this list to
	// determine which labels it should retrieve from the node object and pass
	// back to the driver.
	// It is possible for different nodes to use different topology keys.
	// This can be empty if driver does not support topology.
	// +optional
	topologyKeys: [...string] @go(TopologyKeys,[]string) @protobuf(3,bytes,rep)

	// allocatable represents the volume resources of a node that are available for scheduling.
	// This field is beta.
	// +optional
	allocatable?: null | #VolumeNodeResources @go(Allocatable,*VolumeNodeResources) @protobuf(4,bytes,opt)
}

// VolumeNodeResources is a set of resource limits for scheduling of volumes.
#VolumeNodeResources: {
	// count indicates the maximum number of unique volumes managed by the CSI driver that can be used on a node.
	// A volume that is both attached and mounted on a node is considered to be used once, not twice.
	// The same rule applies for a unique volume that is shared among multiple pods on the same node.
	// If this field is not specified, then the supported number of volumes on this node is unbounded.
	// +optional
	count?: null | int32 @go(Count,*int32) @protobuf(1,varint,opt)
}

// CSINodeList is a collection of CSINode objects.
#CSINodeList: {
	metav1.#TypeMeta

	// Standard list metadata
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of CSINode
	items: [...#CSINode] @go(Items,[]CSINode) @protobuf(2,bytes,rep)
}

// CSIStorageCapacity stores the result of one CSI GetCapacity call.
// For a given StorageClass, this describes the available capacity in a
// particular topology segment.  This can be used when considering where to
// instantiate new PersistentVolumes.
//
// For example this can express things like:
// - StorageClass "standard" has "1234 GiB" available in "topology.kubernetes.io/zone=us-east1"
// - StorageClass "localssd" has "10 GiB" available in "kubernetes.io/hostname=knode-abc123"
//
// The following three cases all imply that no capacity is available for
// a certain combination:
// - no object exists with suitable topology and storage class name
// - such an object exists, but the capacity is unset
// - such an object exists, but the capacity is zero
//
// The producer of these objects can decide which approach is more suitable.
//
// They are consumed by the kube-scheduler when a CSI driver opts into
// capacity-aware scheduling with CSIDriverSpec.StorageCapacity. The scheduler
// compares the MaximumVolumeSize against the requested size of pending volumes
// to filter out unsuitable nodes. If MaximumVolumeSize is unset, it falls back
// to a comparison against the less precise Capacity. If that is also unset,
// the scheduler assumes that capacity is insufficient and tries some other
// node.
#CSIStorageCapacity: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// The name has no particular meaning. It must be a DNS subdomain (dots allowed, 253 characters).
	// To ensure that there are no conflicts with other CSI drivers on the cluster,
	// the recommendation is to use csisc-<uuid>, a generated name, or a reverse-domain name
	// which ends with the unique CSI driver name.
	//
	// Objects are namespaced.
	//
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// nodeTopology defines which nodes have access to the storage
	// for which capacity was reported. If not set, the storage is
	// not accessible from any node in the cluster. If empty, the
	// storage is accessible from all nodes. This field is
	// immutable.
	//
	// +optional
	nodeTopology?: null | metav1.#LabelSelector @go(NodeTopology,*metav1.LabelSelector) @protobuf(2,bytes,opt)

	// storageClassName represents the name of the StorageClass that the reported capacity applies to.
	// It must meet the same requirements as the name of a StorageClass
	// object (non-empty, DNS subdomain). If that object no longer exists,
	// the CSIStorageCapacity object is obsolete and should be removed by its
	// creator.
	// This field is immutable.
	storageClassName: string @go(StorageClassName) @protobuf(3,bytes)

	// capacity is the value reported by the CSI driver in its GetCapacityResponse
	// for a GetCapacityRequest with topology and parameters that match the
	// previous fields.
	//
	// The semantic is currently (CSI spec 1.2) defined as:
	// The available capacity, in bytes, of the storage that can be used
	// to provision volumes. If not set, that information is currently
	// unavailable.
	//
	// +optional
	capacity?: null | resource.#Quantity @go(Capacity,*resource.Quantity) @protobuf(4,bytes,opt)

	// maximumVolumeSize is the value reported by the CSI driver in its GetCapacityResponse
	// for a GetCapacityRequest with topology and parameters that match the
	// previous fields.
	//
	// This is defined since CSI spec 1.4.0 as the largest size
	// that may be used in a
	// CreateVolumeRequest.capacity_range.required_bytes field to
	// create a volume with the same parameters as those in
	// GetCapacityRequest. The corresponding value in the Kubernetes
	// API is ResourceRequirements.Requests in a volume claim.
	//
	// +optional
	maximumVolumeSize?: null | resource.#Quantity @go(MaximumVolumeSize,*resource.Quantity) @protobuf(5,bytes,opt)
}

// CSIStorageCapacityList is a collection of CSIStorageCapacity objects.
#CSIStorageCapacityList: {
	metav1.#TypeMeta

	// Standard list metadata
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of CSIStorageCapacity objects.
	// +listType=map
	// +listMapKey=name
	items: [...#CSIStorageCapacity] @go(Items,[]CSIStorageCapacity) @protobuf(2,bytes,rep)
}
