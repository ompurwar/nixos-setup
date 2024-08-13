{ modulesPath,pkgs, ... }: {
  imports = [ "${modulesPath}/virtualisation/amazon-image.nix" ];
  ec2.efi = true;
  system.stateVersion = "24.05";  # Set the appropriate version
  
   environment.systemPackages = with pkgs; [
    vim # adding vim editor
    htop # adding htop for monitoring
    neofetch
    bat
    cmatrix
    atuin
    ripgrep
    
   ];
  
}

