{ pkgs, appimageTools, lib, fetchurl}:

appimageTools.wrapType2 rec {
  pname = "cider";
  version = "3.0.2";

  src = ./cider-v3.0.2-linux-x64.AppImage;

  extraInstallCommands =
    let contents = appimageTools.extract { inherit pname version src; };
    in ''
      install -m 444 -D ${contents}/Cider.desktop -t $out/share/applications/
      mv $out/share/applications/Cider.desktop $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=Cider' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

  meta = with lib; {
    description = "A new look into listening and enjoying Apple Music in style and performance.";
    homepage = "https://cider.sh/";
    maintainers = [ maintainers.kurtbahartr ];
    platforms = [ "x86_64-linux" ];
  };
}
