{ ... }:
let
  colors = {
    # Hex codes.
    text = "ffffff";
    light = "d19336";
    middle = "966924";
    dark = "353535";
    darkest = "000000";
  };
  prefixed = (builtins.mapAttrs (_: value: "#${value}") colors);
in
prefixed // {
  noPrefix = colors;
}
