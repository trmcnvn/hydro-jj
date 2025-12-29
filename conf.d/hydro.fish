status is-interactive || exit

set --global _hydro_jj _hydro_jj_$fish_pid

function $_hydro_jj --on-variable $_hydro_jj
    commandline --function repaint
end

function _hydro_pwd --on-variable PWD --on-variable hydro_ignored_jj_paths --on-variable fish_prompt_pwd_dir_length
    set --local jj_root (command jj root --ignore-working-copy 2>/dev/null)
    set --local jj_base (string replace --all --regex -- "^.*/" "" "$jj_root")
    set --local path_sep /

    test "$fish_prompt_pwd_dir_length" = 0 && set path_sep

    if set --query jj_root[1] && ! contains -- $jj_root $hydro_ignored_jj_paths
        set --erase _hydro_skip_jj_prompt
    else
        set --global _hydro_skip_jj_prompt
    end

    set --global _hydro_pwd (
        set -l pwd_value (
            string replace --ignore-case -- ~ \~ $PWD |
            string replace -- "/$jj_base/" /:/ |
            string replace --regex --all -- "(\.?[^/]{"(
                string replace --regex --all -- '^$' 1 "$fish_prompt_pwd_dir_length"
            )"})[^/]*/" "\$1$path_sep" |
            string replace -- : "$jj_base"
        )
        
        if test "$hydro_bold_pwd" = "true"
            echo $pwd_value | string replace --regex -- '([^/]+)$' "\x1b[1m\$1\x1b[22m"
        else
            echo $pwd_value
        end |
        string replace --regex --all -- '(?!^/$)/|^$' "\x1b[2m/\x1b[22m"
    )
end

function _hydro_postexec --on-event fish_postexec
    set --local last_status $pipestatus
    set --global _hydro_status "$_hydro_newline$_hydro_color_prompt$hydro_symbol_prompt"

    for code in $last_status
        if test $code -ne 0
            set --global _hydro_status "$_hydro_color_error| "(echo $last_status)" $_hydro_newline$_hydro_color_prompt$_hydro_color_error$hydro_symbol_prompt"
            break
        end
    end

    test "$CMD_DURATION" -lt $hydro_cmd_duration_threshold && set _hydro_cmd_duration && return

    set --local secs (math --scale=1 $CMD_DURATION/1000 % 60)
    set --local mins (math --scale=0 $CMD_DURATION/60000 % 60)
    set --local hours (math --scale=0 $CMD_DURATION/3600000)

    set --local out

    test $hours -gt 0 && set --local --append out $hours"h"
    test $mins -gt 0 && set --local --append out $mins"m"
    test $secs -gt 0 && set --local --append out $secs"s"

    set --global _hydro_cmd_duration "$out "
end

function _hydro_prompt --on-event fish_prompt
    set --query _hydro_status || set --global _hydro_status "$_hydro_newline$_hydro_color_prompt$hydro_symbol_prompt"
    set --query _hydro_pwd || _hydro_pwd

    command kill $_hydro_last_pid 2>/dev/null

    set --query _hydro_skip_jj_prompt && set $_hydro_jj && return

    fish --private --command "
        set branch (
          command jj log --revisions @ --no-graph --ignore-working-copy --color always --limit 1 --template \"
            separate(' ',
              raw_escape_sequence('\x1b[34m') ++ '$hydro_symbol_jj',
              change_id.shortest($hydro_jj_change_id_len),
              bookmarks,
              concat(
                if(conflict, '$hydro_symbol_jj_conflict'),
                if(divergent, '$hydro_symbol_jj_divergent'),
                if(hidden, '$hydro_symbol_jj_hidden'),
                if(immutable, '$hydro_symbol_jj_immutable'),
              ),
              raw_escape_sequence('\x1b[32m') ++ if(empty, '$hydro_jj_empty_str'),
              raw_escape_sequence('\x1b[32m') ++ if(description.first_line().len() == 0,
                '$hydro_jj_description_str',
                if(description.first_line().substr(0, 29) == description.first_line(),
                  description.first_line(),
                  description.first_line().substr(0, 29) ++ '…',
                )
              ) ++ raw_escape_sequence('\x1b[0m'),
            )
          \" 2>/dev/null
        )

        test -z \"\$$_hydro_jj\" && set --universal $_hydro_jj \"\$branch \"

        for fetch in $hydro_fetch false
            set --universal $_hydro_jj \"\$branch\$info \"
        end
    " &

    set --global _hydro_last_pid $last_pid
end

function _hydro_fish_exit --on-event fish_exit
    set --erase $_hydro_jj
end

function _hydro_uninstall --on-event hydro_uninstall
    set --names |
        string replace --filter --regex -- "^(_?hydro_)" "set --erase \$1" |
        source
    functions --erase (functions --all | string match --entire --regex "^_?hydro_")
end

set --global hydro_color_normal (set_color normal)

for color in hydro_color_{pwd,jj,error,prompt,duration,start}
    function $color --on-variable $color --inherit-variable color
        set --query $color && set --global _$color (set_color $$color)
    end && $color
end

function hydro_multiline --on-variable hydro_multiline
    if test "$hydro_multiline" = true
        set --global _hydro_newline "\n"
    else
        set --global _hydro_newline ""
    end
end && hydro_multiline

set --query hydro_color_error || set --global hydro_color_error $fish_color_error
set --query hydro_symbol_prompt || set --global hydro_symbol_prompt ❱
set --query hydro_multiline || set --global hydro_multiline false
set --query hydro_cmd_duration_threshold || set --global hydro_cmd_duration_threshold 1000
set --query hydro_symbol_jj_conflict || set --global hydro_symbol_jj_conflict 💥
set --query hydro_symbol_jj_divergent || set --global hydro_symbol_jj_divergent 🚧
set --query hydro_symbol_jj_hidden || set --global hydro_symbol_jj_hidden 👻
set --query hydro_symbol_jj_immutable || set --global hydro_symbol_jj_immutable 🔒
set --query hydro_symbol_jj || set --global hydro_symbol_jj '󱗆'
set --query hydro_jj_change_id_len || set --global hydro_jj_change_id_len 8
set --query hydro_jj_empty_str || set --global hydro_jj_empty_str '(empty)'
set --query hydro_jj_description_str || set --global hydro_jj_description_str '(no description set)'
set --query hydro_bold_pwd || set --global hydro_bold_pwd true
