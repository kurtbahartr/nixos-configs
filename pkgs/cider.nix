{ pkgs, appimageTools, lib, requireFile, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "cider";
  version = "3.0.2";

  src = requireFile {
    name = "${pname}-v${version}-linux-x64.AppImage";
    url = "https://cidercollective.itch.io/cider/";
    sha256 = "1rfraf1r1zmp163kn8qg833qxrxmx1m1hycw8q9hc94d0hr62l2x";
  };

  extraInstallCommands =
    let contents = appimageTools.extract { inherit pname version src; };
    in ''
      install -m 444 -D ${contents}/Cider.desktop -t $out/share/applications/
      mv $out/share/applications/Cider.desktop $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=Cider' 'Exec=${pname}'
      install -m 444 -D ${contents}/usr/share/icons/hicolor/256x256/cider.png -t $out/share/icons/hicolor/256x256/apps/
    '';

  meta = with lib; {
    description = "A new look into listening and enjoying Apple Music in style and performance.";
    homepage = "https://cider.sh/";
    maintainers = [ maintainers.kurtbahartr ];
    platforms = [ "x86_64-linux" ];
  };
}
