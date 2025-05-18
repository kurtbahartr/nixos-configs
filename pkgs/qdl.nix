{
  lib,
  stdenv,
  fetchgit,
  libxml2,
  libusb1,
  openssh,
}:
stdenv.mkDerivation rec {
  pname = "qdl";
  version = "1.0";

  src = fetchgit {
    url = "https://github.com/danielkutik/qdl";
    rev = "v1.0";
    sha256 = "sha256-WckpMOamZBRmQalHOrrRT0AQB2t4nWwEq5GVno+Rhx8=";
  };

  buildInputs = [
    libxml2
    libusb1
    openssh
  ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv qdl $out/bin
  '';
}
