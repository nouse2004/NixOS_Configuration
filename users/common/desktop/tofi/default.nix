{ config , pkgs , ... } : 
{
	programs.tofi.enable = true;
	imports = [
		./tofi-drun.nix
		./tofi-powermenu.nix
		./tofi-clipboard.nix
	];	
}
