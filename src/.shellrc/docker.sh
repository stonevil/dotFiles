#!/usr/bin/env bash
# vim:ft=sh :

# Docker
if command -v docker >/dev/null; then
	alias docker-stop-all='docker stop $(docker ps -a -q)'
	alias docker-rm-all='docker rm -f $(docker ps -a -q)'
	alias docker-rmi-all='docker rmi -f $(docker images --no-trunc=false -a -q)'
	if [ "$(uname)" = "Darwin" ]; then
		alias docker-app-stop="osascript -e 'quit app \"Docker\"'"
		alias docker-app-start='open -a Docker'
	fi

	docker_build_create() {
		docker network create build-net && docker run -d --rm --network build-net --name "squid" mrmagooey/aggressive-squid-cache
	}

	docker_build_delete() {
		docker stop squid && docker rm squid && docker network rm build-net
	}

	dbuild() {
		docker build --network build-net --build-arg http_proxy=http://squid:3128 "$@"
	}

	container_ip() {
		docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
	}
fi
