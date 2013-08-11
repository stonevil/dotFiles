# Print running VMware Fusion VM

TMUX_POWERLINE_SEG_VM_TYPE_DEFAULT="vmware_fusion"
TMUX_POWERLINE_SEG_VMWARE_FUSION_CLI_DEFAULT="/Applications/VMware Fusion.app/Contents/Library/vmrun"
TMUX_POWERLINE_SEG_VIRTUAL_BOX_CLI_DEFAULT="/usr/bin/VBoxManage"

__process_settings() {
	if [ -z "$TMUX_POWERLINE_SEG_VM_TYPE" ]; then
		export TMUX_POWERLINE_SEG_VM_TYPE="${TMUX_POWERLINE_SEG_VM_TYPE_DEFAULT}"
	fi

	if [ -z "$TMUX_POWERLINE_SEG_VMWARE_FUSION_CLI" ]; then
		export TMUX_POWERLINE_SEG_VMWARE_FUSION_CLI="${TMUX_POWERLINE_SEG_VMWARE_FUSION_CLI_DEFAULT}"
	fi

	if [ -z "$TMUX_POWERLINE_SEG_VIRTUAL_BOX_CLI" ]; then
		export TMUX_POWERLINE_SEG_VIRTUAL_BOX_CLI="${TMUX_POWERLINE_SEG_VIRTUAL_BOX_CLI_DEFAULT}"
	fi
}

run_segment() {
	__process_settings

	if [ -z "$TMUX_POWERLINE_SEG_VM_TYPE" ]; then
		return 2
	fi

	local count
	case "$TMUX_POWERLINE_SEG_VM_TYPE" in
		"vmware_fusion")  count=$(__count_vmware_fusion) ;;
		"virtual_box")  count=$(__virtual_box) ;;
		*)
			echo "Unknown VM Engine type [${TMUX_POWERLINE_SEG_VM_TYPE}]";
			return 1
	esac
	local exitcode="$?"
	if [ "$exitcode" -ne 0 ]; then
		return $exitcode
	fi

	if [[ -n "$count"  && "$count" -gt 0 ]]; then
    echo "⧉ ${count}"
	fi

	return 0
}

__count_vmware_fusion() {
  count=$("$TMUX_POWERLINE_SEG_VMWARE_FUSION_CLI" -T fusion list | awk 'NR==1{print $4}')
  echo "$count"
  return 0;
}

__count_virtual_box() {
  count=$("$TMUX_POWERLINE_SEG_VIRTUAL_BOX_CLI" list runningvms | wc -l )
  echo "$count"
  return 0;
}
