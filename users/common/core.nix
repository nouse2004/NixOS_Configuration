# Kang
# May,20,2026

{ var , ... } : let 
	username = var.username;
in {
	home = {
		inherit username;
		homeDirectory = "/home/${username}";
		stateVersion = "25.11";
	};	

	programs.home-manager.enable = true;
}
