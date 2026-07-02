{ pkgs, ... }:

let
  critTimer = 60;
  execCrit = "systemctl hibernate";

  battery-monitor = pkgs.writeShellApplication {
    name = "battery-monitor";
    runtimeInputs = with pkgs; [ libnotify systemd upower ];
    text = ''
      CRIT_TIMER=${toString critTimer}
      EXEC_CRIT="${execCrit}"

      BAT_PATH=""
      WAS_CRIT=false
      WAS_LOW=false
      WAS_DISCHARGING=false

      find_bat() { BAT_PATH=$(upower -e | grep battery | head -n 1); }

      bus_get() { busctl get-property org.freedesktop.UPower "$BAT_PATH" org.freedesktop.UPower.Device "$1"; }

      get_warning_level() {
        local v; v=$(bus_get WarningLevel)
        v="''${v#u }"; echo "$v"
      }

      is_low()    { [[ $(get_warning_level) -ge 3 ]]; }
      is_critical() { [[ $(get_warning_level) -ge 4 ]]; }

      get_pct() {
        local v; v=$(bus_get Percentage)
        v="''${v#d }"; v="''${v%.*}"; echo "$v"
      }

      is_discharging() { [[ "$(bus_get State)" == "u 2" ]]; }

      critical_cb() {
        local count=$CRIT_TIMER
        while (( count > 0 )); do
          if ! is_critical; then
            notify-send -a "battery" -h string:x-dunst-stack-tag:critical -t 3000 "Action Aborted" "Charger detected, system will stay awake."
            return
          fi
          local pct; pct=$(get_pct)
          notify-send -a "battery" -h string:x-dunst-stack-tag:critical -t 1100 -u CRITICAL -i battery-empty \
            "Critical Battery: ''${pct}%" \
            "Action in ''${count}s. Please connect charger immediately!"
          sleep 1
          ((count--))
        done
        is_critical && eval "$EXEC_CRIT"
      }

      react() {
        local crit low pct
        crit=$(is_critical && echo true || echo false)
        low=$(is_low && echo true || echo false)
        pct=$(get_pct)

        if is_discharging && ! $WAS_DISCHARGING; then
          notify-send -a "battery" -h string:x-dunst-stack-tag:power -t 5000 -u NORMAL -i battery-missing \
            "Charger Disconnected" "Battery at ''${pct}%"
        elif ! is_discharging && $WAS_DISCHARGING; then
          notify-send -a "battery" -h string:x-dunst-stack-tag:power -t 5000 -u NORMAL -i battery-charging \
            "Charger Connected" "Battery at ''${pct}%"
        fi
        WAS_DISCHARGING=$(is_discharging && echo true || echo false)

        if [[ "$crit" == false && "$low" == false ]] && ($WAS_CRIT || $WAS_LOW); then
          notify-send -a "battery" -h string:x-dunst-stack-tag:power -t 3000 -u NORMAL -i battery-charging \
            "Battery Restored" "Now at ''${pct}%"
        fi

        $crit && $WAS_CRIT && return

        if $crit; then
          WAS_CRIT=true
          WAS_LOW=true
          critical_cb
          return
        fi

        if $low && ! $WAS_LOW; then
          notify-send -a "battery" -h string:x-dunst-stack-tag:low -t 5000 -u CRITICAL -i battery-low \
            "Battery Low" "Only ''${pct}% remaining. Connect charger soon."
        fi

        WAS_CRIT=false
        WAS_LOW=$low
      }

      main() {
        find_bat; [ -z "$BAT_PATH" ] && { echo "Battery not found."; exit 1; }

        WAS_CRIT=$(is_critical && echo true || echo false)
        WAS_LOW=$(is_low && echo true || echo false)
        WAS_DISCHARGING=$(is_discharging && echo true || echo false)

        react

        exec dbus-monitor --system "type='signal',interface='org.freedesktop.DBus.Properties',path='$BAT_PATH'" 2>/dev/null | \
          while read -r _; do react; done
      }

      main
    '';
  };
in {
  home.packages = [ battery-monitor ];

  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Battery level monitor (D-Bus driven)";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${battery-monitor}/bin/battery-monitor";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
