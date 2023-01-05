# Simple prompt.
# "user@host[dir]: "
echo -n -s (set_color $fish_color_user) "$USER" \
    (set_color $fish_color_host) "@$hostname" \
    (set_color $fish_color_cwd) "[$(prompt_pwd)]" \
    (set_color normal) "$(fish_vcs_prompt): "
