#!/bin/sh
# vim:ft=sh

_install_dot_files() {
	echo "Installing dotFiles into system"
	cp -Rf "$HOME"/.Files/src/.[a-zA-Z0-9]* "$HOME"/
}

_install_zplug() {
	_check_dev_tools
	_check_env
	export ZPLUG_HOME=$HOME/.zplug
	if [ ! -d "$ZPLUG_HOME" ]; then
		cd "$HOME" || exit
		git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
	fi
}

_install_packages() {
	_check_dev_tools
	_check_env
	echo "Installing packages..."
	if [ -d "$HOME"/.Files ]; then
		if [ "$(uname)" = "Darwin" ]; then
			cd "$HOME" || exit
			if [ -d "$HOME"/.homebrew ]; then
				rm -Rf "$HOME"/.homebrew
			fi
			git clone https://github.com/Homebrew/homebrew.git "$HOME"/.homebrew && brew update && brew upgrade && brew cask upgrade
			cd "$HOME"/.Files || exit
			brew bundle install && brew bundle cleanup
			cd "$HOME" || exit
		fi
		if [ "$(uname)" = "Linux" ]; then
			cd "$HOME"/.Files || exit
			apk update && apk upgrade && apk --update add $(paste -s -d ' ' Apkfile)
			cd "$HOME" || exit
		fi
		if command -v pip3 >/dev/null; then
			cd "$HOME"/.Files || exit
			pip3 install --upgrade pip
			pip3 install --upgrade --force-reinstall --no-cache-dir -r Pipfile
			cd "$HOME" || exit
		fi
		if command -v go >/dev/null; then
			cd "$HOME"/.Files || exit
			. source "$HOME"/.shellrc/golang
			while IFS= read -r line; do
				go get -u "$line"
			done <Gofile
			cd "$HOME" || exit
		fi
	else
		echo "$HOME/.Files directory is not available"
	fi
}

_dump_packages() {
	_check_dev_tools
	_check_env
	echo "Dumping list of installed packages"
	if [ -d "$HOME"/.Files ]; then
		cd "$HOME"/.Files || exit
		if [ "$(uname)" = "Darwin" ]; then
			brew bundle dump --force
		fi
		if [ "$(uname)" = "Linux" ]; then
			apk info >Apkfile
		fi
		if command -v pip3 >/dev/null; then
			pip3 freeze --local >Pipfile
		else
			echo "pip3 command is not installed"
		fi
		if command -v ruby >/dev/null; then
			ruby -e 'puts Gem::Specification.all_names' >Gemsfile
		else
			echo "ruby command is not installed"
		fi
		cd "$HOME" || exit
	else
		echo "$HOME/.Files directory is not available"
		exit 1
	fi
}

_add_repository() {
	for reponame in "main" "community" "testing"; do
		grep -qF "http://dl-cdn.alpinelinux.org/alpine/edge/$reponame" /etc/apk/repositories || echo "http://dl-cdn.alpinelinux.org/alpine/edge/$reponame" >>/etc/apk/repositories
	done
}

_check_env() {
	if [ "$(uname)" = "Darwin" ] && [ -d "$HOME"/.homebrew ]; then
		export PATH=$HOME/.homebrew/bin:$PATH
		# Set shell to zsh
		chsh -s /bin/zsh
	fi
	if [ "$(uname)" = "Linux" ]; then
		if ! command -v apk >/dev/null; then
			echo "Unsupported Linux. Only Alpine Linux is currently supported" && exit 1
		fi
	else
		_add_repository
		# Set shell to zsh
		apk --update add git curl zsh shadow && usermod -s /bin/zsh "$(id -u -n)"
	fi
}
