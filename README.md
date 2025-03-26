# <i>H</i>ydro

> Ultra-pure, lag-free prompt with async Jujutsu status. Designed only for [Fish](https://fishshell.com).

[![](https://user-images.githubusercontent.com/56996/103166797-f807ee00-4868-11eb-9818-c661584274c8.gif)](#hydro)

> [!NOTE]
> Variables have been renamed to reference jj compared to the parent. Fetching functionality was removed.

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```console
fisher install trmcnvn/hydro
```

## Features

One prompt symbol to rule them all. [Change it](#configuration)?

<pre>
<b>~</b> ❱ ⎢
</pre>

Display jj working copy change id, bookmark, state, and repaints asynchronously! ✨

<pre>
~/p/<b>hydro</b> @asdf | (empty) (no description set) ❱ touch Solution
~/p/<b>hydro</b> @asdf main | (no description set) ❱ jj desc -m "Hello, World!"
~/p/<b>hydro</b> @asdf main | Hello, World ❱ ...
</pre>

> `💥` indicates that there is a conflict on the commit
> 
> `🚧` indicates that the commit has diverged
> 
> `👻` indicates that this commit is hidden
> 
> `🔒` indicates that this commit is immutable

Display [`$CMD_DURATION`](https://fishshell.com/docs/current/language.html?highlight=cmd_duration#envvar-CMD_DURATION) when > `1` second. [Configurable](#configuration).

<pre>
~/p/<b>hydro</b> @asdf | (no description set) ❱ git push --quiet
~/p/<b>hydro</b> @asdf | (no description set) 1.1s ❱ ⎢
</pre>

Display the last non-zero [exit status](https://fishshell.com/docs/current/tutorial.html#exit-status) (or statuses) using [`$pipestatus`](https://fishshell.com/docs/current/language.html?highlight=cmd_duration#envvar-pipestatus).

<pre>
~/p/<b>hydro</b> @asdf | (no description set) ❱ false
~/p/<b>hydro</b> @asdf | (no description set) | <b>1</b> ❱ ⎢
~/p/<b>hydro</b> @asdf | (no description set) ❱ true | false | false
~/p/<b>hydro</b> @asdf | (no description set) | <b>0</b> <b>1</b> <b>1</b> ❱ ⎢
</pre>

Truncate [`$PWD`](https://fishshell.com/docs/current/language.html?highlight=cmd_duration#envvar-PWD) segments except for the basename and root of jj repos.

<pre>
<b>~</b> ❱ projects/hydro/
~/p/<b>hydro</b> ❱ functions/share/
~/p/hydro/f/<b>share</b> ❱ ⎢
</pre>

Display the current bindings mode.

<pre>
<i>I</i> <b>~</b> ❱ <kbd>Esc</kbd>
<i>N</i> <b>~</b> ❱ <kbd>R</kbd>
<i>R</i> <b>~</b> ❱ ⎢
</pre>

## Performance

Blazing fast would be an understatement considering that the [LLVM repo](https://github.com/llvm/llvm-project) has over 375,000 commits!

<pre>
~/<b>llvm-project</b> @xxmv | (empty) (no description set) ❱ time fish_prompt
~/<b>llvm-project</b> @xxmv | (empty) (no description set) ❱
________________________________________________________
Executed in   81.00 micros    fish           external
   usr time   61.00 micros   61.00 micros    0.00 micros
   sys time   15.00 micros   15.00 micros    0.00 micros
</pre>

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
