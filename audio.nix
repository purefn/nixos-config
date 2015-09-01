{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    # paman
    paprefs
    pasystray
    pavucontrol
    # pavumeter
  ];

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull.override {
      # useSystemd = true;
      # avahi = pkgs.avahi;
      # bluez = pkgs.bluez;
    };
  };

  sound.enableOSSEmulation = false;

  environment.etc.xbindkeysrc.text = ''
    "${pkgs.pamixer}/bin/pamixer --increase 5"
      XF86AudioRaiseVolume

    "${pkgs.pamixer}/bin/pamixer --decrease 5"
      XF86AudioLowerVolume

    "${pkgs.pamixer}/bin/pamixer --toggle-mute"
      XF86AudioMute
  '';
}
