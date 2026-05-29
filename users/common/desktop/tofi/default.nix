{ config , pkgs , ... } : 
{
	programs.tofi.enable = true;
	imports = [
		./tofi-drun.nix
	];	
}
