{ pkgs , pkgsMaster, monospace, lib, ... } :
let
	#kittyPkg = pkgsMaster.kitty;

	# 监视 nixos-unstable 的 kitty，超过阈值后提醒切回 unstable
	#warnNixpkgsKitty = threshold:
	#	lib.warnIf (lib.versionAtLeast pkgs.kitty.version threshold)
	#		"nixos-unstable 的 kitty ${pkgs.kitty.version} 已 ≥ ${threshold}，可换回 pkgs.kitty 不用追 master";
in
{
	programs.kitty = {
		enable = true;
	#	package = warnNixpkgsKitty "0.47.2" kittyPkg;
		settings = {	
		};
	};
}
