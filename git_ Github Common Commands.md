



## [How to Recursively Add Files and Folders in Git](https://linuxhint.com/recursively-add-files-and-folders-in-git/)

Execute the `git add` command and specify the filename to add it recursively into the Git directory:

```bash
git add file1.txt
```

Commit changes to the Git local repository with a message using the “**-m**” option:

```bash
git commit -m "one file added"
```

Recursively Add Multiple Files using the `git add ` command:

```bash
git add .
```

Commit the changes

```bash
git commit -m "multiple files added"
```



## [Recursively add the entire folder to a repository](https://stackoverflow.com/questions/17743549/recursively-add-the-entire-folder-to-a-repository)

I am trying to add a branch to the master branch on GitHub and push a folder onto that branch.

The folder structure of the branch looks like - `SocialApp/SourceCode/DevTrunk/SocialApp` and all the source code files are in the last folder.

I am using the following Git commands:

```
git add *
git commit -m with the message
git push
```

This is pushing only the first folder "*SocialApp*" onto GitHub and ignoring the folder SourceCode that is inside the folder. How do I fix this?

---

> are there files anywhere? aren't they ignored in `.gitignore`? – 
>
> This is pushing only the first folder - git doesn't care about folders at all, only files. please show the commit - you've either committed a submodule, a symlink or something else that's not a folder – 
>
> I'm having this same problem. I don't think this is a problem but just the expected behavior. Surprising there are so many solutions.
>
> note: when your folders are empty they are not tracked. its a good practice to put a empty .keep file in there to keep the empty directories – 

---

Check the `.gitignore` file, if the subdirectory is ignored.

Then try again

```bash
git add --all
git commit -am "<commit message>"
git push
```

## [git add * (asterisk) vs git add . (period)](https://stackoverflow.com/questions/26042390/git-add-asterisk-vs-git-add-period)

I have a question about adding files in git. I have found multiple stackoverflow questions about the difference between git add . and git add -a, git add --all, git add -A, etc. But I've been unable to find a place that explains what git add * does. I've even looked at the git add man page, but it didn't help. I've been using it in place of git add . and my co-worker asked me why. I didn't have an answer. I've just always used git add *.

Are git add . and git add * the same? Does one add changed files from the current directory only, while the other adds files from the current directory and subdirectories (recursively)?

There's a great chart listed on one of the other stack questions that shows the difference between git add -A git add . and git add -u, but it doesn't have git add *.

![](https://i.stack.imgur.com/YfLUZ.jpg)

Note: I understand what it means to use the asterisk as a wildcard (add all files with a given extension). For example, git add *.html would add all files that have a .html extension (but ignore .css, .js, etc).

---

> Where's that chart from? I just tried git add . again, and it staged a deleted file no problem, unlike the X in that row would suggest. – 
>
> @David That image is from this answer and applies to older versions of git. – 
>
> Picture outdated! Git 2.x is different: i.stack.imgur.com/KwOLu.jpg

`add *` means add all files in the current directory, except for files whose name begin with a dot. This is your shell functionality and Git only ever receives a list of files.

`add .` has no special meaning in your shell, and thus Git adds the entire directory recursively, which is almost the same, but including files whose names begin with a dot.

---

> so `git add .` adds all files, folders, and subfolders, including `.gitignore` and anything else beginning with a dot, while `git add *` would add any files, folders, and subfolders, except those beginning with a dot? Is that accurate?

> That is indeed correct. Also, `git add *` would still add files beginning with a dot if they are in a subdirectory.

> `git add .` also respects `.gitignore`, whereas `git add *` will throw an error if any non-dot-files are gitignored. Much better to use `git add .` than `git add *`.

> Worth noting: if invoking Git on DOS/Windows from `CMD.EXE`, it's Git, not the shell, that expands the `*`. In this case Git will find dot-files.

> @Thor84no: Git will find the dot-files even on a Linux system, if you quote the `*` to protect it from the shell. It's not a matter of the hidden bit, it's just that Git's compiled-in rules differ.

## [How do I undo 'git add' before commit?](https://stackoverflow.com/questions/348170/how-do-i-undo-git-add-before-commit)

Undo git add for uncommitted changes with:

```bash
git reset <file>
```

That will remove the file from the current index (the "about to be committed" list) without changing anything else.

To unstage all changes for all files:

```bash
git reset
```



## [Git list of staged files](https://stackoverflow.com/questions/33610682/git-list-of-staged-files)

I staged a lot of files using git add, and now I want to see all the files I have staged, without untracked files or changed, but unstaged files.

How do I do that? When using `git diff --cached` I can see the changes of what I just staged. So then I tried using `git status --cached`, but that `--cached` unfortunately doesn't work on git status.

---

The best way to do this is by running the command:

```bash
git diff --name-only --cached
```

When you check the manual you will likely find the following:

```bash
--name-only
    Show only names of changed files.
```

And on the example part of the manual:

```bash
git diff --cached
    Changes between the index and your current HEAD.
```

Combined together, you get the changes between the index and your current HEAD and Show only names of changed files.

`--staged` is also available as an alias for `--cached` above in more recent Git versions.

NB: This can be combined with `--diff-filter` to only show (filter) staged files that are added `A`, modified `M` etc.

```bash
git diff --name-only --cached --diff-filter=AM
```

---

Simplest way:

```bash
git status -s
```

Example output:

```bash
M Gemfile
M Gemfile.lock
A  docs/cors.md
A  docs/notes.md
```

Key:

```bash
M: Modified and not staged
A: Already staged
```
