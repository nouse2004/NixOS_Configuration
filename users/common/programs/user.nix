{ config, pkgs, ... }:
let
distroboxArchScript = pkgs.writeShellScriptBin "distrobox-arch" ''
    set -e

    CONTAINER_NAME="arch"
    DISTROBOX_CMD="${pkgs.distrobox}/bin/distrobox"

    if ! $_DISTROBOX_CMD list | grep -q "^$CONTAINER_NAME$"; then
      echo "Container '$CONTAINER_NAME' not found."
      read -p "Create an Arch Linux container? [y/N]: " answer
      case "$answer" in
        [yY]|[yY][eE][sS])
          echo "Creating container '$CONTAINER_NAME' ..."
          $_DISTROBOX_CMD create --name "$CONTAINER_NAME" --image archlinux:latest
          ;;
        *)
          echo "Aborted."
          exit 1
          ;;
      esac
    fi

    echo "Entering container '$CONTAINER_NAME' ..."
    exec $_DISTROBOX_CMD enter "$CONTAINER_NAME"
  '';
in
{
  home.packages = [ distroboxArchScript ];

  xdg.desktopEntries = {
    arch = {
      name = "Arch";
      genericName = "Distrobox ArchLinux";
    };
  };
}
