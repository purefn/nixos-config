{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome3.networkmanagerapplet
    # gnome3.networkmanager_openconnect
    # gnome3.networkmanager_openvpn
  ];
  
  networking = {
    hostName = "tealc"; # Define your hostname.
    extraHosts = ''
      192.168.0.10 ronin
      192.168.0.4 tealc
      68.3.236.160 habitat
    '';
    networkmanager.enable = true;
  };
}
