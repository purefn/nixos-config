# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./audio.nix
      ./desktop.nix
      ./laptop.nix
      ./networking.nix
      ./services.nix
    ];

  nix = {
    extraOptions = "auto-optimise-store = true";
    trustedBinaryCaches = [
      "https://hydra.nixos.org"
      "http://zalora-public-nix-cache.s3-website-ap-southeast-1.amazonaws.com/"
    ];
    binaryCaches = [
      # "https://ryantrinkle.com:5443/"
      # "http://hydra.cryp.to"
      "https://cache.nixos.org"
    ];
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # -env -qaP | grep wget
  environment = {
    systemPackages = with pkgs; [
      # basics
      aspell
      aspellDicts.en
      bashCompletion
      gnupg
      neovim
      nix-repl
      nox
      psmisc
      s3cmd
      unzip
      vimHugeX
      which # otherwise it's not available from /bin/sh
      zip

      # browsers
      chromium
      #firefox
  
      # apps
      deluge
      gimp
      gnome3.eog
      gnome3.evince
      gnome3.file-roller
      gnome3.gnome_keyring
      # gnote
      handbrake
      hipchat
      mediatomb
      mplayer
      # pithos
      # shutter
      sshfsFuse
      #steam
      wireshark

      # general dev
      ctags
      darcs
      git
      gnumake

      # haskell dev
      haskellngPackages.cabal2nix
      # haskellngPackages.codex
      haskellngPackages.hasktags
      haskellngPackages.hlint
      haskellngPackages.hscope
      haskellngPackages.packunused
      haskellngPackages.pointful
      haskellngPackages.pointfree

      # scala dev
      scala
      sbt

      # java dev
      jdk
      maven

      # javascript dev
      # haskellngPackages.purescript  <-- currently marked broken
      nodejs

      # virtual machines
      vagrant
    ];

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
    
    variables.EDITOR = pkgs.lib.mkForce "nvim";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.rwallace = {
    name = "rwallace";
    group = "users";
    extraGroups = [ "audio" "disk" "libvirtd" "networkmanager" "systemd-journal" "vboxusers" "video" "wheel" ];
    uid = 1000;
    createHome = true;
    home = "/home/rwallace";
    shell = "/run/current-system/sw/bin/bash";
  };

  programs.bash.enableCompletion = true;

  time.timeZone = "US/Arizona";

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
     #enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works 
     enablePepperPDF = true;
    };

    firefox = {
     #enableGoogleTalkPlugin = true;
     #enableAdobeFlash = true;
    };

    MPlayer = {
      pulseSupport = true;
    };

    /*
    packageOverrides = pkgs: {
      jdk = pkgs.oraclejdk8;
      jre = pkgs.oraclejdk8;
    };
    */
  };
}
