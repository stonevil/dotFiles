#!/usr/bin/env bash
# vim:ft=sh :

# Disable Microsoft to sneak on you
if command -v az >/dev/null; then
	export AZURE_CORE_COLLECT_TELEMETRY=FALSE
	export AZURE_LOGGING_ENABLE_LOG_FILE=FALSE
fi
