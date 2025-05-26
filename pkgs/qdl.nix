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
  version = "2.1";

  src = fetchFromGitHub {
    owner = "linux-msm";
    repo = pname;
    rev = "v${version}";
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
