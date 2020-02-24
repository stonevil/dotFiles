#!/bin/sh
# vim:ft=sh
# shellcheck source=/dev/null

# TODO
# Add gem install
# Add go get some packages
# lazydock and lazygit for Alpine
# Add edge and testing and community repo
# Rewrite all this bs to zsh plugins

_connection_internet_check() {
	echo "Check Internet connection"
	if command -v curl >/dev/null; then
		"$(curl -sL -w "%{http_code}\n" "http://www.github.com/" -o /dev/null)" -eq 200 && return 0
	else
		echo "curl command is not installed. Internet connection is not tested" && return 0
	fi
}

_tools_dev_check() {
	if ! command -v git >/dev/null; then
		if _connection_internet_check; then
			if [ "$(uname)" = "Darwin" ]; then
				xcode-select --install || exit 1
			fi
			if [ "$(uname)" = "Linux" ]; then
				apk add --update git || exit 1
			fi
		fi
	fi
}

_files_dot_repo_clone() {
	if [ ! -d "$HOME"/.Files ]; then
		if _check_internet_connection; then
			cd "$HOME" || exit 1
			git clone https://github.com/stonevil/dotFiles.git "$HOME"/.Files || exit 1
		fi
	fi
}

# Preflight check
_tools_dev_check
if [ ! -f "$HOME"/.Files/framework.sh ]; then
	_files_dot_repo_clone
else
	. "$HOME"/.Files/framework.sh || exit 1
fi

# Main
if [ -d "$HOME"/.Files ]; then
	case "$1" in
	dump)
		_packages_dump_list
		;;
	pkgs)
		_toolset_install
		;;
	dot)
		_files_dot_install
		;;
	update)
		_files_dot_update
		_toolset_update
		;;
	*)
		_files_dot_install
		_toolset_install
		;;
	esac
fi
