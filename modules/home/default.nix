# A module that automatically imports everything else in the parent folder.
{flake, ...}: {
  imports = with builtins;
    [
      # Allows for hm apps to show up in MacOS spotlight
      flake.inputs.mac-app-util.homeManagerModules.default
    ]
    ++ map
    (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));
}
