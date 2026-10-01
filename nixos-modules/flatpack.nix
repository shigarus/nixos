{ config, pkgs, inputs, ... }:
{
  # systemd.services.flatpak-repo = {
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.flatpak ];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };
  # services.flatpak = {
  #   enable = true;
  #   remotes = [
  #     {
  #       name = "flathub";
  #       location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  #     }
  #   ];
  #   package = [
  #     "app.zen_browser.zen"
  #     "com.github.tchx84.Flatseal"
  #   ];
  # };
}
