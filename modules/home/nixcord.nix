{flake, ...}: {
  imports = [
    flake.inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;

    config = {
      frameless = true;

      plugins = {
        fakeNitro.enable = true;
        mentionAvatars.enable = true;
        typingTweaks.enable = true;
        whoReacted.enable = true;
      };
    };

    discord.enable = true;
    dorion.enable = false;
    vesktop.enable = false;

    extraConfig = {
      enableSplashScreen = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
    };
  };
}
