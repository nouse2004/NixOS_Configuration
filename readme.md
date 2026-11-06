# NixOS Configuration for Kang

English | [简体中文](readme.zh-CN.md)

Personal NixOS configuration using flakes and Home Manager, based on `nixos-unstable`. The active host is `laptop-ar8x` (`x86_64-linux`) and the user is `kang`.

## Desktop and applications

- Niri with DankMaterialShell (DMS) and the DMS greeter; XWayland support through `xwayland-satellite`.
- Fcitx5 input method and Matugen theme configuration.
- Fish, Starship, Kitty, development tools, and declarative Flatpak applications.
- PipeWire, NetworkManager, power-profiles-daemon, Podman, and libvirt.
- Optional Steam, GameMode, Gamescope, and Lutris support, controlled by `var.game`.
- SOPS/age integration for an encrypted GitHub SSH key.

## Repository layout

```text
flake.nix                 Flake inputs and NixOS output; integrates Home Manager
flake.lock                Pinned input revisions
var.nix                   Username, email, checkout path, architecture, host, gaming flag
hosts/laptop-ar8x/        Host configuration, hardware, and graphics settings
modules/                  System, desktop, applications, and gaming modules
users/kang/               Home Manager and NixOS user configuration
  desktop/                Niri, DMS settings, Fcitx5, Matugen, and XDG settings
  programs/               Browser, tools, Flatpak, and gaming applications
  shell/                  Fish, Starship, terminals, and command-line tools
secrets/                  SOPS modules and encrypted SSH key
.sops.yaml                age recipients and encryption rules
```

## Setup

This configuration targets a specific laptop. Review the hardware and account settings before applying it to another machine.

1. Clone the repository and set `username`, `useremail`, `sourcePath`, `system`, `hostName`, and `game` in `var.nix`. `sourcePath` must be the absolute path to this checkout.
2. Adapt `hosts/laptop-ar8x/` and `users/kang/` to your machine. If you rename the host or user, also update the directory names, host networking settings, and `secrets/<username>.nix`. Review filesystem UUIDs, graphics, swap, and boot settings in the hardware configuration.
3. Prepare the SOPS keys described below, or remove the corresponding secret imports if you do not need them.
4. Build and activate from the repository directory (replace `laptop-ar8x` if renamed):

```bash
nixos-rebuild build --flake .#laptop-ar8x
sudo nixos-rebuild switch --flake .#laptop-ar8x
```

Home Manager is integrated into the NixOS configuration and is applied by `nixos-rebuild`. This flake does not export a standalone `homeConfigurations.kang`; the existing `hms` alias therefore has no matching output.

Niri configuration files are linked directly from `var.sourcePath` using `mkOutOfStoreSymlink`. Keep the checkout at that location. The DMS settings snapshot is stored under `users/kang/desktop/dms-shell/`, but its Home Manager module is not currently imported by `desktop/default.nix`; that snapshot is not automatically linked on activation.

## Secrets

- `.sops.yaml` declares the age recipients used to encrypt files in `secrets/`.
- The Home Manager module reads `~/.config/sops/age/keys.txt` and decrypts `secrets/github_ssh_key.enc` to `~/.ssh/github` with mode `0600`.
- To use your own key, replace the recipients and re-encrypt your GitHub SSH private key as a SOPS binary file. Keep age private keys and plaintext SSH keys outside this repository.
- `secrets/default.nix` configures the system age key at `/var/lib/sops/key.txt` and a default secrets file at `${var.sourcePath}/secrets/secrets.yaml`. The YAML file is not included, and no system secrets are currently declared.
- `users/kang/shell/ssh.nix` is not imported by the shell module. Decrypting the key does not automatically configure an SSH host rule to select it.

## Maintenance

```bash
# Update all pinned inputs
nix flake update

# Update only nixpkgs
nix flake update nixpkgs

# Evaluate and check the flake
nix flake check
```

Rebuild after updating inputs. NixOS uses `system.stateVersion = "25.05"` and Home Manager uses `home.stateVersion = "25.11"`; these are compatibility settings, not package version selectors.

## Branches

- `master`: current Niri + DankMaterialShell configuration.
- `compose`: earlier desktop configuration using components such as Waybar, tofi, mako, swaylock-effects, and swayidle.

## Known issue

Clash Verge Rev can encounter a kernel communication error and freeze its GUI depending on startup timing.

## Reference

- Fcitx5 configuration attribution: <https://github.com/mnixry/nixos-config/blob/main/home/linux/fcitx5.nix>
