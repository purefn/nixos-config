{ pkgs, config, ... }:

{
  services = {
    xserver = {
      synaptics.enable = true;
    };
    
    logind.extraConfig = ''
      HandleLidSwitch=suspend
      HandleSuspendKey=suspend
      LidSwitchIgnoreInhibited=yes
    '';

    upower.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
    ];
  };
}
