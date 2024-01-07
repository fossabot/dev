#!/usr/bin/env bash

function main {
	local app="${in[app]}"
	local name="${in[name]}"
	local registry="${in[registry]}"

	mkdir chart
	tar xfz "${app}" -C chart

	(
		set +f
		cd chart/*/
		local version="$(helm show chart --insecure-skip-tls-verify "oci://${registry}/${name}" 2>/dev/null | grep ^version: | awk '{print $2}')"
		local bumped_version="${version%.*}.$(( ${version##*.} + 1))"

		sed "s#^version: .*#version: ${bumped_version}#" -i Chart.yaml
		sed "s#^appVersion: .*#version: ${bumped_version}#" -i Chart.yaml

		cd ..
		helm package */

		cd ..
		cp */*.tgz chart.tgz
	)
	
	helm push --insecure-skip-tls-verify chart.tgz "oci://${registry}"

	cp chart.tgz "${out}"
}

source b/lib/lib.sh