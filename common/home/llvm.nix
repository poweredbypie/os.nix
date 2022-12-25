{ pkgs, ... }:

{
  # Annoyingly, the default tools are an older version.
  home.packages = with pkgs; [
    clang_14
    # Includes clangd
    clang-tools_14
    # Newest LLDB is older?? What the hell
    lldb_13
  ];
}
