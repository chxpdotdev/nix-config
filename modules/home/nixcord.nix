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

    discord.enable = false;
    dorion.enable = false;
    vesktop.enable = true;

    extraConfig = {
      enableSplashScreen = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
    };
  };
}
