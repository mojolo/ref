## [How to modify the PATH environment variables in Catalina?](https://unix.stackexchange.com/questions/580418/how-to-modify-the-path-environment-variables-in-catalina)

As you said in [your own self-answer](https://unix.stackexchange.com/a/580596/116858), you don't need to know where the `PATH` variable is originally populated.

You may easily add new paths to the `PATH` at either end or beginning, and `zsh` also has a convenient way of removing duplicates.

You may make the `PATH` variable, and the associated `path` array, unique first, by using

```bash
typeset -U -g PATH path
```

The variables will then *stay* unique by virtue of this command.

To prepend a couple of paths:

```bash
path=( /new/path1 /new/path2 $path )
```

To append a couple of paths:

```bash
path=( $path /new/path1 /new/path2 )
```

or,

```bash
path+=( /new/path1 /new/path2 )
```

The `PATH` variable's value will be updated accordingly.

You may want to do this in your `$ZDOTDIR/.zprofile` file, which is sourced automatically by any `zsh` login shell. Doing it in your `$ZDOTDIR/.zshenv` file would be unnecessary as that file is sourced by *any type* of `zsh` invocation (and should therefore be kept really short, if it's needed at all; I just set `ZDOTDIR=$HOME/.zsh` in there, for example).

Note that `PATH` is already an environment variable, so exporting it again serves no purpose.

> About `ZDOTDIR=$HOME/.zsh`, if I set this on `/etc/zshenv`, would it be a good idea? (I originally set it on `~/.zshenv`, but this way I will have both `~/.zshenv` and `~/.zsh/`, but I want `~/.zshenv` also in `~/.zsh/` folder)

> @Niing If `/etc/zshenv` sets `ZDOTDIR` to `$HOME/.zsh`, then `~/.zsh/.zshenv` will be read rather than `~/.zshenv` (for all users). Personally I have `~/.zshenv` as a symbolic link to `~/.zsh/.zshenv`.                                

---

## [Adding a new entry to the PATH variable in ZSH](https://stackoverflow.com/questions/11530090/adding-a-new-entry-to-the-path-variable-in-zsh)

Actually, using ZSH allows you to use special mapping of environment variables. So you can simply do:

```zsh
# append
path+=('/home/david/pear/bin')
# or prepend
path=('/home/david/pear/bin' $path)
# export to sub-processes (make it inherited by child processes)
export PATH
```

For me that's a very neat feature which can be propagated to other variables. Example:

```
typeset -T LD_LIBRARY_PATH ld_library_path :     
```

> Nice answer. In my case, `~/.zshrc` is sourced after `.profile`, and overwrites everything in `.profile`. Took a while pulling my hair to figure it out.   

> The append case does does not need the parens unless you're appending more than one element. It also  often doesn't need the quotes. So the simple, short way to append is

> @SuperUberDuper, you should  understand that almost any unix shell simply reads startup files which  does almost the same as if you'd type it into shell interactively.  Regarding "rc" files you might find interesting answer to [this question](http://unix.stackexchange.com/questions/3467/what-does-rc-in-bashrc-stand-for)

> It's possible to avoid explicit export with `-x` and leave only unique values in a variable with `-U`, colon is assumed by default, so it can be: `typeset -TUx PATH path`

> I see the use of `path` and `PATH`, both are separate entities?

> @CousinCocaine, you are right. ZSH variables are case-sensitive. `typeset -T` allows to tie `PATH` and `path` together in a special way that internally ZSH manages array variable `path` and reflects its contents in `PATH` as a scalar.

> You can even have it as 1-liner: `export path=(... $path)`.

> This doesn't work for me on my mac. I use the one liner answer below that updates ~/.zshrc insead.

> @KhanhNguyen how can I see when these files are sourced? Is there a cmd?

> @Timo, in case of zsh you can try something like `zsh -x -i -l -c true` to see all commands during shell start-up. That `-l` is to simulate login-like start (as it happens from text VT or over `ssh`). But you should understand that not always `zsh` will be started as login (e.g. graphical session) and some other parent process may somehow source `.profile` before spawning non-login `zsh` sub-process that inherits environment variables (including `PATH`) from parent process.

> What if i want to use $HOME inside ' '? path +=('$HOME/etc/etc') doesn't seem to work

> @Rotkiv, that's a bit different question about how single/double quotes are interpreted. I guess [zsh expansion](http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion) covers this. Usually double-quotes allow string interpolation like `"$HOME/etc/etc"`, but single quotes makes it easier to represent text that should not get special treatment. Note that you can always mix in a single argument  forms to have something like `"$HOME"'/etc/etc'` (double + single quotes) or `"$HOME"/etc/etc` (double quotes + unquoted). P.S. Yes I'm lazy to try find link to good answer on SO :P

> On macOS, you can prepend and append to your path variable as described in the post, adding to the  .zshrc file. It works without exporting the PATH.

> If this append or prepend syntax doesn't work for you, make sure that you are using lower case `path`. Lower case `path` is the array.

> Thank you for showing the prepend as well! Didn't see it anywhere else.

> This does not seem to work with `~`.

> This didn't work for me even though things looked absolutely fine when I `echo $PATH`. I had to go back to the "traditional" syntax of something like: `export PATH=$ANDROID_HOME/platform-tools:$PATH`

> @MinhNghĩa, `~` is expanded by shell. If you put it in quotes like `'~/bin'` or `"~/bin"` it will be literally tilda in your path. E.g. you can write `path+=(~/bin)` (note no quotes) or similar. If you need to quote something, you still can do it on part like `path+=(~/'some path with spaces')`.

> @Phil, my best guess for your case is that ok result of `echo $PATH` shows your current shell value for it. Any chance it works if you do `export PATH` (upper case) to export for sub-process after setting `path` (lower case)?

> Append did not work for me. Old school export did.

#### [REPLY](https://stackoverflow.com/a/30792333/21972531)

You can *append* to your `PATH` in a minimal fashion.  No need for parentheses unless you're appending more than one element.  It also usually doesn't need quotes.  So **the simple, short way to append** is:

```
path+=/some/new/bin/dir
```

This lower-case syntax is using `path` as an **array**, yet also affects its upper-case partner equivalent, `PATH` (to which it is "bound" via `typeset`).

*(Notice that **no `:` is needed/wanted as a separator**.)*

##### Common interactive usage

Then the common pattern for testing a new script/executable becomes:

```
path+=$PWD/.
# or
path+=$PWD/bin
```

##### Common config usage

You can sprinkle path settings around your `.zshrc` (as above) and it will naturally lead to the **earlier listed settings taking precedence** (though you may occasionally still want to use the "prepend" form `path=(/some/new/bin/dir $path)`).

##### Related tidbits

Treating `path` this way (as an array) also means: **no need to do a `rehash`** to get the newly pathed commands to be found.

Also take a look at **`vared path` as a dynamic way to edit `path`** (and other things).

You may only be interested in `path` for this question, but since we're talking about exports and arrays, note that **[arrays generally cannot be exported.](http://www.zsh.org/mla/workers/1997/msg00515.html)**

You can even **prevent `PATH` from taking on duplicate entries** (refer to [this](http://zsh.sourceforge.net/Guide/zshguide02.html#l24) and [this](http://www.zsh.org/mla/users/1998/msg00490.html)):

```
typeset -U path
```

##### PATH pre-populated

The reason your path already has some entries in it is due to your  system shell files setting path for you. This is covered in a couple  other posts:

- [Why and where the $PATH env variable is set?](https://unix.stackexchange.com/questions/246751/how-to-know-why-and-where-the-path-env-variable-is-set)
- [Where is the source of $PATH? I cannot find it in .zshrc](https://superuser.com/questions/1464727/in-zsh-on-mac-os-where-is-the-source-of-path-i-cannot-find-it-in-zshrc)

> @andrewlorien I updated the answer with details about the colon separator.

> Note that if there’s a comment after the path, then we do need quotes, like `path+='my/path' # for fun`. It’s obvious if you have spaces, but not so much if you have comments.    

> "(Notice that no : is needed/wanted as a separator.)"  This is only true for a lowercase `path`. A preceding `:` is required for `PATH`, as follows in .zshrc  `PATH+=:/Users/path/to/my/folder`

> I use a lot `exec zsh` because I work with plugins from `oh-my-zsh`.Everytime I do exec the path gets bigger. Should I "default" the path from time to time?

> For ZSH to interpret $PATH as an array and make it unique, I believe the correct way would be `typeset -aU path`

---

## [What is the difference between zsh's $path and $PATH?](https://superuser.com/questions/1447936/what-is-the-difference-between-zshs-path-and-path)

`$PATH` ist a scalar variable, whereas `$path` is an array.

Notice that in the first case the directories are delimited by colons inside the `$PATH` string itself; in the second case the array is automatically expanded and separated by spaces:

```bash
$ print $PATH
/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin
$print $path
/bin /usr/bin /usr/local/bin /usr/X11R6/bin
```

Both variants are automatically kept in sync by *zsh*. So, what's the benefit of using a array?

- The latter you can declare via `typeset -U path` to "keep only the first occurrence of each duplicated value" (from `man zshbuiltins`). That means this keeps your path clean, even if you successively source your `~/.zshrc` (because you changed it or whatever) and do not clutter it up with the same values again and again.
- You can use `path+=(/new/path)` to add a new directory to your PATH. To remove an element you have to use some tricks, see e.g. https://stackoverflow.com/q/3435355/2037712 or http://www.zsh.org/mla/users//2005/msg01132.html
- You can easily loop over the elements in the PATH via `for i ($path) { print $i # or do something else }`

Finally, here is an excerpt from my config with my attempt to keep my search path tidy:

```bash
typeset -U path
path=(/new/path1
      /new/path2
      $path)
export PATH
```

*Source: My own [answer](https://superuser.com/a/598924/195224) to another question.*

---

## [zsh config - to export or not to export?](https://superuser.com/questions/598810/zsh-config-to-export-or-not-to-export)

When setting variables in my `~/.zshrc` I can either use `export`

```bash
export PATH=/some/path
```

or not

```bash
PATH=/some/path
```

How do these differ and which should I use?

> Environmental variables that are also used by non-interactive shells (say, a shell script you wrote) should go into `.zshenv`.

> Is `~/.zshenv` sourced by login shells as well? Should `PATH` be defined there?

> `PATH` is probably the best example of a variable that should be defined inside `~/.zshenv`, this file gets sourced by **any** zsh session (unless you use some option to turn that off). See `man zsh` for a review of which files get sourced and in which order.

#### [REPLY](https://superuser.com/a/598924/1463359)

Demure already answered your specific question. However, this is a `zsh` question and about `PATH`. So here is another point: besides the standard variable `$PATH`, there is also `$path`, which is an array. Here you see the difference (colons or not...):

```bash
$ print $PATH
/bin:/usr/bin:/usr/local/bin:/usr/X11R6/bin
$ print $path
/bin /usr/bin /usr/local/bin /usr/X11R6/bin
```

Both variants are automatically kept in sync. So, what's the benefit of using an array?

- The latter you can declare via `typeset -U path` to "keep only the first occurrence of each duplicated value" (from `man zshbuiltins`). That means this keeps your path clean, even if you successively source your `~/.zshrc` (because you changed it or whatever) and do not clutter it up with the same values again and again.
- You can use `path+=(/new/path)` to add a new directory to your PATH. To remove an element you have to use some tricks, see e.g. https://stackoverflow.com/q/3435355/2037712 or http://www.zsh.org/mla/users//2005/msg01132.html
- You can easily loop over the elements in the PATH via `for i ($path) { print $i # or do something else }`

Finally, here is an excerpt from my config:

```bash
typeset -U path
path=(/new/path1
      /new/path2
      $path)
export PATH
```



> Thank you, that was actually a follow up question. I will look at managing my path using `path` rather than `PATH`.

> Glad to hear as I already feared that I'm OT. Btw. another advantage I forgot: You can easily loop over the elements with `for i ($path) { print $i # or do something else }`.

> If I add an entry to Zsh’s `path`, it’s not also added to `PATH`, is it?

> @Lucas: "Both variants are automatically kept in sync."

---

## [How can I change PATH variable in zsh?](https://stackoverflow.com/questions/68605927/how-can-i-change-path-variable-in-zsh)

Be careful when you decide to fiddle with the PATH in `.zshrc`: Since the file is processed by every interactive subshell, the PATH  would get longer and longer for each subshell, with the same directory  occuring in it several times. This can become a nightmare if you later  try to hunt down PATH-related errors.

Since you are using zsh, you can take advantage that the scalar variable PATH is **mirrored** in the array variable `path`, and that you can ask zsh to keep entries in arrays unique.

Hence, the first thing I would do is put a

```
 typeset -aU path
```

in your .zshrc; this (due to mirroring) also keeps the entries in  PATH unique. You can put this statement anywhere, but I have it for  easier maintenance before my first assignment to `PATH` or `path`.

It is up to you to decide where exactly you add a new entry to `PATH` or `path`. The entries are searched in that order which is listed in the variable. You have to ask yourself two questions:

- Are some directories located on a network share, where you can  sometimes expect access delays (due to bad network conditions)? Those  directories should better show up near the end of the path.
- Do you have commands which occur in more than one directoryin  your path? In this case, a path search will always find the first  occurance only.

Finally, don't forget that your changes will be seen after zsh  processes the file. Therefore, you could create a new subshell after  having edited the file, or source `.zshrc` manually.

---

## [What should/shouldn't go in .zshenv, .zshrc, .zlogin, .zprofile, .zlogout?](https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout)

In execution-order:

1. `.zshenv` is *always* sourced. It often contains exported variables that should be available to other programs. For example, `$PATH`, `$EDITOR`, and `$PAGER` are often set in `.zshenv`. Also, you can set `$ZDOTDIR` in `.zshenv` to specify an alternative location for the rest of your zsh configuration.
2. `.zprofile` is for login shells. It is basically the same as `.zlogin` except that it's sourced before `.zshrc` whereas `.zlogin` is sourced after `.zshrc`. According to the zsh documentation, *"`.zprofile` is meant as an alternative to `.zlogin` for ksh fans; the two are not intended to be used together, although this could certainly be done if desired."*
3. `.zshrc` is for interactive shells. You set options for the interactive shell there with the `setopt` and `unsetopt` commands. You can also load shell modules, set your history options,  change your prompt, set up zle and completion, et cetera. You also set  any variables that are only used in the interactive shell (e.g. `$LS_COLORS`).
4. `.zlogin` is for login shells. It is sourced on the start of a login shell but after `.zshrc`, if the shell is also interactive. This file is often used to start X using `startx`. Some systems start X on boot, so this file is not always very useful.
5. `.zlogout` is sometimes used to clear and reset the terminal. It is called when exiting, not when opening.

> Be aware when setting `$PATH` in `.zshenv`, various other files all are sourced after this file that will override this value. See [zsh.org/mla/users/2003/msg00600.html](http://www.zsh.org/mla/users/2003/msg00600.html).

> Just for my own notes / confirmation and to help anybody else, the ultimate order is `.zshenv` → [`.zprofile` if login] → [`.zshrc` if interactive] → [`.zlogin` if login] → [`.zlogout` sometimes].

> Be aware that in between `.zshenv` and `.zshrc` the `/etc/zshrc` is sourced and things like `HISTFILE`, `HISTSIZE` are unconditionally overwritten / set there so those variable should be set in `.zshrc` or `.zlogin`

#### [REPLY](https://unix.stackexchange.com/a/487889/487809)

Here a list of what each file should/shouldn't contain, in my opinion:

##### `.zshenv` *[Read every time]*

This file is always sourced, so it should set environment variables which need to be **updated frequently**. *PATH* (or its associated counterpart *path*) is a good example because you probably don't want to restart your whole session to make it update. By setting it in that file, reopening a  terminal emulator will start a new Zsh instance with the *PATH* value updated.

But be aware that this file is **read even when Zsh is launched to run a single command** (with the *-c* option), even by another tool like `make`. You should **be very careful to not modify the default behavior of standard commands** because it may break some tools (by setting aliases for example).

##### `.zprofile` *[Read at login]*

I personally treat that file like `.zshenv` but for commands and variables which should be set once or which **don't need to be updated frequently**:

- environment variables to configure tools (flags for compilation, data folder location, etc.)
- configuration which execute commands (like `SCONSFLAGS="--jobs=$(( $(nproc) - 1 ))"`) as it may take some time to execute.

If you modify this file, you can apply the configuration updates by running a login shell:

```bash
exec zsh --login
```

##### `.zshrc` *[Read when interactive]*

I put here everything needed only for **interactive usage**:

- prompt,
- command completion,
- command correction,
- command suggestion,
- command highlighting,
- output coloring,
- aliases,
- key bindings,
- commands history management,
- other miscellaneous interactive tools (auto_cd, manydots-magic)...

##### `.zlogin` *[Read at login]*

This file is like `.zprofile`, but is read after `.zshrc`. You can consider the shell to be fully set up at .zlogin execution time

So, I use it to launch external commands which do not modify shell behaviors (e.g. a login manager).

##### `.zlogout` *[Read at logout][Within login shell]*

Here, you can clear your terminal or any other resource which was setup at login.

##### How I choose where to put a setting

- if it is needed by a **command run non-interactively**: `.zshenv`
- if it should be **updated on each new shell**: `.zshenv`
- if it runs a command which **may take some time to complete**: `.zprofile`
- if it is related to **interactive usage**: `.zshrc`
- if it is a **command to be run when the shell is fully setup**: `.zlogin`
- if it **releases a resource** acquired at login: `.zlogout`

---

## [Re: ~/.zshenv or ~/.zprofile](https://www.zsh.org/mla/users/2003/msg00600.html)

> I'd like to change the StartupFiles/zshenv file so that it doesn't recommend setting the "path".

I've checked in an improved version of my zshenv file.  In addition to some minor language improvments and the correction of an age-old spelling error, I added a section that attempts to give advice to those that want to use .zshenv to set their PATH.  Namely:

```
Some people insist on setting their PATH here to affect things like ssh. Those that do should probably use $SHLVL to ensure that this only happens the first time the shell is started (to avoid overriding a customized environment).  Also, the various profile/rc/login files all get sourced *after* this file, so they will override this value.  One solution is to put your path-setting code into a file named .zpath, and source it from both here (if we're not a login shell) and from the .zprofile file (which is only sourced if we are a login shell).
```

```
if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
    source ~/.zpath
fi
```

Seems like a pretty good solution to me -- do you agree?

Finally, I'd like to know how to get the zsh.org web sites to update with the new zshenv?  Does this happen automatically?

---

## [Re: do you use separate .zshenv and .zshrc files?](https://www.zsh.org/mla/users/2012/msg00345.html)

> I keep vacillating between wanting to separate my config files into  ``two separate files or keep them in one. 


My config currently spans 19 files, so my bias should be apparent.  I  ``keep everything in ~/.zsh/, except for machine-specific settings, which  ``I put in ~/.zsh.local/.  And ~/.zshenv is a symlink to ~/.zsh/.zshenv,  ``which sets ZDOTDIR to ~/.zsh.  My ~/.zsh/.zshrc sources the other files  ``in ~/.zsh/, most of which have some guard at the top (e.g.  ``~/.zsh/.zsh_screen returns if the `screen` command isn't installed). 

> If I understand ZSH correctly, I could use one file (.zshenv) and put 
>
> the settings which *would* have been in .zshrc into a block like this:
>
> ```
> if [[ -o login ]]
> ```

You want 'interactive' here, not 'login':
`if [[ -o interactive ]]`

> ```
> then
> # do stuff which would have been in .zshrc here
> fi
> ```

`[[ -o login ]]` would catch things that would be done in .zprofile and  ``.zlogin, not those that are done in .zshrc. 

> The reason for doing this is that I tend to forget which file has whatever thing it is that I want to tweak/edit/change/add, and so I end up having to open one, search for what I'm looking for, realize it's in the other file, and then open the other file.
>
> ISTM that it would be easier to just keep everything in one file and separate the login stuff using the `if` statement above.


As pointed out above `.zshenv` vs `.zshrc` isn't a difference of "login" vs.  ``not.  It's "interactive" vs. not. 

Here's the order of the standard four files, and the condition under  ``which they run: 

```
.zshenv: (always)
.zprofile: [[ -o login ]]
.zshrc: [[ -o interactive ]]
.zlogin: [[ -o login ]]
```

To disable all of them, there is the 'NO_RCS' option.
Personally, I don't use `.zprofile` or `.zlogin`, because all of my customization outside of `.zshenv` is only applicable to interactive  shells. 

> Are there any drawbacks to that method?


None that I know of.  If that's how you prefer to organize it, it should  work fine. 

---

## [Why my environment variables are not the same when Pycharm execute the code?](https://stackoverflow.com/questions/72363999/why-my-environment-variables-are-not-the-same-when-pycharm-execute-the-code)

> Note that `.zshrc` is sourced only for interactive shells. It won't be sourced if you run PyCharm from a launcher.

> Thank you so much for your help. So I added  my values and variable in the file /Users/Alisa/.zprofile. Then I  restart the MAC. I relaunch PyCHarm and I still don't get it. So  obviously, I should add my environment variables in a 3rd file  somewhere?

> Use the `.zshenv` instead and make sure you restart PyCharm. Works in PyCharm 2022.2.3 Professional.

---

## [When does one need to export a variable? (duplicate)](https://unix.stackexchange.com/questions/197248/when-does-one-need-to-export-a-variable)

Eons ago, when I first started assigning variables in bash, it was something along the lines of:

```bash
export EDITOR=nano
export PS1=something
```

#### [REPLY](https://unix.stackexchange.com/a/197299/487809)

It's hard to answer that question completel and accurately, because the point of doing `export` is to put a name/value pair (`EDITOR=nano` for example) into the information inherited by a child process of the exporting shell.

In general, you want to export things you set in `.bashrc`: `EDITOR` is a great example because that sets your preference for text editors  that mailers, database interfaces and many other programs use to decide  what program to run when one of those programs wants you to edit some  text. I use `EDITOR=vi` myself. Other common examples from `.bashrc` are `ORACLE_HOME`, `PATH`, `VISUAL`, `TERM` and `SHELL`. I got those by doing `man more`, and reading down to the ENVIRONMENT section.

Now that I've written "in general", I have to note that other than `EDITOR` and `VISUAL`, environment values are many, varied and specific to some subsystem.  Doing anything with the notorious Oracle database system requires lots  of extra environment values, a lot of it by superstition. Because the  shell's environment is a set of name/value pairs, the environment is  used by individual systems in all kinds of different ways. Apache web  server passes a lot of values to `CGI-BIN` programs in the environment.

My advice is to export as few variables as possible. Don't pollute  your interactive environment, as you can never tell when some program  will decide to use your secret environment variable's value. Write small shell scripts that do little more than set environment variables then  run the program that expects those variables.

If you have a large number of environment variables set for your  interactive environment, you will be surprised if you try to run  something from `cron` - `crond` will not set the environment correctly, and you will have no idea of why.

---

## [How can zsh and normal shell share environment variables and aliases without copying each other](https://stackoverflow.com/questions/34565843/how-can-zsh-and-normal-shell-share-environment-variables-and-aliases-without-cop)

Right now I tried to use zsh from normal Ubuntu bash. When I changed to  zsh shell, I found previously environment variables (e.g. JAVA_HOME) in `.bashrc` can not migrate to `.zshrc` automatically. Now I just copy them (export, alias in .bashrc) to `.zshrc`. I want to know is there other convenient way to share these thing in `.bashrc` and do not need copy them explicitly? And even when I add something in `.zshrc` and then change to normal bash still could share them in `.zshrc` without copy them to `.bashrc`.

#### [REPLY](https://stackoverflow.com/a/35808310/21972531)

In `.bashrc` you can use `export` to export a variable (usually in UPPER_CASE) to the environnement that will be sent to commands executed from your shell.

Example of a simple `.bashrc`

```bash
# Here is the content of the .bashrc

export SOMETHING=42
```

Now in bash, after sourcing the bashrc, I have an environnement variable called `SOMETHING` that contains `42`

You can check what is the environnement beeing sent to process with the comand `env`

Now, in the opened `bash`, you can launch `zsh`, then check (with `env`) the zsh's current environnement.

Now in the opened `zsh`, you can just `echo $SOMETHING` and see the answer `42`

note: if you don't know why I used `42` : ([wikipedia](https://en.wikipedia.org/wiki/Phrases_from_The_Hitchhiker's_Guide_to_the_Galaxy))

---

## [I cannot set env variable on zsh](https://unix.stackexchange.com/questions/672471/i-cannot-set-env-variable-on-zsh)

i set env variable

```bash
export DB_USER=something
```

it work but when I close the tab, it does not recognize anymore. I am setting env variable for my django project. When I set on "pycharm"  terminal, it sets it.

```bash
   printenv  DB_USER
```

But when I close pyhcarm, `printenv  DB_USER` does not show any value.

I set it on terminal using one of the tabs. Again, it sets it but  when I close the that specific terminal, it does not recognize that env  value anymore.

When I checked zshenv file:

```bash
 nano /etc/zsh/zshenv
```

I have this on this file

```bash
if [[ -z "$PATH" || "$PATH" == "/bin:/usr/bin" ]]
then
        export PATH="/usr/local/bin:/usr/bin:/bin:/usr/games"
fi
```

the only env variable zsh has PATH. but when i run `env` command i see a big list of env variables but they are not in "zshenv".

#### [REPLY](https://unix.stackexchange.com/a/672483/487809)

When you set the environment variable the way you have, you are only  setting it for the specific session. To set them across all terminal  sessions, in your case you should append the following line to the  .zshrc located in your home directory(or in `/root` if you want it for the root account):

```
export DB_USER=something 
```

For the second part of your question, the path variable is common  across all sessions, but the list of env variables you are seeing upon  running the `env` command are all initialized when the terminal session begins, for example, the `$USER` variable which refers to the user running the session or the `$PWD` variable which refers to the current working directory. As you can  infer, these variables are specific to each instance and are thus  defined for individual sessions unlike the path variable, which is  common for all instances.

#### [REPLY](https://unix.stackexchange.com/a/672474/487809)

Each terminal, whether the system terminal, the Pycharm terminal, or  anything else, is a different shell session and different environment.  What you set in one isn't going to be there in another.

If you want it to be available across sessions, then you'll need to edit the file`/etc/zsh/zprofile`, `etc/zsh/profile`, or `/etc/zsh/zshenv` and add `export DB_USER=something`. That will source it at login for `zsh` which is the shell that you are using. Depending on what you are doing, it's best to use the latter init script so that it is sourced for any  shell init.

---

## [ZSH: Where to place environment variable so that launched application can pick it up?](https://superuser.com/questions/709535/zsh-where-to-place-environment-variable-so-that-launched-application-can-pick-i)

I need an environment variable `KEY="value"` made  available to a GUI application before starting it. The launcher file  (the one that places the icon on the desktop and sidebar in Ubuntu) has a value of `Exec=/path/to/executable/file`.

When using ZSH, where should I define this variable so that it is  available to that application whether I click the application launcher  or whether I directly type /path/to/executable/file in my shell?

In my command line prompt, I tried typing both `KEY="value"` and `export KEY="value"` before clicking the launcher, but it didn't seem to work. I also tried both of those lines in my `~/.zshrc`, did a `source ~/.zshrc` from my shell then clicked the launcher again, but that also didn't work.

Which file should it go in? I believe have a choice of `~/.zshenv`, `~/.zprofile`, `~/.zshrc`, and `~/.zlogin`.

(For bonus points, should I use `export` or not?)

(Am I required to at least log out and log back in, before the  variable becomes available to the application when it's launched from  the launcher?)

#### [REPLY](https://superuser.com/a/709543/1463359)

As you want the variable to be defined as well in your terminal shells (*interactive non-login shell*) and for the desktop launcher icons (X-server started by *non-interactive login shell*) you should put the definition in your `~/.zshenv`.

And yes, you have to restart your x-session in order to have the new  environment available for your desktop icons. Imagine such a startup  scheme: `Graphical Login -> Use your default shell to start the X session -> Desktop -> Shell terminal / Launch program via icon`, so the child shells inherit the environment from the parent, which is  used to start the X session. That shell read the RC-files only once --  on your login to the X session.

For the *bonus point*. This is what the manual says:

> `export [ name[=value] ... ]`                The specified names are marked for automatic export to the environment of subsequently executed commands. (...)

If you define your variable in `~/.zshenv`, you can in principle omit the `export` as this file is read in by default. The only difference arises if you start a shell with `zsh -f`, which sources no RC files. A little demonstration:

```bash
% foo=foo_defined
% export bar=bar_defined
% print -l $foo $bar
foo_defined
bar_defined
% zsh -f
% print -l $foo $bar
bar_defined
% 
```

I. e. only the exported `$bar` is defined in subsequent shells. But to be on the safe side, use `export` -- I can't think of a case where this is harmful.

> By default shell do you mean the one in  /etc/passwd? Let's say someone uses bash as their default shell but has  gnome-terminal configured to automatically open up in ZSH. In that case  will .zshenv be read on startup? If not, is there a shell-independent  file that can be used to place variables like this? (I know there's  things like ~/.profile and ~/.pam_environment described at [help.ubuntu.com/community/EnvironmentVariables](https://help.ubuntu.com/community/EnvironmentVariables), but how do those fit in with your answer of ~/.zshenv?)

> @user779159 : Yes, by *default shell* I meant that one defined in `/etc/passwd`. `zshenv` is `zsh` specific, so is not read in by `bash`, `csh` or whatsoever. My answer applied only to `zsh`, according to your question tag. In an inhomogeneous setup (default  shell other that gnome-terminal shell), the possibilities in your link  seem sensible. I would put the variable in `~/.profile` and made `zsh` in gnome-terminal a *login shell* by using `zsh -l` as startup command.

> I don't believe that @mpy is correct that you can omit the export  statement. The presence/absence of export determines whether or not  processes launched from that shell will inherit the environment  variable. If you don't export, `xserver` will not inherit the environment  variable

---

## [Using export in .bashrc](https://unix.stackexchange.com/questions/107851/using-export-in-bashrc)

I have noticed in my `.bashrc` that some lines have `export` in front of them, such as

```bash
export HISTTIMEFORMAT="%b-%d  %H:%M  "
...
export MYSQL_HISTFILE="/root/.mysql_history"
```

whereas others don't, such as 

```bash
HISTSIZE=100000
```

I am wondering if, first, this is correct, and second what the rule is for using `export` in `.bashrc`.

#### [REPLY](https://unix.stackexchange.com/a/107853/487809)

You only need `export` for variables that should be "seen" by other programs which you launch in the shell, while the ones that  are only used inside the shell itself don't need to be `export`ed.

This is what the man page says:

```none
The  supplied  names are marked for automatic export to the environ‐
ment of subsequently executed commands.  If the -f option is  given,
the  names  refer to functions.  If no names are given, or if the -p
option is supplied, a list of all names that are  exported  in  this
shell  is  printed.   The -n option causes the export property to be
removed from each name.  If a variable name is  followed  by  =word,
the  value  of  the variable is set to word.  export returns an exit
status of 0 unless an invalid option  is  encountered,  one  of  the
names  is  not a valid shell variable name, or -f is supplied with a
name that is not a function.
```

This can be demonstrated with the following:

```bash
$ MYVAR="value"
$ echo ${MYVAR}
value
$ echo 'echo ${MYVAR}' > echo.sh
$ chmod +x echo.sh
$ ./echo.sh

$ export MYVAR="value-exported"
$ ./echo.sh
value-exported
```

Explanation:

- I first set `${MYVAR}` to be a Shell variable with `MYVAR="value"`. Using `echo` I can echo the value of it because echo is part of the shell.
- Then I create `echo.sh`. That's a little script that basically does the same, it just echoes `${MYVAR}`, but the difference is that it will run in a different process because it's a separate script.
- When calling `echo.sh` it outputs nothing, because the new process does not inherit `${MYVAR}`
- Then I export `${MYVAR}` into my environment with the `export` keyword
- When I now run the same `echo.sh` again, it echoes the content of `${MYVAR}` because it gets it from the environment

So to answer your question:

It depends where a variable is going to be used, whether you have to export it or not.

#### [REPLY](https://unix.stackexchange.com/a/197333/487809)

Use `export` for [environment variables](https://en.wikipedia.org/wiki/Environment_variable). Environment variables are an operating system feature. Environment  variables are inherited by child processes: if you set them in a shell,  they're available in all the programs started by this shell. Variables  used by many applications or by specific applications other than shells  are environment variables. Here are a few examples of common environment variables:

- `HOME` — indicates the user's home directory, which is  where per-user configuration files are located. Used by any program that reads per-user configuration files or otherwise needs to know the  location of the user's home directory.
- `PATH` — indicates where to find executable files to launch other programs. Used by every program that needs to start another program.
- `LD_LIBRARY_PATH` — indicates where to find dynamic library files. Used by every dynamically linked executable.
- `EDITOR`, `VISUAL` — indicates what program to run when an editor is needed. Used by any program that needs to launch a text editor.
- `DISPLAY`, `XAUTHORITY` — indicates how to connect to the X11 server. Used by X11 clients (i.e. GUI programs).
- `LESS` — options automatically turned on when `less` is run. Used by `less`.
- `http_proxy` — indicates the web proxy to use. Used by most web browsers.

Do not use `export` for shell variables. Shell variables  are a feature of the shell as a programming language. Shell variables  are used only inside the shell where they are set; they have no meaning  to programs launched by the shell. Shell variables are duplicated when a subshell is created, like the rest of the shell state. Here are a few  examples of shell variables that have a meaning to popular shells:

- `PS1` — the prompt to display before each command.
- `IFS` — the characters that separate words in unquoted variable expansions and command substitutions.
- `HISTFILE` — a file where the shell will write the command history.

In addition to variables that are used by the shell, most shell scripts use variables for their internal purposes.

Most environment variables (e.g. `PATH`) make sense for a whole session, and should be set in `~/.profile` or a similar file. Variables that make sense only to a specific shell (e.g. `PS1`) should be set in a shell-specific file such as `~/.bashrc` or `~/.zshrc`. See [Is there a ".bashrc" equivalent file read by all shells?](https://unix.stackexchange.com/questions/3052/alternative-to-bashrc/3085#3085)

---

## [Difference between Login Shell and Non-Login Shell?](https://unix.stackexchange.com/questions/38175/difference-between-login-shell-and-non-login-shell)

A login shell is the first process that executes under your user ID  when you log in for an interactive session. The login process tells the  shell to behave as a login shell with a convention: passing argument 0,  which is normally the name of the shell executable, with a `-` character prepended (e.g. `-bash` whereas it would normally be `bash`. Login shells typically read a file that does things like setting environment variables: `/etc/profile` and `~/.profile` for the traditional Bourne shell, `~/.bash_profile` additionally for bash†, `/etc/zprofile` and `~/.zprofile` for zsh†, `/etc/csh.login` and `~/.login` for csh, etc.

When you log in on a text console, or through SSH, or with `su -`, you get an **interactive login** shell. When you log in in graphical mode (on an [X display manager](http://en.wikipedia.org/wiki/X_display_manager_(program_type))), you don't get a login shell, instead you get a session manager or a window manager.

It's rare to run a **non-interactive login** shell, but  some X settings do that when you log in with a display manager, so as to arrange to read the profile files. Other settings (this depends on the  distribution and on the display manager) read `/etc/profile` and `~/.profile` explicitly, or don't read them. Another way to get a non-interactive  login shell is to log in remotely with a command passed through standard input which is not a terminal, e.g. `ssh example.com <my-script-which-is-stored-locally` (as opposed to `ssh example.com my-script-which-is-on-the-remote-machine`, which runs a non-interactive, non-login shell).

When you start a shell in a terminal in an existing session (screen, X terminal, Emacs terminal buffer, a shell inside another, etc.), you get an **interactive, non-login** shell. That shell might read a shell configuration file (`~/.bashrc` for bash invoked as `bash`, `/etc/zshrc` and `~/.zshrc` for zsh, `/etc/csh.cshrc` and `~/.cshrc` for csh, the file indicated by the `ENV` variable for POSIX/XSI-compliant shells such as dash, ksh, and bash when invoked as `sh`, `$ENV` if set and `~/.mkshrc` for mksh, etc.).

When a shell runs a script or a command passed on its command line, it's a **non-interactive, non-login** shell. Such shells run all the time: it's very common that when a  program calls another program, it really runs a tiny script in a shell  to invoke that other program. Some shells read a startup file in this  case (bash runs the file indicated by the `BASH_ENV` variable, zsh runs `/etc/zshenv` and `~/.zshenv`), but this is risky: the shell can be invoked in all sorts of contexts,  and there's hardly anything you can do that might not break something.

† I'm simplifying a little, see the manual for the gory details.

---

## [Where to place $PATH variable assertions in zsh?](https://stackoverflow.com/questions/10574684/where-to-place-path-variable-assertions-in-zsh)

tl;dr version: use `~/.zshrc`

And [read the man page](http://linux.die.net/man/1/zshall) to understand the differences between: 

> `~/.zshrc`, `~/.zshenv` and `~/.zprofile`. 

##### Regarding my comment

In my comment attached to the answer [kev gave](https://stackoverflow.com/a/10576306/1084945), I said:

> This seems to be incorrect - /etc/profile isn't listed in any zsh documentation I can find.

This turns out to be partially incorrect: `/etc/profile` *may* be sourced by `zsh`. **However**, this only occurs if `zsh` is "invoked as `sh` or `ksh`"; in these compatibility modes:

> The usual zsh startup/shutdown scripts are not executed. Login  shells source /etc/profile followed by $HOME/.profile. If the ENV  environment variable is set on invocation, $ENV is sourced after the  profile scripts. The value of ENV is subjected to parameter expansion,  command substitution, and arithmetic expansion before being interpreted  as a pathname. [[man zshall, "Compatibility"](http://linux.die.net/man/1/zshall)]. 

The [ArchWiki ZSH link](https://wiki.archlinux.org/index.php/Zsh) says:

> At login, Zsh sources the following files in this order:
> /etc/profile
> This file is sourced by all Bourne-compatible shells upon login

This implys that `/etc/profile` is *always read* by `zsh` at login - I haven't got any experience with the Arch Linux project; the wiki may be correct for that distribution, but it is *not* generally correct. The information **is** incorrect compared to the zsh manual pages, and doesn't seem to apply to zsh on OS X (paths in `$PATH` set in `/etc/profile` do not make it to my zsh sessions). 

##### To address the question:

> where exactly should I be placing my rvm, python, node etc additions to my $PATH?

Generally, I would export my `$PATH` from `~/.zshrc`, but it's worth having a read of the [zshall](http://linux.die.net/man/1/zshall) man page, specifically the "STARTUP/SHUTDOWN FILES" section - `~/.zshrc` is read for *interactive* shells, which may or may not suit your needs - if you want the `$PATH` for every `zsh` shell invoked by you (both `interactive` and not, both `login` and not, etc), then `~/.zshenv` is a better option. 

> Is there a specific file I should be using (i.e. .zshenv which does not currently exist in my installation), one of the ones I am currently using, or does it even matter?

There's a bunch of files read on startup (check the linked `man` pages), and there's a reason for that - each file has it's particular  place (settings for every user, settings for user-specific, settings for login shells, settings for every shell, etc).
 Don't worry about `~/.zshenv` not existing - if you need it, make it, and it will be read.

`.bashrc` and `.bash_profile` are **not** read by `zsh`, unless you explicitly source them from `~/.zshrc` or similar; the syntax between `bash` and `zsh` is *not* always compatible. Both `.bashrc` and `.bash_profile` are designed for `bash` settings, not `zsh` settings. 

#### [REPLY: `zsh.1.gz` Man Page](https://manpages.ubuntu.com/manpages/lunar/en/man1/zsh.1.html)

Here is the docs from the zsh man pages under STARTUP/SHUTDOWN FILES section.

##### **STARTUP/SHUTDOWN** **FILES**

```
Commands are first read from  /etc/zsh/zshenv;  this  cannot  be  overridden.   Subsequent
behaviour  is  modified  by the RCS and GLOBAL_RCS options; the former affects all startup
files, while the second only affects global startup files (those shown here with  an  path
starting  with  a /).  If one of the options is unset at any point, any subsequent startup
file(s) of the corresponding type will not be read.  It is also possible  for  a  file  in
$ZDOTDIR to re-enable GLOBAL_RCS. Both RCS and GLOBAL_RCS are set by default.

Commands are then read from $ZDOTDIR/.zshenv.  If the shell is a login shell, commands are
read  from  /etc/zsh/zprofile  and  then  $ZDOTDIR/.zprofile.   Then,  if  the  shell   is
interactive,  commands are read from /etc/zsh/zshrc and then $ZDOTDIR/.zshrc.  Finally, if
the shell is a login shell, /etc/zsh/zlogin and $ZDOTDIR/.zlogin are read.

When a login shell exits, the files $ZDOTDIR/.zlogout and then /etc/zsh/zlogout are  read.
This  happens with either an explicit exit via the exit or logout commands, or an implicit
exit by reading end-of-file from the terminal.  However, if the shell  terminates  due  to
exec'ing  another  process, the logout files are not read.  These are also affected by the
RCS and GLOBAL_RCS options.  Note also that the RCS option affects the saving  of  history
files, i.e. if RCS is unset when the shell exits, no history file will be saved.

If  ZDOTDIR is unset, HOME is used instead.  Files listed above as being in /etc may be in
another directory, depending on the installation.

As /etc/zsh/zshenv is run for all instances of zsh, it is important that  it  be  kept  as
small  as possible.  In particular, it is a good idea to put code that does not need to be
run for every single shell behind a test of the form `if [[ -o rcs ]]; then ...'  so  that
it will not be executed when zsh is invoked with the `-f' option.

Any of  these  files  may  be  pre-compiled  with  the  zcompile  builtin  command  (see
zshbuiltins(1)).  If a compiled file exists (named for the original  file  plus  the  .zwc
extension) and it is newer than the original file, the compiled file will be used instead.
```

From this we can see the order files are read is:

```bash
/etc/zshenv    # Read for every shell
~/.zshenv      # Read for every shell except ones started with -f
/etc/zprofile  # Global config for login shells, read before zshrc
~/.zprofile    # User config for login shells
/etc/zshrc     # Global config for interactive shells
~/.zshrc       # User config for interactive shells
/etc/zlogin    # Global config for login shells, read after zshrc
~/.zlogin      # User config for login shells
~/.zlogout     # User config for login shells, read upon logout
/etc/zlogout   # Global config for login shells, read after user logout file
```

---

## [A User's Guide to the Z-Shell](https://zsh.sourceforge.io/Guide/zshguide02.html)

#### 2.2: All the startup files

Now here's a list of the startup files and when they're run.  You'll see they fall into two classes: those in the `/etc` directory, which are put there by the system administrator and are run for all users, and those in your home directory, which zsh, like many shells, allows you to abbreviate to a ``~`'.  It's possible that the latter files are somewhere else; type ``print $ZDOTDIR`' and if you get something other than a blank line, or an error message telling you the parameter isn't set, it's telling you a directory other than ``~`' where your startup files live. If `$ZDOTDIR` (another parameter) is not already set, you won't want to set it without a good reason.

- **`/etc/zshenv`**

  ​    Always run for every zsh.  

- **`~/.zshenv`**

  ​      Usually run for every zsh (see below).  

- **`/etc/zprofile`**

    Run for login shells.  

- **`~/.zprofile`**

  ​    Run for login shells.  

- **`/etc/zshrc`**

  ​     Run for interactive shells.  

- **`~/.zshrc`**

  ​       Run for interactive shells.  

- **`/etc/zlogin`**

  ​    Run for login shells.  

- **`~/.zlogin`**

  ​      Run for login shells.

#### 2.5.10: Environment variables

Often, the manual for a programme will tell you to define certain environment variables, usually a collection of uppercase letters with maybe numbers and the odd underscore.  These can pass information to the programme without you needing to use extra arguments.  In zsh, environment variables appear as ordinary shell parameters, although they have to be defined slightly differently: strictly, the environment is a special region outside the shell, and zsh has to be told to put a copy there as well as keeping one of its own.  The usual syntax is

```
  export VARNAME='value'
```

in other words, like an ordinary assignment, but with ``export`' in front.  Note there is no ``$`' before the name of the environment variable; all ``export`' and similar statements work the same way. The easiest place to put these is in `.zshenv` --- hence it's name. Environment variables will be passed to any programmes run from a shell, so it may be enough to define them in `.zlogin` or `.zprofile`:  however, any shell started for you non-interactively won't run those, and there are other possible problems if you use a windowing system which is started by a shell other than zsh or which doesn't run a shell start-up file at all --- I had to tweak mine to make it do so.  So `.zshenv` is the safest place; it doesn't take long to define environment variables.  Other people will no doubt give you completely contradictory views, but that's people for you.

Note that you can't export arrays.  If you export a parameter, then assign an array to it, nothing will appear in the environment; you can use the external command ``printenv VARNAME`' (again no ``$`' because the command needs to know the name, not the value) to check.  There's a more subtle problem with arrays, too.  The `export` builtin is just a special case of the builtin **typeset**, which defines a variable without marking it for export to the environment.  You might think you could do

```
  typeset array=(this doesn\'t work)
```

but you can't --- the special array syntax is only understood when the assignment does not follow a command, not in normal arguments like the case here, so you have to put the array assignment on the next line.  This is a very easy mistake to make.  More uses of `typeset` will be described in [chapter 3](https://zsh.sourceforge.io/Guide/zshguide03.html#syntax); they include creating local parameters in functions, and defining special attributes (of which the `export' attribute is just one) for parameters.

#### 2.5.11: Path

It helps to be able to find external programmes, i.e. anything not part of the shell, any command other than a builtin, function or alias.  The `$path` array is used for this.  Actually, what the system needs is the environment variable `$PATH`, which contains a list of directories in which to search for programmes, separated from each other by a colon. These directories are the individual components of the array `$path`.  So if `$path` contains

```
  path=(/bin /usr/bin /usr/local/bin .)
```

then `$PATH` will automatically contain the effect of

```
  PATH=/bin:/usr/bin:/usr/local/bin:.
```

without you having to set that.  The idea is simply that, while the system needs `$PATH` because it doesn't understand arrays, it's much more flexible to be able to use arrays within the shell and hence pretty much forget about the `$PATH` form.

Changes to the path are similar to changes to environment variables described above, so all that applies.  There's a slight difficulty in setting `$path` in `.zshenv` however, even though the reasons given above for doing so still apply.  Usually, the path will be set for you, either by the system, or by the system administrator in one of the global start up files, and if you change path you will simply want to add to it. But if your `.zshenv` contains

```
  path=(~/bin ~/progs/bin $path)
```

--- which is the right way of adding something to the front of `$path` --- then every time `.zshenv` is called, `~/bin` and `~/progs/bin` are stuck in front, so if you start another zsh you will have two sets there.

You can add tests to see if something's already there, of course.  Zsh conveniently allows you to test for the existence of elements in an array. By preceding an array index by `(r)` (for reverse), it will try to find a matching element and return that, else an empty string.  Here's a way of doing that (but don't add this yet, see the next paragraph):

```
  for dir in ~/bin ~/progs/bin; do
    if [[ -z ${path[(r)$dir]} ]]; then
      path=($dir $path)
    fi 
  done
```

That `for`... `do` ... `done` is another special shell construct. It takes each thing after ``in`' and assigns it in turn to the parameter named before the ``in`' --- `$dir`, but because this is a form of assignment, the ``$`' is left off --- so the first time round it has the effect of `dir=~/bin`, and the next time `dir=~/progs/bin`. Then it executes what's in the loop. The test `-z` checks that what follows is empty:  in this case it will be if the directory `$dir` is not yet in `$path`, so it goes ahead and adds it in front.  Note that the directories get added in the reverse of the order they appear.

Actually, however, zsh takes all that trouble away from you.  The incantation ``typeset -U path`', where the `-U` stands for unique, tells the shell that it should not add anything to `$path` if it's there already.  To be precise, it keeps only the left-most occurrence, so if you added something at the end it will disappear and if you added something at the beginning, the old one will disappear.  Thus the following works nicely in `.zshenv`:

```
  typeset -U path
  path=(~/bin ~/progs/bin $path)
```

and you can put down that ``for`' stuff as a lesson in shell programming. You can list all the variables which have uniqueness turned on by typing ``typeset +U`', with ``+`' instead of ``-`', because in the latter case the shell would show the values of the parameters as well, which isn't what you need here.  The `-U` flag will also work with colon-separated arrays, like `$PATH`.

---

## [An Introduction to the Z Shell - Startup Files](https://zsh.sourceforge.io/Intro/intro_3.html#SEC3)

There are five startup files that zsh will read commands from:

```
https://zsh-manual.netlify.app/the-z-shell-manual$ZDOTDIR/.zshenv
$ZDOTDIR/.zprofile
$ZDOTDIR/.zshrc
$ZDOTDIR/.zlogin
$ZDOTDIR/.zlogout
```

If `ZDOTDIR` is not set, then the value of `HOME` is used; this is the usual case.

`.zshenv` is sourced on all invocations of the shell, unless the `-f` option is set.  It should contain commands to set the command search path, plus other important environment variables.  ``.zshenv'` should not contain commands that produce output or assume the shell is attached to a tty.

`.zshrc` is sourced in interactive shells.  It should contain commands to set up aliases, functions, options, key bindings, etc.

`.zlogin` is sourced in login shells.  It should contain commands that should be executed only in login shells.  ``.zlogout'` is sourced when login shells exit.  ``.zprofile'` is similar to ``.zlogin'`, except that it is sourced before ``.zshrc'`. ``.zprofile'` is meant as an alternative to ``.zlogin'` for ksh fans; the two are not intended to be used together, although this could certainly be done if desired.  ``.zlogin'` is not the place for alias definitions, options, environment variable settings, etc.; as a general rule, it should not change the shell environment at all.  Rather, it should be used to set the terminal type and run a series of external commands (`fortune`, `msgs`, etc).

---

## [17 Shell Builtin Commands](https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html)

```
export [ name[=value] ... ]
```

The specified names are marked for automatic export to the environment of subsequently executed commands. Equivalent to `typeset -gx`. If a parameter specified does not already exist, it is created in the global scope.

```
typeset [ {+|-}AHUaghlmrtux ] [ {+|-}EFLRZip [ n ] ]
        [ + ] [ name[=value] ... ]
typeset -T [ {+|-}Uglrux ] [ {+|-}LRZp [ n ] ]
        [ + | SCALAR[=value] array[=(value ...)] [ sep ] ]
typeset -f [ {+|-}TUkmtuz ] [ + ] [ name ... ]
```

Set or display attributes and values for shell parameters.

Except as noted below for control flags that change the behavior, a parameter is created for each name that does not already refer to one.  When inside a function, a new parameter is created for every name (even those that already exist), and is unset again when the function completes.  See [Local Parameters](https://zsh.sourceforge.io/Doc/Release/Parameters.html#Local-Parameters).  The same rules apply to special shell parameters, which retain their special attributes when made local.

For each name`=`value assignment, the parameter name is set to value.  If the assignment is omitted and name does *not* refer to an existing parameter, a new parameter is intialized to empty string, zero, or empty array (as appropriate), *unless* the shell option `TYPESET_TO_UNSET` is set.  When that option is set, the parameter attributes are recorded but the parameter remains unset.

If the shell option `TYPESET_SILENT` is not set, for each remaining name that refers to a parameter that is already set, the name and value of the parameter are printed in the form of an assignment. Nothing is printed for newly-created parameters, or when any attribute flags listed below are given along with the name.  Using ‘`+`’ instead of minus to introduce an attribute turns it off.

If no name is present, the names and values of all parameters are printed.  In this case the attribute flags restrict the display to only those parameters that have the specified attributes, and using ‘`+`’ rather than ‘`-`’ to introduce the flag suppresses printing of the values of parameters when there is no parameter name.

All forms of the command handle scalar assignment.  Array assignment is possible if any of the reserved words `declare`, `export`, `float`, `integer`, `local`, `readonly` or `typeset` is matched when the line is parsed (N.B. not when it is executed).  In this case the arguments are parsed as assignments, except that the ‘`+=`’ syntax and the `GLOB_ASSIGN` option are not supported, and scalar values after `=` are *not* split further into words, even if expanded (regardless of the setting of the `KSH_TYPESET` option; this option is obsolete).

Examples of the differences between command and reserved word parsing:

```
# Reserved word parsing
typeset svar=$(echo one word) avar=(several words)
```

The above creates a scalar parameter `svar` and an array parameter `avar` as if the assignments had been

```
svar="one word"
avar=(several words)
```

On the other hand:

```
# Normal builtin interface
builtin typeset svar=$(echo two words)
```

The `builtin` keyword causes the above to use the standard builtin interface to `typeset` in which argument parsing is performed in the same way as for other commands.  This example creates a scalar `svar` containing the value `two` and another scalar parameter `words` with no value.  An array value in this case would either cause an error or be treated as an obscure set of glob qualifiers.

Arbitrary arguments are allowed if they take the form of assignments after command line expansion; however, these only perform scalar assignment:

```
var='svar=val'
typeset $var
```

The above sets the scalar parameter `svar` to the value `val`. Parentheses around the value within `var` would not cause array assignment as they will be treated as ordinary characters when `$var` is substituted.  Any non-trivial expansion in the name part of the assignment causes the argument to be treated in this fashion:

```
typeset {var1,var2,var3}=name
```

The above syntax is valid, and has the expected effect of setting the three parameters to the same value, but the command line is parsed as a set of three normal command line arguments to `typeset` after expansion.  Hence it is not possible to assign to multiple arrays by this means.

Note that each interface to any of the commands may be disabled separately.  For example, ‘`disable -r typeset`’ disables the reserved word interface to `typeset`, exposing the builtin interface, while ‘`disable typeset`’ disables the builtin.  Note that disabling the reserved word interface for `typeset` may cause problems with the output of ‘`typeset -p`’, which assumes the reserved word interface is available in order to restore array and associative array values.

Unlike parameter assignment statements, `typeset`’s exit status on an assignment that involves a command substitution does not reflect the exit status of the command substitution.  Therefore, to test for an error in a command substitution, separate the declaration of the parameter from its initialization:

```
# WRONG
typeset var1=$(exit 1) || echo "Trouble with var1"

# RIGHT
typeset var1 && var1=$(exit 1) || echo "Trouble with var1"
```

To initialize a parameter param to a command output and mark it readonly, use `typeset -r `param or `readonly `param after the parameter assignment statement.

If no attribute flags are given, and either no name arguments are present or the flag `+m` is used, then each parameter name printed is preceded by a list of the attributes of that parameter (`array`, `association`, `exported`, `float`, `integer`, `readonly`, or `undefined` for autoloaded parameters not yet loaded).  If `+m` is used with attribute flags, and all those flags are introduced with `+`, the matching parameter names are printed but their values are not.

The following control flags change the behavior of `typeset`:

- `+`

  If ‘`+`’ appears by itself in a separate word as the last option, then the names of all parameters (functions with `-f`) are printed, but the values (function bodies) are not.  No name arguments may appear, and it is an error for any other options to follow ‘`+`’.  The effect of ‘`+`’ is as if all attribute flags which precede it were given with a ‘`+`’ prefix.  For example, ‘`typeset -U +`’ is equivalent to ‘`typeset +U`’ and displays the names of all arrays having the uniqueness attribute, whereas ‘`typeset -f -U +`’ displays the names of all autoloadable functions.  If `+` is the only option, then type information (array, readonly, etc.) is also printed for each parameter, in the same manner as ‘`typeset +m "*"`’.

- `-g`

  The `-g` (global) means that any resulting parameter will not be restricted to local scope.  Note that this does not necessarily mean that the parameter will be global, as the flag will apply to any existing parameter (even if unset) from an enclosing function.  This flag does not affect the parameter after creation, hence it has no effect when listing existing parameters, nor does the flag `+g` have any effect except in combination with `-m` (see below).

- `-m`

  If the `-m` flag is given the name arguments are taken as patterns (use quoting to prevent these from being interpreted as file patterns). With no attribute flags, all parameters (or functions with the `-f` flag) with matching names are printed (the shell option `TYPESET_SILENT` is not used in this case). If the `+g` flag is combined with `-m`, a new local parameter is created for every matching parameter that is not already local.  Otherwise `-m` applies all other flags or assignments to the existing parameters. Except when assignments are made with name`=`value, using `+m` forces the matching parameters and their attributes to be printed, even inside a function.  Note that `-m` is ignored if no patterns are given, so ‘`typeset -m`’ displays attributes but ‘`typeset -a +m`’ does not.

- `-p` [ n ]

  If the `-p` option is given, parameters and values are printed in the form of a typeset command with an assignment, regardless of other flags and options.  Note that the `-H` flag on parameters is respected; no value will be shown for these parameters. `-p` may be followed by an optional integer argument.  Currently only the value `1` is supported.  In this case arrays and associative arrays are printed with newlines between indented elements for readability.

- `-T` [ scalar[`=`value] array[`=(`value ...`)`] [ sep ] ]

  This flag has a different meaning when used with `-f`; see below. Otherwise the `-T` option requires zero, two, or three arguments to be present.  With no arguments, the list of parameters created in this fashion is shown.  With two or three arguments, the first two are the name of a scalar and of an array parameter (in that order) that will be tied together in the manner of `$PATH` and `$path`.  The optional third argument is a single-character separator which will be used to join the elements of the array to form the scalar; if absent, a colon is used, as with `$PATH`.  Only the first character of the separator is significant; any remaining characters are ignored.  Multibyte characters are not yet supported. Only one of the scalar and array parameters may be assigned an initial value (the restrictions on assignment forms described above also apply). Both the scalar and the array may be manipulated as normal.  If one is unset, the other will automatically be unset too.  There is no way of untying the variables without unsetting them, nor of converting the type of one of them with another `typeset` command; `+T` does not work, assigning an array to scalar is an error, and assigning a scalar to array sets it to be a single-element array. Note that both ‘`typeset -xT ...`’  and ‘`export -T ...`’ work, but only the scalar will be marked for export.  Setting the value using the scalar version causes a split on all separators (which cannot be quoted). It is possible to apply `-T` to two previously tied variables but with a different separator character, in which case the variables remain joined as before but the separator is changed. When an existing scalar is tied to a new array, the value of the scalar is preserved but no attribute other than export will be preserved.

Attribute flags that transform the final value (`-L`, `-R`, `-Z`, `-l`, `-u`) are only applied to the expanded value at the point of a parameter expansion expression using ‘`$`’.  They are not applied when a parameter is retrieved internally by the shell for any purpose. 

The following attribute flags may be specified:

- `-A`

  The names refer to associative array parameters; see [Array Parameters](https://zsh.sourceforge.io/Doc/Release/Parameters.html#Array-Parameters).

- `-L` [ n ]

  Left justify and remove leading blanks from the value when the parameter is expanded. If n is nonzero, it defines the width of the field. If n is zero, the width is determined by the width of the value of the first assignment.  In the case of numeric parameters, the length of the complete value assigned to the parameter is used to determine the width, not the value that would be output. The width is the count of characters, which may be multibyte characters if the `MULTIBYTE` option is in effect.  Note that the screen width of the character is not taken into account; if this is required, use padding with parameter expansion flags `${(ml`...`)`...`}` as described in ‘Parameter Expansion Flags’ in [Parameter Expansion](https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion). When the parameter is expanded, it is filled on the right with blanks or truncated if necessary to fit the field. Note truncation can lead to unexpected results with numeric parameters. Leading zeros are removed if the `-Z` flag is also set.

- `-R` [ n ]

  Similar to `-L`, except that right justification is used; when the parameter is expanded, the field is left filled with blanks or truncated from the end.  May not be combined with the `-Z` flag.

- `-U`

  For arrays (but not for associative arrays), keep only the first occurrence of each duplicated value.  This may also be set for tied parameters (see `-T`) or colon-separated special parameters like `PATH` or `FIGNORE`, etc.  Note the flag takes effect on assignment, and the type of the variable being assigned to is determinative; for variables with shared values it is therefore recommended to set the flag for all interfaces, e.g. ‘`typeset -U PATH path`’. This flag has a different meaning when used with `-f`; see below.

- `-Z` [ n ]

  Specially handled if set along with the `-L` flag. Otherwise, similar to `-R`, except that leading zeros are used for padding instead of blanks if the first non-blank character is a digit. Numeric parameters are specially handled: they are always eligible for padding with zeroes, and the zeroes are inserted at an appropriate place in the output.

- `-a`

  The names refer to array parameters.  An array parameter may be created this way, but it may be assigned to in the `typeset` statement only if the reserved word form of `typeset` is enabled (as it is by default).  When displaying, both normal and associative arrays are shown.

- `-f`

  The names refer to functions rather than parameters.  No assignments can be made, and the only other valid flags are `-t`, `-T`, `-k`, `-u`, `-U` and `-z`.  The flag `-t` turns on execution tracing for this function; the flag `-T` does the same, but turns off tracing for any named (not anonymous) function called from the present one, unless that function also has the `-t` or `-T` flag.  The `-u` and `-U` flags cause the function to be marked for autoloading; `-U` also causes alias expansion to be suppressed when the function is loaded.  See the description of the ‘`autoload`’ builtin for details. Note that the builtin `functions` provides the same basic capabilities as `typeset -f` but gives access to a few extra options; `autoload` gives further additional options for the case `typeset -fu` and `typeset -fU`.

- `-h`

  Hide: only useful for special parameters (those marked ‘<S>’ in the table in [Parameters Set By The Shell](https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Set-By-The-Shell)), and for local parameters with the same name as a special parameter, though harmless for others.  A special parameter with this attribute will not retain its special effect when made local.  Thus after ‘`typeset -h PATH`’, a function containing ‘`typeset PATH`’ will create an ordinary local parameter without the usual behaviour of `PATH`.  Alternatively, the local parameter may itself be given this attribute; hence inside a function ‘`typeset -h PATH`’ creates an ordinary local parameter and the special `PATH` parameter is not altered in any way.  It is also possible to create a local parameter using ‘`typeset +h `special’, where the local copy of special will retain its special properties regardless of having the `-h` attribute.  Global special parameters loaded from shell modules (currently those in `zsh/mapfile` and `zsh/parameter`) are automatically given the `-h` attribute to avoid name clashes.

- `-H`

  Hide value: specifies that `typeset` will not display the value of the parameter when listing parameters; the display for such parameters is always as if the ‘`+`’ flag had been given.  Use of the parameter is in other respects normal, and the option does not apply if the parameter is specified by name, or by pattern with the `-m` option.  This is on by default for the parameters in the `zsh/parameter` and `zsh/mapfile` modules.  Note, however, that unlike the `-h` flag this is also useful for non-special parameters.

- `-i` [ n ]

  Use an internal integer representation.  If n is nonzero it defines the output arithmetic base, otherwise it is determined by the first assignment.  Bases from 2 to 36 inclusive are allowed.

- `-E` [ n ]

  Use an internal double-precision floating point representation.  On output the variable will be converted to scientific notation.  If n is nonzero it defines the number of significant figures to display; the default is ten.

- `-F` [ n ]

  Use an internal double-precision floating point representation.  On output the variable will be converted to fixed-point decimal notation.  If n is nonzero it defines the number of digits to display after the decimal point; the default is ten.

- `-l`

  Convert the result to lower case whenever the parameter is expanded. The value is *not* converted when assigned.

- `-r`

  The given names are marked readonly.  Note that if name is a special parameter, the readonly attribute can be turned on, but cannot then be turned off. If the `POSIX_BUILTINS` option is set, the readonly attribute is more restrictive: unset variables can be marked readonly and cannot then be set; furthermore, the readonly attribute cannot be removed from any variable. It is still possible to change other attributes of the variable though, some of which like `-U` or `-Z` would affect the value. More generally, the readonly attribute should not be relied on as a security mechanism. Note that in zsh (like in pdksh but unlike most other shells) it is still possible to create a local variable of the same name as this is considered a different variable (though this variable, too, can be marked readonly). Special variables that have been made readonly retain their value and readonly attribute when made local.

- `-t`

  Tags the named parameters.  Tags have no special meaning to the shell. This flag has a different meaning when used with `-f`; see above.

- `-u`

  Convert the result to upper case whenever the parameter is expanded. The value is *not* converted when assigned. This flag has a different meaning when used with `-f`; see above.

- `-x`

  Mark for automatic export to the environment of subsequently executed commands.  If the option `GLOBAL_EXPORT` is set, this implies the option `-g`, unless `+g` is also explicitly given; in other words the parameter is not made local to the enclosing function.  This is for compatibility with previous versions of zsh.
