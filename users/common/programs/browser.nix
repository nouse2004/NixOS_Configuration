{ ... }: {
	programs.firefox = {
		enable = true;
		profiles.default = {
			id = 0;
			name = "default";
			path = "hrmcqcqm.default";
			isDefault = true;
		};
	};
}
