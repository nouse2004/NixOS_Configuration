{pkgs , var , ... }:{
	# Kang
	# May,20,2026
	users.users.${var.username} =
	{
		isNormalUser = true;
		shell = pkgs.fish;
		extraGroups = [ "wheel" "networkmanager" "podman" "plugdev" "libvirtd" "input" ];
		subUidRanges = [{startUid = 100000; count = 65536;}];
		subGidRanges = [{startGid = 100000; count = 65536;}];
	};



}
