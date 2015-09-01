{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dmenu
    haskellPackages.ghc
    taffybar
    notify-osd
    rxvt_unicode
    xcompmgr
    xscreensaver
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "compose:ralt";

    windowManager = {
      xmonad = {
        enable = true;     # installs xmonad and makes it available
        enableContribAndExtras = true; # makes xmonad-contrib and xmonad-extras available
        extraPackages = haskellPackages: [ haskellPackages.taffybar ];
      };
      default = "xmonad"; # sets it as default
    };

    desktopManager = {
      xterm.enable = false;
      default = "none";   # the plain xmonad experience
    };

    displayManager = {
      slim = {
        defaultUser = "rwallace";
        theme = pkgs.fetchurl {
          url = "https://github.com/jagajaga/nixos-slim-theme/archive/1.1.tar.gz";
          sha256 = "0cawq38l8rcgd35vpdx3i1wbs3wrkcrng1c9qch0l4qncw505hv6";
        };
      };
      desktopManagerHandlesLidAndPower = false;
      sessionCommands = ''
        ${pkgs.xlibs.xmodmap}/bin/xmodmap ~/.Xmodmap
        ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr
        ${pkgs.xbindkeys}/bin/xbindkeys -f /etc/xbindkeysrc
        ${pkgs.xscreensaver}/bin/xscreensaver -no-splash &
        ${pkgs.rxvt_unicode}/bin/urxvtd -q -o -f
        ${pkgs.xcompmgr}/bin/xcompmgr -n &
        ${pkgs.taffybar}/bin/taffybar &
        ${pkgs.gnome3.networkmanagerapplet}/bin/nm-applet &
        ${pkgs.pasystray}/bin/pasystray &
        export GTK_IM_MODULE="xim"
      '';
    };

    videoDrivers = [ "nvidia" ];
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
    ];
  };

  environment.etc."fonts/local.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <match target="font">
        <edit name="antialias" mode="assign">
          <bool>true</bool>
        </edit>
      </match>
      <match target="font">
        <edit name="hinting" mode="assign">
          <bool>true</bool>
        </edit>
      </match>
       <match target="font">
        <edit name="hintstyle" mode="assign">
          <const>hintslight</const>
        </edit>
      </match>
      <match target="font">
        <edit name="rgba" mode="assign">
          <const>rgb</const>
        </edit>
      </match>
      <match target="font">
        <edit mode="assign" name="lcdfilter">
          <const>lcddefault</const>
        </edit>
      </match>
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>DejaVu Sans</family>
        </prefer>
      </alias>
      <alias>
        <family>serif</family>
        <prefer>
          <family>DejaVu Serif</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>DejaVu Mono</family>
        </prefer>
      </alias>
    </fontconfig>
  '';
}
