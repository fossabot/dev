#!/usr/bin/env bash

function main {
	(
		set +f
		cue export --out json -e cached_yaml k/*.cue "$@" \
			| jq -r 'to_entries[] | .value'
	) >"${out}"
}

source b/lib/lib.sh
