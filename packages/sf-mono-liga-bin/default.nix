{
  inputs,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "SFMono-Nerd-Font-Ligaturized";
  src = inputs.sf-mono-liga-bin-src;
  version = "999-master";
  dontConfigue = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -R $src/*.otf $out/share/fonts/opentype
  '';

  meta = {description = "Apple's SFMono font nerd-font patched and ligaturized ";};
}
