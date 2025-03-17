{config, pkgs, lib, ...}: {
	imports = [ 


        ../../nixpkgs/fonts
        ../../nixpkgs/gaming
        # ../../nixpkgs/penTools
        ../../nixpkgs/programming
        ../../nixpkgs/shells
        # ../../nixpkgs/virtualisation



	];

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["aleks"];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

} 
 
