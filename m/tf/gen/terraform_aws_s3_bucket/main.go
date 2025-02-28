// terraform_aws_s3_bucket
package terraform_aws_s3_bucket

import (
	"reflect"

	_jsii_ "github.com/aws/jsii-runtime-go/runtime"
)

func init() {
	_jsii_.RegisterClass(
		"terraform_aws_s3_bucket.TerraformAwsS3Bucket",
		reflect.TypeOf((*TerraformAwsS3Bucket)(nil)).Elem(),
		[]_jsii_.Member{
			_jsii_.MemberProperty{JsiiProperty: "accessKeyEnabled", GoGetter: "AccessKeyEnabled"},
			_jsii_.MemberProperty{JsiiProperty: "accessKeyIdOutput", GoGetter: "AccessKeyIdOutput"},
			_jsii_.MemberProperty{JsiiProperty: "accessKeyIdSsmPathOutput", GoGetter: "AccessKeyIdSsmPathOutput"},
			_jsii_.MemberProperty{JsiiProperty: "acl", GoGetter: "Acl"},
			_jsii_.MemberProperty{JsiiProperty: "additionalTagMap", GoGetter: "AdditionalTagMap"},
			_jsii_.MemberMethod{JsiiMethod: "addOverride", GoMethod: "AddOverride"},
			_jsii_.MemberMethod{JsiiMethod: "addProvider", GoMethod: "AddProvider"},
			_jsii_.MemberProperty{JsiiProperty: "allowedBucketActions", GoGetter: "AllowedBucketActions"},
			_jsii_.MemberProperty{JsiiProperty: "allowEncryptedUploadsOnly", GoGetter: "AllowEncryptedUploadsOnly"},
			_jsii_.MemberProperty{JsiiProperty: "allowSslRequestsOnly", GoGetter: "AllowSslRequestsOnly"},
			_jsii_.MemberProperty{JsiiProperty: "attributes", GoGetter: "Attributes"},
			_jsii_.MemberProperty{JsiiProperty: "blockPublicAcls", GoGetter: "BlockPublicAcls"},
			_jsii_.MemberProperty{JsiiProperty: "blockPublicPolicy", GoGetter: "BlockPublicPolicy"},
			_jsii_.MemberProperty{JsiiProperty: "bucketArnOutput", GoGetter: "BucketArnOutput"},
			_jsii_.MemberProperty{JsiiProperty: "bucketDomainNameOutput", GoGetter: "BucketDomainNameOutput"},
			_jsii_.MemberProperty{JsiiProperty: "bucketIdOutput", GoGetter: "BucketIdOutput"},
			_jsii_.MemberProperty{JsiiProperty: "bucketKeyEnabled", GoGetter: "BucketKeyEnabled"},
			_jsii_.MemberProperty{JsiiProperty: "bucketName", GoGetter: "BucketName"},
			_jsii_.MemberProperty{JsiiProperty: "bucketRegionalDomainNameOutput", GoGetter: "BucketRegionalDomainNameOutput"},
			_jsii_.MemberProperty{JsiiProperty: "bucketRegionOutput", GoGetter: "BucketRegionOutput"},
			_jsii_.MemberProperty{JsiiProperty: "bucketWebsiteDomainOutput", GoGetter: "BucketWebsiteDomainOutput"},
			_jsii_.MemberProperty{JsiiProperty: "bucketWebsiteEndpointOutput", GoGetter: "BucketWebsiteEndpointOutput"},
			_jsii_.MemberProperty{JsiiProperty: "cdktfStack", GoGetter: "CdktfStack"},
			_jsii_.MemberProperty{JsiiProperty: "constructNodeMetadata", GoGetter: "ConstructNodeMetadata"},
			_jsii_.MemberProperty{JsiiProperty: "context", GoGetter: "Context"},
			_jsii_.MemberProperty{JsiiProperty: "corsConfiguration", GoGetter: "CorsConfiguration"},
			_jsii_.MemberProperty{JsiiProperty: "delimiter", GoGetter: "Delimiter"},
			_jsii_.MemberProperty{JsiiProperty: "dependsOn", GoGetter: "DependsOn"},
			_jsii_.MemberProperty{JsiiProperty: "descriptorFormats", GoGetter: "DescriptorFormats"},
			_jsii_.MemberProperty{JsiiProperty: "enabled", GoGetter: "Enabled"},
			_jsii_.MemberProperty{JsiiProperty: "enabledOutput", GoGetter: "EnabledOutput"},
			_jsii_.MemberProperty{JsiiProperty: "environment", GoGetter: "Environment"},
			_jsii_.MemberProperty{JsiiProperty: "forceDestroy", GoGetter: "ForceDestroy"},
			_jsii_.MemberProperty{JsiiProperty: "forEach", GoGetter: "ForEach"},
			_jsii_.MemberProperty{JsiiProperty: "fqn", GoGetter: "Fqn"},
			_jsii_.MemberProperty{JsiiProperty: "friendlyUniqueId", GoGetter: "FriendlyUniqueId"},
			_jsii_.MemberMethod{JsiiMethod: "getString", GoMethod: "GetString"},
			_jsii_.MemberProperty{JsiiProperty: "grants", GoGetter: "Grants"},
			_jsii_.MemberProperty{JsiiProperty: "idLengthLimit", GoGetter: "IdLengthLimit"},
			_jsii_.MemberProperty{JsiiProperty: "ignorePublicAcls", GoGetter: "IgnorePublicAcls"},
			_jsii_.MemberMethod{JsiiMethod: "interpolationForOutput", GoMethod: "InterpolationForOutput"},
			_jsii_.MemberProperty{JsiiProperty: "kmsMasterKeyArn", GoGetter: "KmsMasterKeyArn"},
			_jsii_.MemberProperty{JsiiProperty: "labelKeyCase", GoGetter: "LabelKeyCase"},
			_jsii_.MemberProperty{JsiiProperty: "labelOrder", GoGetter: "LabelOrder"},
			_jsii_.MemberProperty{JsiiProperty: "labelsAsTags", GoGetter: "LabelsAsTags"},
			_jsii_.MemberProperty{JsiiProperty: "labelValueCase", GoGetter: "LabelValueCase"},
			_jsii_.MemberProperty{JsiiProperty: "lifecycleConfigurationRules", GoGetter: "LifecycleConfigurationRules"},
			_jsii_.MemberProperty{JsiiProperty: "lifecycleRuleIds", GoGetter: "LifecycleRuleIds"},
			_jsii_.MemberProperty{JsiiProperty: "lifecycleRules", GoGetter: "LifecycleRules"},
			_jsii_.MemberProperty{JsiiProperty: "logging", GoGetter: "Logging"},
			_jsii_.MemberProperty{JsiiProperty: "name", GoGetter: "Name"},
			_jsii_.MemberProperty{JsiiProperty: "namespace", GoGetter: "Namespace"},
			_jsii_.MemberProperty{JsiiProperty: "node", GoGetter: "Node"},
			_jsii_.MemberProperty{JsiiProperty: "objectLockConfiguration", GoGetter: "ObjectLockConfiguration"},
			_jsii_.MemberMethod{JsiiMethod: "overrideLogicalId", GoMethod: "OverrideLogicalId"},
			_jsii_.MemberProperty{JsiiProperty: "policy", GoGetter: "Policy"},
			_jsii_.MemberProperty{JsiiProperty: "privilegedPrincipalActions", GoGetter: "PrivilegedPrincipalActions"},
			_jsii_.MemberProperty{JsiiProperty: "privilegedPrincipalArns", GoGetter: "PrivilegedPrincipalArns"},
			_jsii_.MemberProperty{JsiiProperty: "providers", GoGetter: "Providers"},
			_jsii_.MemberProperty{JsiiProperty: "rawOverrides", GoGetter: "RawOverrides"},
			_jsii_.MemberProperty{JsiiProperty: "regexReplaceChars", GoGetter: "RegexReplaceChars"},
			_jsii_.MemberProperty{JsiiProperty: "replicationRoleArnOutput", GoGetter: "ReplicationRoleArnOutput"},
			_jsii_.MemberProperty{JsiiProperty: "replicationRules", GoGetter: "ReplicationRules"},
			_jsii_.MemberMethod{JsiiMethod: "resetOverrideLogicalId", GoMethod: "ResetOverrideLogicalId"},
			_jsii_.MemberProperty{JsiiProperty: "restrictPublicBuckets", GoGetter: "RestrictPublicBuckets"},
			_jsii_.MemberProperty{JsiiProperty: "s3ObjectOwnership", GoGetter: "S3ObjectOwnership"},
			_jsii_.MemberProperty{JsiiProperty: "s3ReplicaBucketArn", GoGetter: "S3ReplicaBucketArn"},
			_jsii_.MemberProperty{JsiiProperty: "s3ReplicationEnabled", GoGetter: "S3ReplicationEnabled"},
			_jsii_.MemberProperty{JsiiProperty: "s3ReplicationPermissionsBoundaryArn", GoGetter: "S3ReplicationPermissionsBoundaryArn"},
			_jsii_.MemberProperty{JsiiProperty: "s3ReplicationRules", GoGetter: "S3ReplicationRules"},
			_jsii_.MemberProperty{JsiiProperty: "s3ReplicationSourceRoles", GoGetter: "S3ReplicationSourceRoles"},
			_jsii_.MemberProperty{JsiiProperty: "secretAccessKeyOutput", GoGetter: "SecretAccessKeyOutput"},
			_jsii_.MemberProperty{JsiiProperty: "secretAccessKeySsmPathOutput", GoGetter: "SecretAccessKeySsmPathOutput"},
			_jsii_.MemberProperty{JsiiProperty: "skipAssetCreationFromLocalModules", GoGetter: "SkipAssetCreationFromLocalModules"},
			_jsii_.MemberProperty{JsiiProperty: "source", GoGetter: "Source"},
			_jsii_.MemberProperty{JsiiProperty: "sourcePolicyDocuments", GoGetter: "SourcePolicyDocuments"},
			_jsii_.MemberProperty{JsiiProperty: "sseAlgorithm", GoGetter: "SseAlgorithm"},
			_jsii_.MemberProperty{JsiiProperty: "ssmBasePath", GoGetter: "SsmBasePath"},
			_jsii_.MemberProperty{JsiiProperty: "stage", GoGetter: "Stage"},
			_jsii_.MemberProperty{JsiiProperty: "storeAccessKeyInSsm", GoGetter: "StoreAccessKeyInSsm"},
			_jsii_.MemberMethod{JsiiMethod: "synthesizeAttributes", GoMethod: "SynthesizeAttributes"},
			_jsii_.MemberMethod{JsiiMethod: "synthesizeHclAttributes", GoMethod: "SynthesizeHclAttributes"},
			_jsii_.MemberProperty{JsiiProperty: "tags", GoGetter: "Tags"},
			_jsii_.MemberProperty{JsiiProperty: "tenant", GoGetter: "Tenant"},
			_jsii_.MemberMethod{JsiiMethod: "toHclTerraform", GoMethod: "ToHclTerraform"},
			_jsii_.MemberMethod{JsiiMethod: "toMetadata", GoMethod: "ToMetadata"},
			_jsii_.MemberMethod{JsiiMethod: "toString", GoMethod: "ToString"},
			_jsii_.MemberMethod{JsiiMethod: "toTerraform", GoMethod: "ToTerraform"},
			_jsii_.MemberProperty{JsiiProperty: "transferAccelerationEnabled", GoGetter: "TransferAccelerationEnabled"},
			_jsii_.MemberProperty{JsiiProperty: "userArnOutput", GoGetter: "UserArnOutput"},
			_jsii_.MemberProperty{JsiiProperty: "userEnabled", GoGetter: "UserEnabled"},
			_jsii_.MemberProperty{JsiiProperty: "userEnabledOutput", GoGetter: "UserEnabledOutput"},
			_jsii_.MemberProperty{JsiiProperty: "userNameOutput", GoGetter: "UserNameOutput"},
			_jsii_.MemberProperty{JsiiProperty: "userPermissionsBoundaryArn", GoGetter: "UserPermissionsBoundaryArn"},
			_jsii_.MemberProperty{JsiiProperty: "userUniqueIdOutput", GoGetter: "UserUniqueIdOutput"},
			_jsii_.MemberProperty{JsiiProperty: "version", GoGetter: "Version"},
			_jsii_.MemberProperty{JsiiProperty: "versioningEnabled", GoGetter: "VersioningEnabled"},
			_jsii_.MemberProperty{JsiiProperty: "websiteConfiguration", GoGetter: "WebsiteConfiguration"},
			_jsii_.MemberProperty{JsiiProperty: "websiteRedirectAllRequestsTo", GoGetter: "WebsiteRedirectAllRequestsTo"},
		},
		func() interface{} {
			j := jsiiProxy_TerraformAwsS3Bucket{}
			_jsii_.InitJsiiProxy(&j.Type__cdktfTerraformModule)
			return &j
		},
	)
	_jsii_.RegisterStruct(
		"terraform_aws_s3_bucket.TerraformAwsS3BucketConfig",
		reflect.TypeOf((*TerraformAwsS3BucketConfig)(nil)).Elem(),
	)
}
