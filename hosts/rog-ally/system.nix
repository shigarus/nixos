{ inputs, pkgs, ... }:
{
  # inspiration https://github.com/Misterio77/Foundry/blob/main/home/gabriel/electra.nix
  nixpkgs.hostPlatform = "x86_64-linux";

  # Userborn creates the user on activation.
  services.userborn.enable = true;

  # Required so home-manager can invoke nix-store/nix-build
  # during activation.
  nix.enable = true;

  # users.groups.shigarus.gid = 5000;
  users = {
	mutableUsers = false;
	users.shigarus = {
		isNormalUser = true;
		# uid = 5000;
		# group = "alice";
		# home = "/home/alice";
		createHome = false;
	};
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      shigarus = import ./home.nix;
    };
  };
}
