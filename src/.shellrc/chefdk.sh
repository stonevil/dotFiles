#!/usr/bin/env bash
# vim:ft=sh :

# Add OpScode Chef to the PATH
export CHEFDK=/opt/chefdk
if [ -d "$CHEFDK" ]; then
	export PATH=$PATH:$CHEFDK/bin
fi
