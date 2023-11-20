{ stdenv, lib, fetchFromGitHub, zig_0_10 }:

stdenv.mkDerivation rec {
  pname = "statxt";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "poweredbypie";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Ymi2xZxLcyIZObuZpr55C0NRxo27UGxN1j5NLiWwRs0=";
  };

  nativeBuildInputs = [ zig_0_10 ];

  dontConfigure = true;

  preBuild = ''
    export HOME=$TMPDIR
  '';

  installPhase = ''
    runHook preInstall
    zig build -Drelease-small -Dcpu=baseline --prefix $out install
    runHook postInstall
  '';
}
