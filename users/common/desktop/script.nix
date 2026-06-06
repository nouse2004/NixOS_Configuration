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
				notify_osd() {
					local app="$1" icon="$2" value="$3" summary="$4" body="$5"
					notify-send \
						-a "$app" \
						-h string:x-dunst-stack-tag:"$app" \
						-h int:value:"$value" \
						-h int:transient:1 \
						-i "$icon" \
						-t 1500 \
						"$summary" \
						"$body"
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
							notify_osd "osd-volume" "audio-volume-muted-symbolic" 0 "Volume" "<span size='14pt'>Muted  󰝟</span>"
						else
							if [ "$vol" -gt 66 ]; then
								notify_osd "osd-volume" "audio-volume-high-symbolic" "$vol" "Volume" "<span size='14pt'>''${vol}%  󰕾</span>"
							elif [ "$vol" -gt 33 ]; then
								notify_osd "osd-volume" "audio-volume-medium-symbolic" "$vol" "Volume" "<span size='14pt'>''${vol}%  󰖀</span>"
							else
								notify_osd "osd-volume" "audio-volume-low-symbolic" "$vol" "Volume" "<span size='14pt'>''${vol}%  󰕿</span>"
							fi
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
						if [ "$pct" -gt 85 ]; then
							notify_osd "osd-brightness" "display-brightness-symbolic" "$pct" "Brightness" "<span size='14pt'>''${pct}%  󰃠</span>"
						elif [ "$pct" -gt 71 ]; then
							notify_osd "osd-brightness" "display-brightness-symbolic" "$pct" "Brightness" "<span size='14pt'>''${pct}%  󰃟</span>"
						elif [ "$pct" -gt 57 ]; then
							notify_osd "osd-brightness" "display-brightness-symbolic" "$pct" "Brightness" "<span size='14pt'>''${pct}%  󰃞</span>"
						elif [ "$pct" -gt 42 ]; then
							notify_osd "osd-brightness" "display-brightness-symbolic" "$pct" "Brightness" "<span size='14pt'>''${pct}%  󰃝</span>"
						elif [ "$pct" -gt 28 ]; then
							notify_osd "osd-brightness" "display-brightness-symbolic" "$pct" "Brightness" "<span size='14pt'>''${pct}%  󰃜</span>"
						elif [ "$pct" -gt 14 ]; then
							notify_osd "osd-brightness" "display-brightness-symbolic" "$pct" "Brightness" "<span size='14pt'>''${pct}%  󰃛</span>"
						else
							notify_osd "osd-brightness" "display-brightness-symbolic" "$pct" "Brightness" "<span size='14pt'>''${pct}%  󰃚</span>"
						fi
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
							notify_osd "osd-mic" "microphone-sensitivity-muted-symbolic" 0 "Microphone" "<span size='14pt'>Muted  󰍭</span>"
						else
							notify_osd "osd-mic" "microphone-sensitivity-high-symbolic" 100 "Microphone" "<span size='14pt'>Unmuted  󰍬</span>"
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
