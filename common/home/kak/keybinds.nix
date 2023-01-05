{ ... }:

{
  programs.kakoune.config.keyMappings = [
    # Indent and dedent with spaces.
    {
      key = "<tab>";
      mode = "insert";
      effect = "<a-;><a-gt>";
    }
    {
      key = "<s-tab>";
      mode = "insert";
      effect = "<a-;><a-lt>";
    }
  ];
}
