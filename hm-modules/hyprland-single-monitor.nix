{ config, pkgs, ... }:
{
  systemd.user.services.hyprland-single-monitor = {
    Unit = {
      Description = "Disables first monitor when adding second.";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "hyprland-single-monitor" ''
        #!/run/current-system/sw/bin/bash
		check_monitors() {
			# Count connected monitors using hyprctl JSON output
			count=$(hyprctl monitors -j | jq length)
			
			# Adjust 'eDP-1' to your built-in monitor name
			if [ "$count" -gt 1 ]; then
				hyprctl keyword monitor "eDP-1, disable"
			else
				hyprctl keyword monitor "eDP-1, preferred, auto, 1"
			fi
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
