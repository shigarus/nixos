# Home-manager only on nix

``` bash
sudo pacman -S nix
sudo systemctl enable nix-daemon
sudo systemctl start nix-daemon
## seems not needed as such group does not exists and everything works without
# sudo gpasswd -a <user> nix-users
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf

home-manager switch --flake .#rog-ally
```

# System-manager
```bash
nix run 'github:numtide/system-manager' -- switch --flake .#rog-ally --sudo
```
