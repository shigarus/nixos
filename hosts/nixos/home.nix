{ inputs, config, pkgs, ... }:

{
  imports = [
    ../../hm-modules/desktop.nix
    ../../hm-modules/generic.nix
    ../../hm-modules/gui.nix
    ../../hm-modules/programmin.nix
    ../../hm-modules/ai.nix
  ];
  home.packages = with pkgs; [
    tailscale
  ];
}
