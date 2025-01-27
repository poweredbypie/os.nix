{ stdenv, fetchFromGitHub, zig }:

stdenv.mkDerivation rec {
  pname = "statxt";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "poweredbypie";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Sb4UQf3DjMozRAVgMUsCarntgU3JCQ7REGw6LJXANgs=";
  };

  nativeBuildInputs = [ zig.hook ];

  zigBuildFlags = [ "-Doptimize=ReleaseSmall" ];

  dontConfigure = true;
}
