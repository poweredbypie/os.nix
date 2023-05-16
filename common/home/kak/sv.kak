hook global BufCreate .*[.]sv %{
    set-option buffer filetype sv
}
