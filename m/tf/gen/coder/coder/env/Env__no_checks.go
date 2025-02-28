//go:build no_runtime_type_checking

package env

// Building without runtime type checking enabled, so all the below just return nil

func (e *jsiiProxy_Env) validateAddMoveTargetParameters(moveTarget *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateAddOverrideParameters(path *string, value interface{}) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetAnyMapAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetBooleanAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetBooleanMapAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetListAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetNumberAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetNumberListAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetNumberMapAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetStringAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateGetStringMapAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateImportFromParameters(id *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateInterpolationForAttributeParameters(terraformAttribute *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateMoveFromIdParameters(id *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateMoveToParameters(moveTarget *string, index interface{}) error {
	return nil
}

func (e *jsiiProxy_Env) validateMoveToIdParameters(id *string) error {
	return nil
}

func (e *jsiiProxy_Env) validateOverrideLogicalIdParameters(newLogicalId *string) error {
	return nil
}

func validateEnv_GenerateConfigForImportParameters(scope constructs.Construct, importToId *string, importFromId *string) error {
	return nil
}

func validateEnv_IsConstructParameters(x interface{}) error {
	return nil
}

func validateEnv_IsTerraformElementParameters(x interface{}) error {
	return nil
}

func validateEnv_IsTerraformResourceParameters(x interface{}) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetAgentIdParameters(val *string) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetConnectionParameters(val interface{}) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetCountParameters(val interface{}) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetIdParameters(val *string) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetLifecycleParameters(val *cdktf.TerraformResourceLifecycle) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetNameParameters(val *string) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetProvisionersParameters(val *[]interface{}) error {
	return nil
}

func (j *jsiiProxy_Env) validateSetValueParameters(val *string) error {
	return nil
}

func validateNewEnvParameters(scope constructs.Construct, id *string, config *EnvConfig) error {
	return nil
}
