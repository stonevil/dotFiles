#!/usr/bin/env bash
# vim:ft=sh :

export VAGRANT_PROVIDER_GUI="false"

vagrant_ip() {
	vagrant ssh -c "ip address show eth0 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//'"
}

vagrant_install_all_plugins() {
	vagrant plugin install vagrant-vbguest
}

vagrant_update_all_plugins() {
	for plugin in $(vagrant plugin list | cut -f1 -d' '); do
		vagrant plugin update "$plugin"
	done
}
