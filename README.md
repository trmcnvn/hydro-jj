# Hydro JJ

A fork of [jorgebucaran/hydro](https://github.com/jorgebucaran/hydro) for [Jujutsu](https://github.com/jj-vcs/jj) support.

[![](https://user-images.githubusercontent.com/56996/103166797-f807ee00-4868-11eb-9818-c661584274c8.gif)](#hydro)

> `💥` indicates that there is a conflict on the commit
> 
> `🚧` indicates that the commit has diverged
> 
> `👻` indicates that this commit is hidden
> 
> `🔒` indicates that this commit is immutable

## Configuration

Modify variables using `set --universal` from the command line or `set --global` in your `config.fish` file.

### Symbols

| Variable                    | Type   | Description                     | Default |
| --------------------------- | ------ | ------------------------------- | ------- |
| `hydro_symbol_start`        | string | Prompt start symbol.            |         |
| `hydro_symbol_prompt`       | string | Prompt symbol.                  | `❱`     |
| `hydro_symbol_jj_conflict`  | string | jj conflict symbol.             | `💥`    |
| `hydro_symbol_jj_divergent` | string | jj divergent symbol.            | `🚧`    |
| `hydro_symbol_jj_hidden`    | string | jj hidden symbol.               | `👻`    |
| `hydro_symbol_jj_immutable` | string | jj immutable symbol.            | `🔒`    |

### Colors

> Any argument accepted by [`set_color`](https://fishshell.com/docs/current/cmds/set_color.html).

| Variable               | Type  | Description                    | Default              |
| ---------------------- | ----- | ------------------------------ | -------------------- |
| `hydro_color_pwd`      | color | Color of the pwd segment.      | `$fish_color_normal` |
| `hydro_color_jj`       | color | Color of the jj segment.       | `$fish_color_normal` |
| `hydro_color_start`    | color | Color of the start symbol.     | `$fish_color_normal` |
| `hydro_color_error`    | color | Color of the error segment.    | `$fish_color_error`  |
| `hydro_color_prompt`   | color | Color of the prompt symbol.    | `$fish_color_normal` |
| `hydro_color_duration` | color | Color of the duration section. | `$fish_color_normal` |

### Flags

| Variable          | Type    | Description                                  | Default |
| ----------------- | ------- | -------------------------------------------- | ------- |
| `hydro_multiline` | boolean | Display prompt character on a separate line. | `false` |

### Misc

| Variable                       | Type    | Description                                                                                                              | Default |
| ------------------------------ | ------- | ------------------------------------------------------------------------------------------------------------------------ | ------- |
| `fish_prompt_pwd_dir_length`   | numeric | The number of characters to display when path shortening. Set it to `0` to display only the topmost (current) directory. | `1`     |
| `hydro_ignored_jj_paths`       | strings | Space separated list of paths where no jj info should be displayed.                                                     | `""`    |
| `hydro_cmd_duration_threshold` | numeric | Minimum command duration, in milliseconds, after which command duration is displayed.                                    | `1000`  |

## License

[MIT](LICENSE.md)
