#!/usr/bin/env bash
# vim:ft=sh :

# Configure gcurl alias
if command -v oauth2l >/dev/null; then
	alias gcurl='curl -H "$(oauth2l header --json ~/credentials.json cloud-platform userinfo.email)" -H "Content-Type: application/json" '
fi

if [ -d "$HOME/.krew/bin" ]; then
	export PATH=$PATH:$HOME/.krew/bin
fi
