declare-user-mode buffers
map global user b '<esc>: buffers-select<ret>'

define-command buffers-select %{
    # Refresh
    unmap global buffers
    evaluate-commands %sh{
        eval set -- "$kak_quoted_buflist"
        i=0
        for buf do
            printf "map -docstring %s global buffers %d '<esc>: buffer %s<ret>'\n" "$buf" "$i" "$buf"
            i=$((i + 1))
        done
    }
    enter-user-mode buffers
}
