{ config , pkgs , inputs , ...} : {
	imports = [
		inputs.nix-flatpak.homeManagerModules.nix-flatpak
	];

	services.flatpak = {
		enable = true;
		
		remotes = [
			{
				name = "flathub";
				location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
			}
		];

		packages = [
			"com.qq.QQ"
			"com.zettlr.Zettlr"	
			"com.obsproject.Studio"
			"org.libreoffice.LibreOffice"
		];
	};
}
