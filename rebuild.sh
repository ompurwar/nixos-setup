#!/bin/bash
set -e

# Navigate to the NixOS configuration directory
pushd /etc/nixos/ > /dev/null

# Edit the NixOS configuration file
nvim ./configuration.nix

# Format Nix files using Alejandra
alejandra . &>/dev/null

# Display git diff with minimal context for *.nix files
git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

# Rebuild the NixOS configuration and log the output
if ! sudo nixos-rebuild switch &> nixos-switch.log; then
    echo "Error during nixos-rebuild. Check nixos-switch.log for details."
    grep --color=auto error nixos-switch.log || true
    false
fi

# Get the current generation after the rebuild
gen=$(nixos-rebuild list-generations | grep current)

# Commit the changes with the generation info as the commit message
git commit -am "Rebuild: $gen"

# Return to the previous directory
popd > /dev/null

