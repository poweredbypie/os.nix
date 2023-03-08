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
    # Thanks Luke
    # https://youtu.be/x4KYASmFT0o?t=140
    {
      key = "w";
      mode = "user";
      effect = ":write<ret>";
      docstring = "write the current buffer";
    }
    {
      key = "q";
      mode = "user";
      effect = ":quit!<ret>";
      docstring = "quit current client";
    }
    {
      key = "d";
      mode = "user";
      effect = ":delete-buffer!<ret>";
      docstring = "delete current buffer";
    }
  ];
}
