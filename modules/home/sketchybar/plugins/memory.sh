#!/bin/bash

hw_pagesize="$(sysctl -n hw.pagesize)"
mem_total="$(($(sysctl -n hw.memsize) / 1024 / 1024))"
mem_total_gb="$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024))"
pages_app="$(($(sysctl -n vm.page_pageable_internal_count) - $(sysctl -n vm.page_purgeable_count)))"
pages_wired="$(vm_stat | awk '/ wired/ { print $4 }')"
pages_compressed="$(vm_stat | awk '/ occupied/ { printf $5 }')"
pages_compressed="${pages_compressed:-0}"
mem_used="$(((${pages_app} + ${pages_wired//./} + ${pages_compressed//./}) * hw_pagesize / 1024 / 1024))"
mem_used_gb="$((${mem_used} / 1024))"

sketchybar --set "$NAME" label="RAM: $mem_used_gb GiB/$mem_total_gb GiB"
