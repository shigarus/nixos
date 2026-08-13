{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pi.url = "github:lukasl-dev/pi.nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        # let
        # system = "x86_64-linux";
        # pkgs = import nixpkgs {inherit system; config.allowUnfree = true; };
        # in
        # I need to use `let` defined above somehow and not pass nixpkgs via specialArgs
        # instead pkgs should be passed directly.
        # It is connected to a fact that unfree can be set only in initial execution
        # and with current constructio nixpkgs get executed for home-manager before calling that function
        # so I have no options install unfree there.
        # Probably should look into nixpkgs.lig.nixosSyste function signrature to understand how to pass the thing.
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
