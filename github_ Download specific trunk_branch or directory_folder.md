## [How do I clone a single branch in Git?](https://stackoverflow.com/questions/1778088/how-do-i-clone-a-single-branch-in-git)

`git` `1.7.10` allows you to **clone only one branch**. You can use `--single-branch`, which also prevents fetching details of other branches. From the announcement (April 2012):

> `git clone` learned `--single-branch` option to limit cloning to a single branch (surprise!); tags that do not point into the history of the branch are not fetched.

* clone only the remote primary HEAD (default: origin/master)

  ```
  git clone --single-branch
  ```

  as in:

  ```
  git clone <url> --branch <branch> --single-branch [<folder>]
  ```

  or:

  ```
  git clone -b mybranch --single-branch git://sub.domain.com/repo.git
  ```

  or:

  ```
  git clone -b 5.1-branch --single-branch https://github.com/WordPress/WordPress.git
  ```

**Note**: Also [you can add another single branch or "undo"](https://stackoverflow.com/questions/17714159/how-do-i-undo-a-single-branch-clone) this action.

---

[Tobu](https://stackoverflow.com/users/229753/tobu) [comments](https://stackoverflow.com/questions/1778088/how-to-clone-a-single-branch-in-git/9920956?noredirect=1#comment27508922_9920956) that:

> **This is implicit when doing a shallow clone.
>   This makes `git clone --depth 1` the easiest way to save bandwidth.**

And since Git 1.9.0 (February 2014), shallow clones support data transfer (push/pull), so that option is even more useful now.
 See more at "[Is `git clone --depth 1` (shallow clone) more useful than it makes out?](https://stackoverflow.com/a/21217267/6309)".

------

"Undoing" a shallow clone is detailed at "[Convert shallow clone to full clone](https://stackoverflow.com/a/17937889/6309)" (git 1.8.3+)

```
# unshallow the current branch
git fetch --unshallow

# for getting back all the branches (see Peter Cordes' comment)
git config remote.origin.fetch refs/heads/*:refs/remotes/origin/*
git fetch --unshallow
```

---

As [Chris](https://stackoverflow.com/users/1308967/chris) comments:

> the magic line for getting missing branches to reverse `--single-branch` is (git v2.1.4):

```
git config remote.origin.fetch +refs/heads/*:refs/remotes/origin/*
git fetch --unshallow  
```



## [Clone specific branch with details of other branches](https://tecadmin.net/clone-specific-git-branch/)

The command below clones only the specific branch but fetches the  details of other branches. You can view all branches details with  command `git branch -a`.

You need to specify the branch name with **-b** command switch. Here is the syntax of the command to clone the specific git branch.

```
git clone -b <BRANCH_NAME>  <GIT_REMOTE_URL>
```

E.g., the following command will clone the branch 5.1-branch from the WordPress git repository.

```
git clone -b 5.1-branch https://github.com/WordPress/WordPress.git
```

E.g.:

```
svn export https://github.com/haasosaurus/nerd-fonts/trunk/patched-fonts/FantasqueSansMono
```



## [Download specific folder with SVN (w/out version control data)](https://coderwall.com/p/o2fasg/how-to-download-a-project-subdirectory-from-github)

If you want to download an entire project from GitHub without version control data, you can use the **Download ZIP** option of the website. Alternatively, you could use command line tools, for example:

```
curl -L https://github.com/janosgyerik/jquery-upvote/tarball/master > project.tar.gz
```

What if you want to download only a subdirectory? The website doesn’t have an option for that, at least not yet. Not a problem! Thanks to  Subversion support in GitHub, you could use the `svn` command line tool to that effect, for example:

```
svn export https://github.com/janosgyerik/jquery-upvote/trunk/lib jquery-upvote-lib
```

This creates a directory locally with the content of the specified subdirectory of the project.

Just make sure to construct the URL correctly, using the format:

```
https://github.com/USER/PROJECT/trunk/PATH DEST
```



## [Download specific folder with `SVN` (working copy)](https://stackoverflow.com/questions/7106012/download-a-single-folder-or-directory-from-a-github-repo)

Git doesn't support this, but Github does via SVN. If you checkout  your code with subversion, Github will essentially convert the repo from git to subversion on the backend, then serve up the requested  directory.

Here's how you can use this feature to download a specific folder. I'll use the popular javascript library `lodash` as an example.

1. **Navigate to the folder you want to download**. Let's download `/test` from `master` branch. [![github repo URL example](https://i.stack.imgur.com/tgGVd.png)](https://i.stack.imgur.com/tgGVd.png)

2. **Modify the URL for subversion**. Replace `tree/master` with `trunk`.

   `https://github.com/lodash/lodash/tree/master/test` ➜

   `https://github.com/lodash/lodash/trunk/test`

3. **Download the folder**. Go to the command line and grab the folder with SVN. 

```
svn checkout https://github.com/lodash/lodash/trunk/test
```

You might not see any activity immediately because Github takes up to 30 seconds to convert larger repositories, so be patient.

> *Full URL format explanation:*
>
> - If you're interested in `master` branch, use `trunk` instead. So the full path is `trunk/foldername`
> - If you're interested in `foo` branch, use `branches/foo` instead. The  full path looks like `branches/foo/foldername`
> - Protip: You can use `svn ls` to see available tags and branches before downloading if you wish

That's all! Github [supports more subversion features](https://help.github.com/articles/support-for-subversion-clients/) as well, including support for committing and pushing changes.

---

I modified this to use `svn export`, as I didn't want a Subversion working copy. Then I added the resulting  folder in Git. (I somehow lost a large piece of my directory tree, so I  exported from the repo I forked.)