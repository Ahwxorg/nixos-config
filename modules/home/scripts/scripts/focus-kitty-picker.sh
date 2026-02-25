#!/usr/bin/env bash

if [ "$1" = "kitty-picker" ]; then
	while :; do
		window_id=$(aerospace list-windows --all --format %{window-id}%{app-name} --json | jq ".[] | select(.\"app-name\" == \"kitty\") | .\"window-id\"")
		if [ ! -z "${window_id}" ]; then
			$(aerospace focus --window-id "${window_id}")
			break
		fi
	done
fi
