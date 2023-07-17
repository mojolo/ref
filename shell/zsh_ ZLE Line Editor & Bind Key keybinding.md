## View keyboard terminal escape codes

`showkey -a|s|k` - Examines codes sent by keyboard. My fav. Continues to read key presses and print to `stdout` until program is terminated with `^D`, which is the special combo that terminates the program. 

* `$ showkey -a` - Prints ASCII dumps. Even `^C` is processed.
* `# showkey -s` - Prints scan code dumps.
* `# showkey -k` - Prints keycodes.

`^V` - Quoted Insert - Inserts the very next key (combo) into the buffer, without parsing it. Then returns to normal mode.

`read` - Read from a file descriptor - continues to read key presses and print escape codes to `stdout`. Will not read binded keys though, e.g., the `^V` keybind intercepts and does its thing; `^C` terminates the program as norma..

`xxd` - Makes a hex dump

---

## Getting info on current `key bindings`, `keymaps` & `bindkey widgets`

##### `bindkey [-l | -lL | -M <keymap>]`

* `bindkey` - prints all keybindings for current keymap.

* `bindkey -l` will give you a list of existing keymap names.
* `bindkey -lL` will list bindkey commands that can be used to create your keymaps.

- `bindkey -M <keymap>` will list all the bindings in a given `keymap`: emacs, viins, vicmd

##### `zle [ -l | -lL | -la ]`

- `zle -l` lists all existing user-defined widgets.
- `zle -lL` lists all existing user-defined widgets in the form of zle commands to create the widgets. 
- `zle -la` lists all registered Zle widgets (commands), including the builtin ones.

##### Reference

* [A Guide to the Zsh Line Editor with Examples](https://thevaluable.dev/zsh-line-editor-configuration-mouseless/): thevaluable.dev

* [zshzle(1) - MANPAGE](https://linux.die.net/man/1/zshzle)

* [18.4 Zle Widgets](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets)

* [18.5 User-Defined Widgets](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#User_002dDefined-Widgets)
* [18.6 Standard Widgets](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets): Movement, History Control, Modifying Text, Arguments, Completion, Miscellaneous, Text Objects

---

## Binding keys

##### `bindkey -e | -v | -a | -M | -s | -r`

If a keymap selection is required and none of the options below are used, the ***main*** keymap is used. E.g.,

* ```bash
  bindkey '^Z' undo                       # [Ctrl+Z] Undo
  ```

* ```bash
  bindkey '^[[3;3~' kill-word             # [Alt+Delete] Kill current or next word
  ```

`bindkey -e` - Selects keymap `emacs`, and also links it to **main**.

`bindkey -v` - Selects keymap `viins`, and also links it to **main**.

`bindkey -a` - Selects keymap `vicmd`.

`bindkey -M <keymap>` - Binds to a specific keymap, e.g.,

* `.safe, command, emacs, isearch, listscroll, main, menuselect, vicmd, viins, viopp, visual`

* Examples:

  * ```bash
    bindkey -M emacs '^R' fzf-history-widget
    ```

  * ```bash
    bindkey -M vicmd '^R' fzf-history-widget
    ```

  * ```bash
    bindkey -M viins '^R' fzf-history-widget
    ```

  * ```bash
    bindkey -M menuselect '/' accept-and-infer-next-history    # Next
    ```

  * ```bash
    bindkey -M menuselect '^xx' send-break   # Leave menu select & restore previous command
    ```

`bindkey -s <in-string> <out-string> ...` - Bind each in-string to each out-string. When in-string is typed, out-string will be pushed back and treated as input to the line editor. When -R is also used, interpret the in-strings as ranges.

* ```bash
  bindkey -s '^o' 'nvim $(fzf)^M'			# Bind key combo to run a user-specified command
  ```

`bindkey -r <in-string> ...` - Unbind the specified *in-strings* in the selected keymap. E.g.,

* ```bash
  bindkey -ar "+"					# unbinds the `+` key from `vicmd` keymap			
  bindkey -M vicmd -r "+"			# also unbinds the `+` key from `vicmd` keymap
  ```

## Manipulating Widgets

`zle -D <widget>`: Delete the named *widget*s.

`zle -A <old-widget> <new-widget>`: Make the *new-widget* name an alias for *old-widget*, so that both names refer to the same widget. The names have equal standing; if either is deleted, the other remains. If there is already a widget with the *new-widget* name, it is deleted.

`zle -N <widget> [ function ]`: Create a user-defined widget. If there is already a widget with the specified name, it is overwritten. When the new widget is invoked from within the editor, the specified shell *function* is called. If no function name is specified, it defaults to the same name as the widget. For further information, see the section *Widgets* in **zshzle**(1).

`zle -C <widget> <completion-widget> <function>`: Create a user-defined completion widget named *widget*. The completion widget will behave like the built-in completion-widget whose name is given as *completion-widget*. To generate the completions, the shell function *function* will be called. For further information, see **[zshcompwid](https://linux.die.net/man/1/zshcompwid)**(1).

* See [*man zshle*](https://linux.die.net/man/1/zshzle) for more `zle` options and their use

## [Bind key to run a custom command](https://jdhao.github.io/2019/06/13/zsh_bind_keys/)

One reader of [this post](https://jdhao.github.io/2018/11/05/fzf_install_use/) asked a question on how to use shortcut keys to run the following command:

```bash
nvim $(fzf)
```

I searched the web and found a solution. Suppose that we want to bind Ctrl + O to the above command, we can add the following setting to `.zshrc`:

```zsh
bindkey -s '^o' 'nvim $(fzf)^M'
# you may also use the following one
# bindkey -s '^o' 'nvim $(fzf)\n'
```

In the above setting, `-s` option is used to translate the input string to output string so that when you press the shortcut, it is replaced with the command you want to run. `^M` or `\n` is used to represent the Enter key so that the command is run automatically.
