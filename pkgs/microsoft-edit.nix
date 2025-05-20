{
  lib,
  stdenv,
  fetchurl,
  xz,
  gnutar,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  version = "1.0.0";
  pname = "microsoft-edit";

  src = fetchurl {
    url = "https://github.com/microsoft/edit/releases/download/v${version}/edit-${version}-x86_64-linux-gnu.xz";
    sha256 = "sha256-vattsWsWezjvMY55cqEActVixMotuibqfqM88aEGpvo=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    xz
  ];

  # Unpacking fails unless we do this fuckery.
  unpackCmd = "mkdir edit && xz -d --stdout $curSrc > edit/edit";

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 edit $out/bin
  '';

  meta = with lib; {
    description = "A simple editor for simple needs";
    mainProgram = "edit";
    longDescription = ''
      This editor pays homage to the classic MS-DOS Editor, but with a
      modern interface and input controls similar to VS Code. The goal
      is to provide an accessible editor that even users largely
      unfamiliar with terminals can easily use.
    '';
    homepage = "https://github.com/microsoft/edit";
    license = licenses.mit;
    maintainers = with maintainers; [ kurtbahartr ];
    platforms = [
      "x86_64-linux"
    ];
  };
}
