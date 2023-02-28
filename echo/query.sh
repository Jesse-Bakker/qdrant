#!/usr/bin/env zsh

set -euo pipefail

function main {
	declare nodes=${1:-5}

	declare addrs=()

	for ((node = 0; node < nodes; node++))
	do
		addrs+=( 127.0.0.1:$((9000 + node)) )
	done

	declare data=${(j:, :)${:-\"${^addrs}\"}}

	for (( node = 0; node < nodes; node++))
	do
		curl 127.0.0.1:$((8000 + node)) \
			-X POST \
			-H 'Content-Type: application/json' \
			--data-raw "{\"nodes\": [$data]}" | jq
	done
}

main $@