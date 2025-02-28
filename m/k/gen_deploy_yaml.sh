#!/usr/bin/env bash

# bump: 2

function main {
	local cue="${shome}/${in[cue]}"
	local registry="${in[registry]}"

	local cue_import="$1"
	shift
	local image_digest="$1"
	shift
	local out="$1"
	shift

	set +f

	"${cue}" export --out json -e image_digests "${cue_import}" "${image_digest}" k/*.cue |
		jq -r '.[]' |
		while read -r image_original image_digested; do
			if [[ "$(skopeo inspect --tls-verify=false "docker://${registry}/${image_digested}" | jq -r .Digest)" != "${image_digested##*@}" ]]; then
				echo "caching ${image_digested} to docker://${registry}/${image_digested%%@*}"
				skopeo copy docker://${image_digested} docker://${registry}/${image_digested%%@*} --multi-arch all --dest-tls-verify=false --insecure-policy
			else
				echo "already cached ${image_digested} to docker://${registry}/${image_digested%%@*}"
			fi
		done

	"${cue}" export --out json -e cached_yaml "${cue_import}" "${image_digest}" k/*.cue |
		jq -r 'to_entries[] | .value' \
			>"${out}"
}

source b/lib/lib.sh
