#!/usr/bin/env bash

set -eufo pipefail

function main {
	set +f
	for a in */; do
		if grep ghrepo "${a}/flake.json" >/dev/null 2>/dev/null; then
			(
				cd "${a}"
				echo "${a} $(jq -r '.vendor' <flake.json || true) $(../az/bin/n-latest || true)" | while read -r slug current latest real_tag; do
					echo "${slug} ${current} ${latest} https://github.com/$(jq -r .ghrepo <flake.json)/releases/tag/${real_tag}"
				done
			)
		fi
	done | while read -r slug current latest real_tag; do
		if [[ ${current} != "${latest}" ]]; then
			echo "${slug} ${current} ${latest} ${real_tag}"
		fi
	done | (grep -E -v 'kustomize/ 5.0.3 5.1.0' || true)
}

main "$@"
