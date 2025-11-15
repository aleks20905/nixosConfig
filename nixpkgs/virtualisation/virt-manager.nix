{config, pkgs, lib, ...}: {

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = ["aleks"];

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;

}
