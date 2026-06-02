{ pkgs, ... }: {
	home.packages = [
		(pkgs.writeShellScriptBin "kitty_popup" ''
			exec ${pkgs.kitty}/bin/kitty --class kitty_popup \
				--override "remember_window_size=no" \
				--override "initial_window_width=800" \
				--override "initial_window_height=520" \
				"$@"
		'')
		(pkgs.writeShellApplication {
			name = "osd";
			runtimeInputs = with pkgs; [ pipewire brightnessctl libnotify ];
			text = ''
				set -euo pipefail

				notify_osd() {
					local app="$1" icon="$2" value="$3" summary="$4" body="$5"
					notify-send \
						-a "$app" \
						-h int:value:"$value" \
						-h int:transient:1 \
						-i "$icon" \
						-t 1500 \
						"$summary" \
						"$body"
				}

				mk_bar() {
					local pct=$1 len=10
					local filled=$((pct * len / 100))
					local bar=""
					for i in 1 2 3 4 5 6 7 8 9 10; do
						[ "$i" -le "$((filled))" ] && bar="''${bar}━" || bar="''${bar}─"
					done
					echo "$bar ''${pct}%"
				}

				case "''${1:-}" in
					volume)
						sink="@DEFAULT_AUDIO_SINK@"
						step="''${3:-0.05}"

						case "''${2:-}" in
							up)
								wpctl set-volume "$sink" "''${step}+" -l 1.0
								;;
							down)
								wpctl set-volume "$sink" "''${step}-"
								;;
							mute)
								wpctl set-mute "$sink" toggle
								;;
							*)
								echo "Usage: osd volume {up|down|mute} [step]"
								exit 1
								;;
						esac

						raw=$(wpctl get-volume "$sink")
						vol=$(echo "$raw" | awk '{printf "%.0f", $2 * 100}')
						muted=$(echo "$raw" | grep -c "MUTED" || true)

						if [ "$muted" -gt 0 ]; then
							notify_osd "osd-volume" "audio-volume-muted" 0 "Volume" "Muted"
						else
							if [ "$vol" -gt 66 ]; then icon="audio-volume-high"
							elif [ "$vol" -gt 33 ]; then icon="audio-volume-medium"
							else icon="audio-volume-low"; fi
							notify_osd "osd-volume" "$icon" "$vol" "Volume" "$(mk_bar "$vol")"
						fi
						;;

				brightness)
					case "''${2:-}" in
							up)
								brightnessctl --class=backlight set "+10%"
								;;
							down)
								brightnessctl --class=backlight set "10%-"
								;;
							*)
								echo "Usage: osd brightness {up|down} [device]"
								exit 1
								;;
						esac

						val=$(brightnessctl --class=backlight get 2>/dev/null)
						max=$(brightnessctl --class=backlight max 2>/dev/null)
						pct=$((val * 100 / max))
						notify_osd "osd-brightness" "display-brightness" "$pct" "Brightness" "$(mk_bar "$pct")"
						;;

					mic)
						case "''${2:-}" in
							mute)
								wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
								;;
							*)
								echo "Usage: osd mic mute"
								exit 1
								;;
						esac

						raw=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
						muted=$(echo "$raw" | grep -c "MUTED" || true)

						if [ "$muted" -gt 0 ]; then
							notify_osd "osd-mic" "microphone-sensitivity-muted" 0 "Microphone" "Muted"
						else
							notify_osd "osd-mic" "microphone-sensitivity-high" 100 "Microphone" "Unmuted"
						fi
						;;

					*)
						echo "Usage: osd {volume|brightness|mic} ..."
						exit 1
						;;
				esac
			'';
		})
	];
}
