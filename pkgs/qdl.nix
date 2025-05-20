{
  lib,
  stdenv,
  fetchFromGitHub,
  libxml2,
  libusb1,
  pkg-config
}:
stdenv.mkDerivation rec {
  pname = "qdl";
  version = "30ac3a8";

  src = fetchFromGitHub {
    owner = "danielkutik";
    repo = "qdl";
    rev = "30ac3a8";
    sha256 = "sha256-5ZV39whIm8qJIBLNdAsR2e8+f0jYjwE9dGNgh6ARPUY=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libxml2
    libusb1
  ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv qdl $out/bin
  '';
}
