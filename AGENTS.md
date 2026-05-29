# AGENTS.md — nixos-config

## Architecture

- **`flake.nix`** — entrypoint. Defines one host `laptop-ar8x`. Imports `var.nix` for variables.
- **`var.nix`** — central vars: `username`, `useremail`, `sourcePath`, `system`.
- **`hosts/laptop-ar8x/`** — per-machine config. `default.nix` imports `../../modules/*` + `hardware-configuration.nix`.
- **`modules/`** — shared NixOS modules: `system.nix` (global system settings), `dm.nix` (greetd + niri), `programs.nix` (clash-verge).
- **`users/`** — Home Manager configs: `kang/` is the active user (matches `var.username`). `default/` is unused. `common/` holds shared HM modules (core, desktop, programs, shell).
- Desktop stack: **niri** (compositor) + **greetd** (login) + **waybar** + **tofi** (launcher) + **mako** (notifications) + **matugen** (theme gen) + **fcitx5** (IME) + **cliphist** (clipboard).

## Commands

### Build & switch
```bash
sudo nixos-rebuild switch --flake .#laptop-ar8x
nixos-rebuild build --flake .#laptop-ar8x
```

### Update inputs
```bash
nix flake update
nix flake update nixpkgs
```

### Test home-manager
```bash
home-manager switch --flake .#kang
```

## Quirks & Gotchas

### State / versioning
- **Nixpkgs channel**: uses `nixos-unstable`, not stable.
- **State versions differ**: NixOS = `25.05`, Home Manager = `25.11`. This is intentional (different release cadences).

### Editing pitfalls
- **`users/default/` is dead code**: `kang/` is the real profile. Edit `users/kang/`, not `users/default/`.
- **Regenerating hardware config** (`nixos-generate-config`) overwrites `hardware-configuration.nix`. Manual additions (NVIDIA, bluetooth, zram, swapfile) live in the same file and would be lost.

### Style conventions
- **Tab indentation** throughout (not standard Nix 2-space indent). Match existing style.
- **.swp / .swo vim swap files** are accidentally tracked in git. Do not commit them; `gitignore` them if you touch version control.
- No CI, no formatter, no tests. Commit directly to master.

### Environment
- **Chinese binary mirrors** configured in `modules/system.nix` (TUNA + SJTU). These may be slow outside China.
