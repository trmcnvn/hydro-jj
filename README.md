# Hydro JJ

A fork of [jorgebucaran/hydro](https://github.com/jorgebucaran/hydro) for [Jujutsu](https://github.com/jj-vcs/jj) support.

[![](https://user-images.githubusercontent.com/56996/103166797-f807ee00-4868-11eb-9818-c661584274c8.gif)](#hydro-jj)

> **Note:** The GIF above is from the original Hydro prompt. A JJ-specific screenshot is coming soon.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install trmcnvn/hydro-jj
```

## Features

- Displays the JJ change ID (configurable length)
- Shows bookmarks for the current revision
- Displays the commit description (truncated to 29 characters)
- Status indicators:
  - `💥` — conflict on the commit
  - `🚧` — commit has diverged
  - `👻` — commit is hidden
  - `🔒` — commit is immutable
- Shows `(empty)` when on an empty commit
- Shows `(no description set)` when no description exists
- Async prompt repainting for lag-free experience
- Command duration display
- Exit status display via `$pipestatus`

## Configuration

Modify variables using `set --universal` from the command line or `set --global` in your `config.fish` file.

### Symbols

| Variable                    | Type   | Description                     | Default |
| --------------------------- | ------ | ------------------------------- | ------- |
| `hydro_symbol_start`        | string | Prompt start symbol.            |         |
| `hydro_symbol_prompt`       | string | Prompt symbol.                  | `❱`     |
| `hydro_symbol_jj`           | string | JJ symbol.                      | `󱗆`    |
| `hydro_symbol_jj_conflict`  | string | JJ conflict symbol.             | `💥`    |
| `hydro_symbol_jj_divergent` | string | JJ divergent symbol.            | `🚧`    |
| `hydro_symbol_jj_hidden`    | string | JJ hidden symbol.               | `👻`    |
| `hydro_symbol_jj_immutable` | string | JJ immutable symbol.            | `🔒`    |

### Colors

> Any argument accepted by [`set_color`](https://fishshell.com/docs/current/cmds/set_color.html).

| Variable               | Type  | Description                    | Default              |
| ---------------------- | ----- | ------------------------------ | -------------------- |
| `hydro_color_pwd`      | color | Color of the pwd segment.      | `$fish_color_normal` |
| `hydro_color_jj`       | color | Color of the JJ segment.       | `$fish_color_normal` |
| `hydro_color_start`    | color | Color of the start symbol.     | `$fish_color_normal` |
| `hydro_color_error`    | color | Color of the error segment.    | `$fish_color_error`  |
| `hydro_color_prompt`   | color | Color of the prompt symbol.    | `$fish_color_normal` |
| `hydro_color_duration` | color | Color of the duration section. | `$fish_color_normal` |

### Flags

| Variable          | Type    | Description                                   | Default |
| ----------------- | ------- | --------------------------------------------- | ------- |
| `hydro_multiline` | boolean | Display prompt character on a separate line.  | `false` |
| `hydro_bold_pwd`  | boolean | Bold the current directory name in the prompt.| `true`  |

### Misc

| Variable                       | Type    | Description                                                                                                               | Default                |
| ------------------------------ | ------- | ------------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| `fish_prompt_pwd_dir_length`   | numeric | The number of characters to display when path shortening. Set it to `0` to display only the topmost (current) directory. | `1`                    |
| `hydro_ignored_jj_paths`       | strings | Space separated list of paths where no JJ info should be displayed.                                                       | `""`                   |
| `hydro_cmd_duration_threshold` | numeric | Minimum command duration, in milliseconds, after which command duration is displayed.                                     | `1000`                 |
| `hydro_jj_change_id_len`       | numeric | Length of the JJ change ID to display.                                                                                    | `8`                    |
| `hydro_jj_empty_str`           | string  | Text to display when on an empty commit.                                                                                  | `(empty)`              |
| `hydro_jj_description_str`     | string  | Text to display when no description is set.                                                                               | `(no description set)` |

## License

[MIT](LICENSE.md)
