{
  # Zapret!
  services.zapret = {
    enable = true;
    params = [
      # Turkcell Superonline and Turk Telekom fiber home networks - Thanks cotunjr!
      "--dpi-desync=split2 --dpi-desync-ttl=5 --wssize 1:6 --dpi-desync-fooling=md5sig"
      "--dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-repeats=6"
      # eduroam - Samsun University
      "--dpi-desync=fake --dpi-desync-ttl=7 --dpi-desync-fake-tls=0x00000000"
      # Turk Telekom ADSL/VDSL home networks
      "--hostspell=hoSt"
      "--dpi-desync=fake --dpi-desync-ttl=3"
    ];
  };
}
