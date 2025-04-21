{pkgs, ...}: {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.aleks = {
        isNormalUser = true;
        description = "aleks";
        extraGroups = [ "networkmanager" "wheel"  "docker" ];
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.qubits = {
        isNormalUser = true;
        description = "qubits";
        extraGroups = [ "networkmanager" "wheel" ];
    };

}
