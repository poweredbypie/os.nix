{ pkgs, ... }:

{
  # Annoyingly, the default tools are an older version.
  home.packages = with pkgs; [
    clang_15
    # Includes clangd and clang-format
    clang-tools_15
    # Debugger
    lldb_15
    # This is used everywhere
    gnumake
  ];
}
