{
  lib,
  stdenv,
  fetchurl,
  unzip,
  autoPatchelfHook,
  libusb1,
  android-tools,
}:

stdenv.mkDerivation {
  version = "1.2.1.dc05e3ea0";
  pname = "odin4-cli";

  src = fetchurl {
    url = "https://web.archive.org/web/20230225072710if_/https://forum.xda-developers.com/attachments/odin-zip.5629297/";
    sha256 = "sha256-2RjxMrCy7ly+7yf7Yfau7jc0zbICstyOOEWpVTAwAsU=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
  ];

  runtimeDependencies = [
    libusb1
    android-tools
  ];

  unpackCmd = "unzip -o -d odin4 $curSrc";

  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 odin4 $out/bin
  '';

  meta = with lib; {
    description = "An Odin4 binary for flashing Samsung firmware";
    mainProgram = "odin4";
    longDescription = ''
      This tool allows you to flash firmware and custom binaries to your Samsung
      devices directly from a Linux environment using only your terminal.
    '';
    homepage = "https://forum.xda-developers.com/t/official-samsung-odin-v4-1-2-1-dc05e3ea-for-linux.4453423/";
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = licenses.unfree;
    maintainers = with maintainers; [ kurtbahartr ];
    platforms = [
      "x86_64-linux"
    ];
  };
}
