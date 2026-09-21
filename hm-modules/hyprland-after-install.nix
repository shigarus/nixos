{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprls
  ];
  systemd.user.services.hyprland-single-monitor = {
    Unit = {
      Description = "Disables first monitor when adding second.";
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "hyprland-single-monitor" ''
        #!/bin/sh
		check_monitors() {
			# Count connected monitors using hyprctl JSON output
			count=$(hyprctl monitors -j | jq length)
			
			# Adjust 'eDP-1' to your built-in monitor name
			if [ "$count" -gt 1 ]; then
				hyprctl dispatch 'hl.dsp.dpms({action="disable", monitor="eDP-1"})'
			else
				hyprctl dispatch 'hl.dsp.dpms({action="enable", monitor="eDP-1"})'
			fi
      hyprctl dispatch 'hl.dsp.workspace.swap_monitors({monitor1="eDP-1",monitor2= "DP-2"})'
		}

		# Run once at startup
		check_monitors

		handle() {
		  case $1 in
			monitoradded* | monitorremoved* ) check_monitors ;;
		  esac
		}

		socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
      ''}";
    };
  };
}
