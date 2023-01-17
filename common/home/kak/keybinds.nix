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
    {
      key = "<tab>";
      mode = "normal";
      effect = "<a-gt>";
    }
    {
      key = "<s-tab>";
      mode = "normal";
      effect = "<a-lt>";
    }
    # VSCode-like navigation while inserting
    {
      key = "<c-left>";
      mode = "insert";
      effect = "<esc>b;i";
    }
    {
      key = "<c-right>";
      mode = "insert";
      effect = "<esc>e;i";
    }
    # Ctrl+W deletes a word while inserting
    # Ctrl+Backspace is mapped to Ctrl+W in my terminal emulator
    {
      key = "<c-w>";
      mode = "insert";
      effect = "<esc>bdi";
    }
  ];
}
