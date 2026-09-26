# Home-manager for non-nix

``` bash
#
if ! command -v pacman >/dev/null 2>&1
then
    echo "this is not arch, install nix some other way."
    exit 1
fi
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

# Arch

## Docker 
'''bash
sudo pacman -Syu docker
'''

If docker service fails with `overlay2.override_kernel_ check: overlay2` - you need to delete this option from /etc/docker/daemon.json
'''
	  "storage-opts": [
		"overlay2.override_kernel_check=true"
	  ]
'''

## Power button behaviour

'''bash
printf '%s\n' \
  'HandlePowerKey=suspend' \
  'HandlePowerKeyLongPress=poweroff' |
sudo tee -a /etc/systemd/logind.conf >/dev/null
'''
Will work only after reboot.

## tailscale
TODO: Already was installed when this doc is written, add later
