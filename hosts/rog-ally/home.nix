{ inputs, config, pkgs, ... }:

{
  targets.genericLinux.enable = true;
  imports = [
    ../../hm-modules/desktop.nix
    ../../hm-modules/generic.nix
    ../../hm-modules/fish.nix
    ../../hm-modules/gui.nix
    ../../hm-modules/programmin.nix
    ../../hm-modules/ai.nix
  ];

  home.packages = with pkgs; [
    # teamcity-cli not in nexpkgs
    tailscale
  ];
}
