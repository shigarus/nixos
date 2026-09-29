{ config, pkgs, inputs, ... }:
{
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "app.zen_browser.zen"
      "com.github.tchx84.Flatseal"
    ];
  };
}
