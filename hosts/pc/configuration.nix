# sudo nixos-rebuild switch  --flake  /home/aleks/Desktop/nixos#default
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  imports = [ 
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users ={
      "aleks"  = import ./home.nix;
    };
  };
   
  # Disable X11 if not needed
  # services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    # konsole
    oxygen
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aleks = {
    isNormalUser = true;
    description = "aleks";
    extraGroups = [ "networkmanager" "wheel" ];
    # packages = with pkgs; [
    #   firefox
    #   kdePackages.kate
    # #  thunderbird
    # ];
  };

   

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  hardware.bluetooth.enable = true;

  # nix Garbage colection - atomatily to delete garbage when they are <value> days or etc ...  
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 30d";
  # };
  
  # addes partition manager 
  # programs.partition-manager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?


}
