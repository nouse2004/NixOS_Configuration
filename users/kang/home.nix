{ config , pkgs , inputs , var, ...}:
{
	imports = [
		../common/core.nix
		../common/desktop
		../common/programs
		../common/shell
	];

	programs.git.settings = {
		user.name = var.username;
		user.email = "${var.useremail}";
	};
	
}
