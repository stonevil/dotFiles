#!/usr/bin/env bash
# vim:ft=sh :

# Ruby gems
if command -v gem >/dev/null; then
	gems_update_all() {
		gem update "$(gem list | cut -d ' ' -f 1)"
		echo "All gems for current ruby updated"
	}
	gems_remove_all() {
		for x in $(gem list --no-versions); do gem uninstall "$x" -a -x -I; done
		echo "All gems for current updated"
	}
	gems_remove_old() { gem cleanup; }
	gems_list_local() { gem query --local; }
fi
