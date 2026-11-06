# Kang 的 NixOS 配置

[English](README.md) | 简体中文

面向 **LENOVO LEGION AR8X**，基于 `nixos-unstable`，使用 Flakes 和 Home Manager 管理的个人 NixOS 配置。当前主机为 `laptop-ar8x`（`x86_64-linux`），用户为 `kang`。

## 桌面与应用

- 使用 Niri、DankMaterialShell（DMS）和 DMS 登录界面，通过 `xwayland-satellite` 支持 XWayland 应用。
- 配置 Fcitx5 输入法和 Matugen 主题。
- 提供 Fish、Starship、Kitty、开发工具及声明式 Flatpak 应用配置。
- 启用 PipeWire、NetworkManager、power-profiles-daemon、Podman 和 libvirt。
- 通过 `var.game` 控制 Steam、GameMode、Gamescope 和 Lutris 游戏支持。
- 集成 SOPS/age，管理加密的 GitHub SSH 密钥。

## 目录结构

```text
flake.nix                 Flake 输入和 NixOS 输出，集成 Home Manager
flake.lock                锁定的依赖版本
var.nix                   用户名、邮箱、仓库路径、架构、主机名和游戏开关
hosts/laptop-ar8x/        主机配置、硬件配置和显卡设置
modules/                  系统、桌面、应用和游戏模块
users/kang/               Home Manager 和 NixOS 用户配置
  desktop/                Niri、DMS 设置、Fcitx5、Matugen 和 XDG 设置
  programs/               浏览器、工具、Flatpak 和游戏应用
  shell/                  Fish、Starship、终端和命令行工具
secrets/                  SOPS 模块与加密的 SSH 密钥
.sops.yaml                age 接收者与加密规则
```

## 部署

本套配置面向 LENOVO LEGION AR8X。在其他机器上应用前，需要调整硬件和账户设置。

1. 克隆仓库，在 `var.nix` 中设置 `username`、`useremail`、`sourcePath`、`system`、`hostName` 和 `game`。其中 `sourcePath` 必须是本地仓库的绝对路径。
2. 按照实际硬件调整 `hosts/laptop-ar8x/` 和 `users/kang/`。如果修改主机名或用户名，还需同步调整目录名、主机网络设置以及 `secrets/<username>.nix`。检查硬件配置中的文件系统 UUID、显卡、交换空间和引导设置。
3. 按下文准备 SOPS 密钥；如果不需要密钥管理，移除对应的模块导入。
4. 在仓库目录中构建并应用配置；若已修改主机名，请替换命令中的 `laptop-ar8x`：

```bash
nixos-rebuild build --flake .#laptop-ar8x
sudo nixos-rebuild switch --flake .#laptop-ar8x
```

Home Manager 已集成到 NixOS 配置中，随 `nixos-rebuild` 一并应用。当前 Flake 没有导出独立的 `homeConfigurations.kang`，因此现有的 `hms` 别名没有对应的输出。

Niri 配置和 DMS 设置通过 `mkOutOfStoreSymlink` 直接链接到 `var.sourcePath` 下的文件，请保留该路径的仓库。桌面模块已导入 `dms-shell`，将 `users/kang/desktop/dms-shell/DankMaterialShell/settings.json` 链接到 `~/.config/DankMaterialShell/settings.json`。DMS 通过该链接保存设置时，也会修改仓库中的文件，提交前请检查差异。

## DMS 设置

仓库中的设置使用 `configVersion = 18`，配置了以下内容：

- 动态主题、模糊效果、Papirus 浅色与深色图标、Noto Sans 和 JetBrainsMono Nerd Font 字体。
- 状态栏左侧显示启动器、时钟、天气和音乐，中间显示工作区，右侧显示系统托盘、内存占用、控制中心和通知。
- 启动时锁屏、挂起前锁屏、电池自动省电，以及分别针对外接电源和电池供电的空闲策略。
- 电源菜单包含休眠和切换用户，默认操作为锁屏。

亮度组件指定的设备为 `ddc:i2c-9`。更换显示设备后，请在 DMS 中调整该设置。登录界面的 PAM 栈在 `modules/desktop.nix` 中配置。

## 密钥管理

- `.sops.yaml` 定义 `secrets/` 中各文件使用的 age 接收者。
- Home Manager 模块读取 `~/.config/sops/age/keys.txt`，将 `secrets/github_ssh_key.enc` 解密到 `~/.ssh/github`，权限为 `0600`。
- 使用自己的密钥时，请替换接收者，并以 SOPS 二进制格式重新加密自己的 GitHub SSH 私钥。age 私钥和明文 SSH 私钥应保存在仓库之外。
- `secrets/default.nix` 将系统 age 私钥路径设为 `/var/lib/sops/key.txt`，默认密钥文件设为 `${var.sourcePath}/secrets/secrets.yaml`。仓库未包含该 YAML 文件，目前也未声明系统级 secret。
- shell 模块已导入 `users/kang/shell/ssh.nix`，为 `github.com` 设置用户 `git`，并选择由 SOPS 管理的 `~/.ssh/github` 身份文件。

## 日常维护

```bash
# 更新所有锁定的依赖
nix flake update

# 仅更新 nixpkgs
nix flake update nixpkgs

# 求值并检查 Flake
nix flake check
```

更新依赖后重新构建系统。NixOS 的 `system.stateVersion` 为 `25.05`，Home Manager 的 `home.stateVersion` 为 `25.11`；这些值用于兼容性设置，不用于选择软件包版本。

## 分支说明

- `master`：当前使用 Niri + DankMaterialShell 的配置。
- `compose`：早期桌面配置，使用 Waybar、tofi、mako、swaylock-effects 和 swayidle 等组件。

## 参考

- Fcitx5 配置参考：<https://github.com/mnixry/nixos-config/blob/main/home/linux/fcitx5.nix>
