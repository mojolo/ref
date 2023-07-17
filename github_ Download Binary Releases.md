```bash
REPOS=( 'pemistahl/grex' 'denisidoro/navi' 'noborus/ov' 'sharkdp/fd' 'sharkdp/bat' 'lsd-rs/lsd' 'ogham/exa' 'junegunn/fzf' 'BurntSushi/ripgrep' 'cheat/cheat' 'zyedidia/micro' 'chmln/sd' 'swsnr/mdcat' 'dandavison/delta' )
GH_TOKEN='XXXXXXXXXXXX'
GH_AUTH="Authorization: Bearer $GH_TOKEN"
ARCH_TYPE='linux.*amd64|amd64.*linux|linux.*x86_64|x86_64.*linux|linux64'
PREF_BUILDS=( 'musl' 'static' )

for repo in "${REPOS[@]}"
  do
    LATEST_BINS="$(curl -H "$GH_AUTH" -s "https://api.github.com/repos/"$repo"/releases/latest" | jq -r "[.assets[] | select(.name | test(\"${ARCH_TYPE}\"))]")"
    NUM_BINS="$(echo "$LATEST_BINS" | jq '. | length')"
    BIN_TO_DL=
    if (( $NUM_BINS == 0 ))
      then echo "$repo has no download candidates. Proceeding to next binary download, if any remaining."
      elif (( $NUM_BINS == 1 ))
        then BIN_NAME="$(echo "$LATEST_BINS" | jq -r '.[].name')"
        DL_LINK="$(echo "$LATEST_BINS" | jq -r '.[].browser_download_url')"
        if [ -f "$BIN_NAME" ]
          then echo "\n$BIN_NAME is already the latest...\n\tskipping and proceeding to next binary download, if any remaining...."
          else
            echo "\nfrom $repo...\n\tdownloading $BIN_NAME..."
            curl --remote-name -H "$GH_TOKEN" -sL "$DL_LINK"
        fi
      elif BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r ".[] | select(.name | test(\"${PREF_BUILDS[1]}.*${PREF_BUILDS[2]}|${PREF_BUILDS[2]}.*${PREF_BUILDS[1]}\"))")" && [ ! -z "$BIN_TO_DL" ]
        then BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        if [ -f "$BIN_NAME" ]
          then echo "\n$BIN_NAME is already the latest...\n\tskipping and proceeding to next binary download, if any remaining...."
          else
            echo "\nfrom $repo...\n\tdownloading $BIN_NAME..."
            curl --remote-name -H "$GH_TOKEN" -sL "$DL_LINK"
        fi
      elif BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r ".[] | select(.name | test(\"${PREF_BUILDS[1]}\"))")" && [ ! -z "$BIN_TO_DL" ]
        then BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        if [ -f "$BIN_NAME" ]
          then echo "\n$BIN_NAME is already the latest...\n\tskipping and proceeding to next binary download, if any remaining...."
          else
            echo "\nfrom $repo...\n\tdownloading $BIN_NAME..."
            curl --remote-name -H "$GH_TOKEN" -sL "$DL_LINK"
        fi
      elif BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r ".[] | select(.name | test(\"${PREF_BUILDS[2]}\"))")" && [ ! -z "$BIN_TO_DL" ]
        then BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        if [ -f "$BIN_NAME" ]
          then echo "\n$BIN_NAME is already the latest...\n\tskipping and proceeding to next binary download, if any remaining...."
          else
            echo "\nfrom $repo...\n\tdownloading $BIN_NAME..."
            curl --remote-name -H "$GH_TOKEN" -sL "$DL_LINK"
        fi
      else
        BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r '.[-1]')"
        BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        if [ -f "$BIN_NAME" ]
          then echo "\n$BIN_NAME is already the latest...\n\tskipping and proceeding to next binary download, if any remaining...."
          else
            echo "\nfrom $repo...\n\tdownloading $BIN_NAME..."
            curl --remote-name -H "$GH_TOKEN" -sL "$DL_LINK"
        fi
    fi
  done
```



```bash
REPOS=( 'pemistahl/grex' 'denisidoro/navi' 'noborus/ov' 'sharkdp/fd' 'sharkdp/bat' 'lsd-rs/lsd' 'ogham/exa' 'junegunn/fzf' 'BurntSushi/ripgrep' 'cheat/cheat' 'zyedidia/micro' 'chmln/sd' 'swsnr/mdcat' 'dandavison/delta' )
ARCH_TYPE='linux.*amd64|amd64.*linux|linux.*x86_64|x86_64.*linux|linux64'
PREF_BUILDS=( 'musl' 'static' )

for repo in "${REPOS[@]}"
  do
    LATEST_BINS="$(curl -H "$GH_AUTH" -s "https://api.github.com/repos/"$repo"/releases/latest" | jq -r "[.assets[] | select(.name | test(\"${ARCH_TYPE}\"))]")"
    NUM_BINS="$(echo "$LATEST_BINS" | jq '. | length')"
    BIN_TO_DL=
    if (( $NUM_BINS == 0 ))
      then echo "$repo has no download candidates. Proceeding to next binary download, if any remaining."
      elif (( $NUM_BINS == 1 ))
        then BIN_NAME="$(echo "$LATEST_BINS" | jq -r '.[].name')"
        DL_LINK="$(echo "$LATEST_BINS" | jq -r '.[].browser_download_url')"
        echo $BIN_NAME
        echo $DL_LINK
      elif BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r ".[] | select(.name | test(\"${PREF_BUILDS[1]}.*${PREF_BUILDS[2]}|${PREF_BUILDS[2]}.*${PREF_BUILDS[1]}\"))")" && [ ! -z "$BIN_TO_DL" ]
        then BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        echo $BIN_NAME
        echo $DL_LINK
      elif BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r ".[] | select(.name | test(\"${PREF_BUILDS[1]}\"))")" && [ ! -z "$BIN_TO_DL" ]
        then BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        echo "$BIN_NAME"
        echo "$DL_LINK"
      elif BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r ".[] | select(.name | test(\"${PREF_BUILDS[2]}\"))")" && [ ! -z "$BIN_TO_DL" ]
        then BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        echo "$BIN_NAME"
        echo "$DL_LINK"
      else
        BIN_TO_DL="$(echo "$LATEST_BINS" | jq -r '.[-1]')"
        BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
        DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
        echo "$BIN_NAME"
        echo "$DL_LINK"
    fi
  done
```



```bash
ARCH_TYPE='linux.*amd64|amd64.*linux|linux.*x86_64|x86_64.*linux|linux64'
BUILD_TYPE=( 'musl' 'static' )

BIN_LATEST="$(curl -H "$GH_AUTH" -s "https://api.github.com/repos/"lsd-rs/lsd"/releases/latest" | jq -r "[.assets[] | select(.name | test(\"${ARCH_TYPE}\"))]")"
  NUM_BINS="$(echo "$BIN_LATEST" | jq '. | length')"
  if (( $NUM_BINS == 0 ))
    then echo "$REPO has no download candidates. Proceeding to next binary download, if any remaining."
    elif (( $NUM_BINS == 1 ))
      then BIN_NAME="$(echo "$BIN_LATEST" | jq -r '.[].name')"
      DL_LINK="$(echo "$BIN_LATEST" | jq -r '.[].browser_download_url')"
      echo $BIN_NAME
      echo $DL_LINK
    elif [[ "$(echo "$BIN_LATEST" | jq -r ".[] | select(.name | test(\"${BUILD_TYPE[1]}.*${BUILD_TYPE[2]}|${BUILD_TYPE[2]}.*${BUILD_TYPE[1]}\"))")" ]]
      then BIN_TO_DL="$(echo "$BIN_LATEST" | jq -r ".[] | select(.name | test(\"${BUILD_TYPE[1]}.*${BUILD_TYPE[2]}|${BUILD_TYPE[2]}.*${BUILD_TYPE[1]}\"))")"
      BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
      DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
      echo $BIN_NAME
      echo $DL_LINK
    elif [[ "$(echo "$BIN_LATEST" | jq -r ".[] | select(.name | test(\"${BUILD_TYPE[1]}\"))")" ]]
      then BIN_TO_DL="$(echo "$BIN_LATEST" | jq -r ".[] | select(.name | test(\"${BUILD_TYPE[1]}\"))")"
      BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
      DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
      echo "$BIN_NAME"
      echo "$DL_LINK"
    elif [[ "$(echo "$BIN_LATEST" | jq -r ".[] | select(.name | test(\"${BUILD_TYPE[2]}\"))")" ]]
      then BIN_TO_DL="$(echo "$BIN_LATEST" | jq -r ".[] | select(.name | test(\"${BUILD_TYPE[2]}\"))")"
      BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
      DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
      echo "$BIN_NAME"
      echo "$DL_LINK"
    else
      BIN_TO_DL="$BIN_LATEST" | jq -r ".[-1]"
      BIN_NAME="$(echo "$BIN_TO_DL" | jq -r '.name')"
      DL_LINK="$(echo "$BIN_TO_DL" | jq -r '.browser_download_url')"
      echo "$BIN_NAME"
      echo "$DL_LINK"
  fi
```

```bash
REPO=( 'pemistahl/grex' 'denisidoro/navi' 'noborus/ov' 'sharkdp/fd' 'sharkdp/bat' 'lsd-rs/lsd' 'ogham/exa' 'junegunn/fzf' 'BurntSushi/ripgrep' 'cheat/cheat' 'zyedidia/micro' 'chmln/sd' 'swsnr/mdcat' 'dandavison/delta' )

ARCH_TYPE='musl.*linux.*amd64|linux.*musl.*amd64|amd64.*musl.*linux|musl.*amd64.*linux|linux.*amd64.*musl|amd64.*linux.*musl|musl.*linux.*x86_64|linux.*musl.*x86_64|x86_64.*musl.*linux|musl.*x86_64.*linux|linux.*x86_64.*musl|x86_64.*linux.*musl|linux.*amd64|amd64.*linux|linux.*x86_64|x86_64.*linux|linux64-static'

for i in "${REPO[@]}"
  do
    BIN_LATEST="$(curl -H "$GH_AUTH" -s "https://api.github.com/repos/"$i"/releases/latest" | jq -r "[.assets[] | select(.name | test(\"${ARCH_TYPE}\"))][-1]")"
    BIN_NAME="$(echo "$BIN_LATEST" | jq -r '.name')"
    BIN_DL="$(echo "$BIN_LATEST" | jq -r '.browser_download_url')"
    if [ -f "$BIN_NAME" ]
      then echo "$BIN_NAME is already the latest"
      else
      	echo "Downlading $BIN_NAME"
      	echo "at $BIN_DL"
      	curl --remote-name -H "$GH_AUTH" -sL "$BIN_DL"
    fi
  done
```

```bash
REPO=( 'pemistahl/grex' 'denisidoro/navi' 'noborus/ov' 'sharkdp/fd' 'sharkdp/bat' 'lsd-rs/lsd' 'ogham/exa' 'junegunn/fzf' 'BurntSushi/ripgrep' 'cheat/cheat' 'zyedidia/micro' 'chmln/sd' 'swsnr/mdcat' 'dandavison/delta' )

ARCH_TYPE='musl.*linux.*amd64|linux.*musl.*amd64|amd64.*musl.*linux|musl.*amd64.*linux|linux.*amd64.*musl|amd64.*linux.*musl|musl.*linux.*x86_64|linux.*musl.*x86_64|x86_64.*musl.*linux|musl.*x86_64.*linux|linux.*x86_64.*musl|x86_64.*linux.*musl|linux.*amd64|amd64.*linux|linux.*x86_64|x86_64.*linux|linux64-static|linux64'

for i in "${REPO[@]}"; do curl --remote-name -sL $(curl -s "https://api.github.com/repos/"$i"/releases/latest" | jq -r ".assets[] | select(.name | test(\"${ARCH_TYPE}\")).browser_download_url"); done
```

```bash
REPO='dandavison/delta'
GITHUB_API="https://api.github.com/repos/${REPO}/releases/latest"
ARCH_TYPE='musl.*linux.*amd64|linux.*musl.*amd64|amd64.*musl.*linux|musl.*amd64.*linux|linux.*amd64.*musl|amd64.*linux.*musl|musl.*linux.*x86_64|linux.*musl.*x86_64|x86_64.*musl.*linux|musl.*x86_64.*linux|linux.*x86_64.*musl|x86_64.*linux.*musl|linux.*amd64|amd64.*linux|linux.*x86_64|x86_64.*linux|linux64-static|linux64'

curl --remote-name -sL $(curl -s "$GITHUB_API" | jq -r ".assets[] | select(.name | test(\"${ARCH_TYPE}\")).browser_download_url")
```

```bash
REPO='junegunn/fzf'
GITHUB_API="https://api.github.com/repos/${REPO}/releases/latest"
ARCH_TYPE='linux.*amd64|linux.*x86_64|amd64.*linux|x86_64.*linux'

curl --remote-name -sL $(curl -s "$GITHUB_API" | jq -r ".assets[] | select(.name | test(\"${ARCH_TYPE}\")).browser_download_url")
```

```bash
REPO='junegunn/fzf'
GITHUB_API="https://api.github.com/repos/${REPO}/releases/latest"
ARCH_TYPE='linux_amd64|x86_64-linux'

curl --remote-name -sL $(curl -s "$GITHUB_API" | jq -r ".assets[] | select(.name | test(\"${ARCH_TYPE}\")).browser_download_url")
```

```bash
curl --remote-name -sL $(curl -s 'https://api.github.com/repos/junegunn/fzf/releases/latest' | jq -r ".assets[] | select(.name | test(\"linux_amd64|x86_64-linux\")).browser_download_url")
```

```bash
repo='Canop/broot'
GH_TOKEN='XXXXXXXXXXXX'
GH_AUTH="Authorization: Bearer $GH_TOKEN"
ARCH_TYPE='linux.*amd64|amd64.*linux|linux.*x86_64|x86_64.*linux|linux64|broot'
curl -H "$GH_AUTH" -s "https://api.github.com/repos/$repo/releases/latest" | jq -r "[.assets[] | select(.name | test(\"${ARCH_TYPE}\"))]"
```



## [How to download the latest binary release from github?](https://stackoverflow.com/questions/71632199/how-to-download-the-latest-binary-release-from-github)

Try using instead Github's REST API for getting the latest release (see the curl example and the response with all the URLs): [docs.github.com/en/rest/reference/…](https://docs.github.com/en/rest/reference/releases#get-the-latest-release)

---

Is it trying to extract the download link from the HTML page? That's error prone and may break any time.

For such operations, check if they offer an API first.

They do: https://docs.github.com/en/rest/reference/releases#get-the-latest-release

You could write something like (pseudo code):

```sh
 curl \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest \
    | jq .assets[0].browser_download_url \
    | xargs wget -qi -
```

Like suggested in the comments, test each command (pipe separated) individually.

---

You can use the [GitHub CLI](https://github.com/cli/cli), specifically the [`release download`](https://cli.github.com/manual/gh_release_download) command:

```sh
gh release download --repo Atmosphere-NX/Atmosphere --pattern '*.bin'
gh release download --repo Atmosphere-NX/Atmosphere --archive zip
```

Without scurl -sL https://api.github.com/repos/CTCaer/hekate/tagspecifying a release tag, the command defaults to the latest release.

### [gh release download](https://cli.github.com/manual/gh_release_download)

```
gh release download [<tag>] [flags]
```

Download assets from a GitHub release.

Without an explicit tag name argument, assets are downloaded from the latest release in the project. In this case, '--pattern' is required.

##### Options

- `-A`, `--archive <format>`

  Download the source code archive in the specified format (zip or tar.gz)

- `--clobber`

  Overwrite existing files of the same name

- `-D`, `--dir <directory>`

  The directory to download files into

- `-O`, `--output <file>`

  The file to write a single asset to (use "-" to write to standard output)

- `-p`, `--pattern <stringArray>`

  Download only assets that match a glob pattern

- `--skip-existing`

  Skip downloading when files of the same name exist

##### Options inherited from parent commands

- `-R`, `--repo <[HOST/]OWNER/REPO>`

  Select another repository using the [HOST/]OWNER/REPO format

##### Examples

```
# download all assets from a specific release
$ gh release download v1.2.3

# download only Debian packages for the latest release
$ gh release download --pattern '*.deb'

# specify multiple file patterns
$ gh release download -p '*.deb' -p '*.rpm'

# download the archive of the source code for a release
$ gh release download v1.2.3 --archive=zip
```

##### See also

- [gh release](https://cli.github.com/manual/gh_release)



## [Bash script to download latest release from GitHub](https://stackoverflow.com/questions/73005401/bash-script-to-download-latest-release-from-github)

Looking for a simple way to download a .zip from a latest GitHub release. There are other similar questions, but I havent been able to get them to work. :(

Trying to pull latest release from https://github.com/CTCaer/hekate

Currently ive got:

```bash
#!/bin/bash
curl -s https://api.github.com/repos/CTCaer/hekate/releases/latest | jq -r ".assets[] | select(.name | test(\"hekate_ctcaer\")) | .browser_download_url"
```

trying to fetch the url of the latest .zip and only grab the "hekate_ctcaer_X.X.X_Nyx_X.X.X.zip"

I saw someone trying to achieve this with 'Xidel', so im open to trying that if someone knows the syntax to grab a specific file from the GitHub api.

As I understand it (?), the Github API spits out an array for the release 'assets', so im trying to specify an item in this array that matches "hekate_ctcaer", and download the specified file.

---

* Do you mean: `url=$(curl -s https://api.github.com/repos/CTCaer/hekate/releases/latest | jq -r ".assets[] | select(.name | test(\"hekate_ctcaer\")) | .browser_download_url"); wget "$url"`?

- hm maybe... ?

---

This will print out the url to the zip file of the latest release:

```bash
curl -sL https://api.github.com/repos/CTCaer/hekate/tags \
  | jq -r '.[0].zipball_url' \
  | xargs -I {} curl -sL {} -o latest.zip
```



## [How do I download binary files of a GitHub release?](https://stackoverflow.com/questions/25923939/how-do-i-download-binary-files-of-a-github-release)

* As I understand it, those releases are a GitHub feature and are not part of your repo. I don't think you can download them from GitHub using Git commands.

---

```
curl -sL https://api.github.com/repos/junegunn/fzf/releases/latest
```

---

Binary release assets exist outside of Git, and cannot be managed using the standard tools.

They should be available via GitHub's API, though.

1. [List the repository's release assets](https://developer.github.com/v3/repos/releases/#list-assets-for-a-release):

   ```
   GET /repos/:owner/:repo/releases/:id/assets
   ```

   This will send back a JSON document listing the release assets for the repository, e.g.

   ```json
   [
     {
       "url": "https://api.github.com/repos/octocat/Hello-World/releases/assets/1",
       "browser_download_url": "https://github.com/octocat/Hello-World/releases/download/v1.0.0/example.zip",
       "id": 1,
       "name": "example.zip",
       "label": "short description",
       "state": "uploaded",
       "content_type": "application/zip",
       "size": 1024,
       "download_count": 42,
       "created_at": "2013-02-27T19:35:32Z",
       "updated_at": "2013-02-27T19:35:32Z",
       "uploader": {
         "login": "octocat",
         ...
       }
     }
   ]
   ```

2. [Retrieve the assts from the release you want](https://developer.github.com/v3/repos/releases/#get-a-single-release-asset), as defined by its `id` from above:

   ```
   GET /repos/:owner/:repo/releases/assets/:id
   ```

   > If you want to download the asset's binary content, pass a media type of `"application/octet-stream"`. The API will either redirect the client to the location, or stream it directly if possible. API clients should handle both a `200` or `302` response.

As [documented](https://developer.github.com/v3/#root-endpoint), these requests are all relative to `https://api.github.com`.

---

#### One-Step Process:

Here's a one-liner (*sans auth*) I used in a script to download *Digital Ocean*'s `doctl` interface from Github. It just grabs the **LATEST** release and unTARs it:

```
curl -sL $(curl -s https://api.github.com/repos/digitalocean/doctl/releases/latest | grep "http.*linux-amd64.tar.gz" | awk '{print $2}' | sed 's|[\"\,]*||g') | tar xzvf -
```

If not using Linux, replace `"http.*linux-amd64.tar.gz"` in the above with "darwin", "windows", etc and the appropriate arch.

**NOTE**: The above *should* work programmatically grabbing binaries from other Github repos, but I've only tested it with `doctl`. HTH-

---

This is a mini script to download an asset knowing its file name (can be easily modified to download other assets:

```sh
asseturl=$(curl -H "Authorization: token ${token}" https://api.github.com/repos/${repo}/releases/${releaseid}/assets | jq ".[] | select(.name==\"${filename}\") | .url")
curl -L -H "Authorization: token ${token}" -H "Accept:application/octet-stream" $(echo $asseturl | tr -d '"') > ${filename}
```

- `$token` is the access token for github
- `$filename` is the filename for the asset
- `$releaseid` is the releaseid where the binary file is stored

---

* if you dont know the `releaseid` you can filter `/repos/{owner}/{repo}/releases` by name with `curl -H "Authorization: token ${token}" https://api.github.com/repos/${owner}/${repo}/releases | jq -r ".[] | select(.name == \"${releasename}\") | .assets[] | select(.name == \"${filename}\") | .url"`



## [HOW TO DOWNLOAD THE LATEST RELEASE FROM GITHUB](https://starkandwayne.com/blog/how-to-download-the-latest-release-from-github/index.html)

`curl`, `jq` and the [Github API](https://developer.github.com/) to the rescue:

```
spruce_type=linux_amd64
curl -s https://api.github.com/repos/geofffranks/spruce/releases/latest | jq -r ".assets[] | select(.name | test(\"${spruce_type}\")) | .browser_download_url"
```

The magic is the `.../releases/latest` API endpoint which automatically figures out which is the latest release.

Will return the download URL for the `linux_amd64` version of Spruce:

```
https://github.com/geofffranks/spruce/releases/download/v1.0.1/spruce_1.0.1_linux_amd64.tar.gz
```

The `| select(.name | test"<some-filter>")` portion of the `jq` filter would be specific to the release and its files.

The `spruce` project releases the following files each time:

```
curl -s https://api.github.com/repos/geofffranks/spruce/releases/latest | jq -r ".assets[].name"
```

Which returns (for the current v1.0.1 release):

```
LICENSE
README.md
spruce_1.0.1_darwin_amd64.zip
spruce_1.0.1_linux_386.tar.gz
spruce_1.0.1_linux_amd64.tar.gz
```

So we can find the target file by filtering between `darwin_amd64` or `linux_386` or `linux_amd64`.

For another project, the files and how to filter to get the right one might be different.



## [Download artifacts from a latest GitHub release with bash and PowerShell](https://blog.markvincze.com/download-artifacts-from-a-latest-github-release-in-sh-and-powershell/)

[Releases](https://help.github.com/articles/about-releases/) is an important feature of GitHub, with which we can publish packaged versions of our project.

The source code of our repository is packaged with every release, and we also have the possibility to upload some artifacts alongside, for example the binaries or executables that we’ve built.

Lately I’ve been working on an [application](https://github.com/Travix-International/Travix.Core.Adk) for which the releases are published on GitHub, and I wanted to create an install script which always downloads the latest release.

It turned out that downloading the artifacts for a specific version is easy, we can simply build an URL with the version number to access the artifact. However, there is no direct URL to download artifacts from the *latest* release, so we need a bit of logic in our scripts to do that.

## Link structure

We can access a particular release with a URL like `https://github.com/account/project/releases/tag/project-1.0.5`. (The part after `tag/` is the what we specified when we created the release.)

Artifacts from this particular release can be downloaded with the URL `https://github.com/account/project/releases/download/project-1.0.5/myArtifact.zip`.

And there is this URL, which which always takes us to the latest release of a project: `https://github.com/account/project/releases/latest`.
It seemed logical that there should also be a way to also download artifacts from the latest release, so I [asked around](http://stackoverflow.com/questions/38283074/is-there-a-way-to-download-an-artifact-from-the-latest-release-on-github), but it turns out, there is no URL available to do that directly.

## Getting the latest tag

As it’s pointed out in the above SO answer, we can send a GET request to the URL `https://github.com/account/project/releases/latest` and set the `Accept` header to `application/json` (without this we get back the HTML page), we get information about the latest release in the following format.

```json
{"id":3622206,"tag_name":"project-1.0.5"}
```

This is the information we want, now we can use this in our scripts to determine the latest version and build our download links.

## Use the version in scripts

### Shell script

We can get the information about the latest release with `curl`.

```bash
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/account/project/releases/latest)
```

Then we have to extract the value of the `tag_name` property, I used a regex for this with `sed`.

```bash
# The releases are returned in the format {"id":3622206,"tag_name":"hello-1.0.0.11",...}, we have to extract the tag_name.
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
```

Then we can build our download URL for a certain artifact.

```bash
ARTIFACT_URL="https://github.com/account/project/releases/download/$LATEST_VERSION/myArtifact.zip"
```

### PowerShell

The latest release can be retrieved with `Invoke-WebRequest`.

```powershell
$latestRelease = Invoke-WebRequest https://github.com/account/project/releases/latest -Headers @{"Accept"="application/json"}
```

Then we have to extract the value of the `tag_name` property. Since PowerShell has built-in support for parsing Json, we don’t have to use a regex.

```powershell
# The releases are returned in the format {"id":3622206,"tag_name":"hello-1.0.0.11",...}, we have to extract the tag_name.
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name
```

Then we can build our download URL for a certain artifact.

```powershell
$url = "https://github.com/account/project/releases/download/$latestVersion/myArtifact.zip"
```

---

* The code snippets here assume a structure for the downloads. To dynamically query the release URL structure from GitHub, we can use the API's as follows (requires `jq`):

  ```bash
  # Download the curl binary from https://api.github.com/moparisthebest/static-curl/
  
  USER=moparisthebest \
  REPO=static-curl \
  GITHUB_API=https://api.github.com/repos/${USER}/${REPO}/releases/latest
  
  ARCH=$(dpkg --print-architecture) \
  && echo "Querying GitHub for the latest $ARCH release" \
  && LATEST_CURL=$(curl -L -s -H 'Accept: application/json' $GITHUB_API) \
  && LATEST_CURL_VERSION=$(echo $LATEST_CURL | jq -r '.tag_name') \
  && echo "Found version $LATEST_CURL_VERSION" \
  && LATEST_CURL_URL=$(echo $LATEST_CURL | jq -r ".assets[] | select(.name | contains(\"$ARCH\")) | .browser_download_url") \
  && echo "Downloading curl $LATEST_CURL_VERSION from $USER" \
  && curl -L $LATEST_CURL_URL --output /usr/local/bin/curl \
  && chmod +x /usr/local/bin/curl \
  && apt remove curl -y && apt autoremove -y \
  && echo "Setting hardlink to curl" \
  && ln -s /usr/local/bin/curl /usr/bin/curl
  ```

* Not all the releases/projects show up under /releases/latest API endpoint. Use `lastversion`:  [https://github.com/dvershin...](https://disq.us/url?url=https%3A%2F%2Fgithub.com%2Fdvershinin%2Flastversion%3AZ3MYwXYfzRovHfSXxenvxLvDKdw&cuid=3586674) for a neat way to get latest release.

* I recommend you not using the outdated approach described in this post, but rather use the Releases API mentioned by @espoelstra.
  If you retrieve the release by calling [https://api.github.com/repo...](https://disq.us/url?url=https%3A%2F%2Fapi.github.com%2Frepos%2Faccount%2Fproject%2Freleases%2Flatest%3Acv_gs_n0YiWSicfKuJw96Aqxkmg&cuid=3586674), the Json response will contain the field published_at at the root level.

* You should check out the GitHub Releases API, it is a little more concrete and unlikely to change, and it provides the exact download URL for you in the `assets` field, no need to assemble the path yourself which could be brittle if the artifact name changes. I also second Bill's suggestion to use `jq` for Linux/Mac platforms. I found this example really helpful, [https://starkandwayne.com/b...](https://disq.us/url?url=https%3A%2F%2Fstarkandwayne.com%2Fblog%2Fhow-to-download-the-latest-release-from-github%2F%3ARwlAfyle2LcWHEfRREQ5mrH5AjM&cuid=3586674)

* Good point! Probably this API didn't exist when I wrote this post (or I just missed it?).

  I'll add a disclaimer to the post saying that now the Releases API should be used instead.

## **[One Liner to Download the Latest Release from Github Repo.md](https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8)**

- Use `curl` to get the JSON response for the latest release
- Use `grep` to find the line containing file URL
- Use `cut` and `tr` to extract the URL
- Use `wget` to download it

```bash
curl -sL https://api.github.com/repos/jgm/pandoc/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
```

---

* Would anyone be able to help me debug this and figure out why I'm getting whatever `79464711,assets_url` is supposed to be instead of the release file? The exact commands I'm running are

```bash
cd /tmp
curl -s https://api.github.com/repos/SpacingBat3/WebCord/releases/latest |
  grep "browser_download_url.*arm64.deb" |
  cut -d : -f 2,3 |
  tr -d \" |
  wget -i -

echo "Done! Installing the package..."
sudo apt install -y /tmp/*arm64.deb || error "Webcord install failed"
```

* The problem is you're trying to use grep, cut and trim on json. None of which are designed for handing json in a reliable way. Use jq for reliability, as per my example above.

* Just use [`lastversion`](https://github.com/dvershinin/lastversion). It's pretty powerful:

  ```bash
  lastversion --assets --filter arm64.deb download https://github.com/SpacingBat3/WebCord
  ```

* Just remember that this only works for repos that do a Release.
  Many projects only use Tags as the release mechanism. I am one of them. :-)

* ##### **Love a good one-liner.**

  If you must use `wget`, to make your life easier you should search for your architecture by matching `uname -m` from the JSON response. Don't forget to add `head -1` though, otherwise you're (silently) downloading packages for all available archs.

  Totally up to you, but you may want to show progress too (albeit omitting everything else) with `-q --show-progress` instead of suppressing all output.

  The one-liner would look something like this:

  ```
      REPO="jgm/pandoc"; \
      curl -s https://api.github.com/repos/${REPO}/releases/latest | grep "browser_download_url.*$(uname -m).deb" \
      | head -1 \
      | cut -d : -f 2,3 \
      | tr -d \" \
      | wget --show-progress -qi - \
      || echo "-> Could not download the latest version of '${REPO}' for your architecture." # if you're polite
  ```

  Note: Setting a variable with the user/repo should decrease the risk of messing up the url :)

* ##### **My hat in the ring.**

  ```
  VER=$(curl --silent -qI https://github.com/bakito/adguardhome-sync/releases/latest | awk -F '/' '/^location/ {print  substr($NF, 1, length($NF)-1)}'); \
  wget https://github.com/bakito/adguardhome-sync/releases/download/$VER/adguardhome-sync_${VER#v}_linux_x86_64.tar.gz 
  ```

  Technically two lines because I needed to use the version number both in the URL path and in the filename

  ##### Retrieve latest version using curl

  ```
  curl -I https://github.com/bakito/adguardhome-sync/releases/latest
  ```

  returns

  ```
  HTTP/2 302 
  ...
  location: https://github.com/bakito/adguardhome-sync/releases/tag/v0.4.10
  ...
  ```

  So strip it out (minus the carriage return):

  ```
  curl -I https://github.com/bakito/adguardhome-sync/releases/latest | awk -F '/' '/^location/ {print  substr($NF, 1, length($NF)-1)}'
  ```

  returns

  ```
  v0.4.10
  ```

  ##### Attach to a variable and get annoyed when filename doesn't have a leading 'v'

  ```
  ${VER#v}
  ```

  This strips the leading `v` from the version number

  ##### Note

  Doesn't handle different architectures but that would be the use of `uname -m` at the least

  Thanks for the inspo in this thread - really should be easier than this ...

* One liner to download and pipe it to tar for extraction directly:

  ```bash
  curl -sL $(curl -s https://api.github.com/repos/actions/runner/releases/latest | grep browser_download_url | cut -d\" -f4 | egrep 'linux-arm64-[0-9.]+tar.gz$') | tar zx
  ```

* Why on Earth would you use two different tools for the same task and put `curl` and `wget` in the same script/1-liner ?
  Why fiddling with `grep`/`tr`/`cut` when the only reliable JSON parsing tool is `jq` ?

  This is from my own stuff (different URL):

  ```
  wget -q -O /usr/bin $(wget -q -O - 'https://api.github.com/repos/mikefarah/yq/releases/latest' | jq -r '.assets[] | select(.name=="yq_linux_amd64").browser_download_url'')
  ```

  2 tools is better than 5 IMHO.
  Adapting it to other needs is left to the keen reader. ;-)

* > Hmm... `https://github.com/<org-name>/<repo-name>/releases/latest/download/<artifact-file-name>` should work without having to rely on the GitHub REST API, no?

  literally the easiest way i've found. Thank you! [example](https://github.com/facebook/flipper/releases/latest/download/Flipper-linux.zip)

  edit: here's what i ended up with

  ```
  echo "Check for watchman"
  if ! [ -x "$(command -v watchman)" ]; then
  echo "downloading and installing latest github release"
  wget $(curl -L -s https://api.github.com/repos/facebook/watchman/releases/latest | grep -o -E "https://(.*)watchman-(.*).rpm") && sudo dnf localinstall watchman-*.rpm
  watchman version
  else
    echo "watchman exists."	
  fi
  ```

* The problem is that what to search for VARIES from repo to repo.
  MOST repos seem to use `browser_download_url` but I have also have seen repos that does not have that entry, but use `tarball_url`, `zipball_url` instead.

## [How to download the latest GitHub repo release via command line](https://geraldonit.com/2019/01/15/how-to-download-the-latest-github-repo-release-via-command-line/)

I just fiddled around a bit to find out how to download the latest GitHub release via the command line. Turns out that GitHub doesn’t provide a universal download URL to release binaries like it does for the release browser page itself. The latest release page can always be reached via `https://github.com/ORGANIZATION/REPO/releases/latest`, e.g. `https://github.com/gvenzl/csv2db/releases/latest`. Unfortunately that is not true for the binaries, which are available under `https://github.com/ORGANIZATION/REPO/archive/RELEASE_TAG.zip` and `https://github.com/ORGANIZATION/REPO/archive/RELEASE_TAG.tar.gz` but not under something generic like `https://github.com/ORGANIZATION/REPO/archive/latest.zip` and `https://github.com/ORGANIZATION/REPO/archive/latest.tar.gz`



The issue here is that GitHub only provides the release binaries under their actual release tag, e.g. `v1.0.0`, but that tag is entirely up to the user to define and changes as more releases are added, of course. It’s therefore hard to guess what the release tag would be and what to download. Nevertheless, thanks to the GitHub developer APIss it’s not that tricky to figure out the release tag for the latest release and instruct a utility like curl to download the binary. I’ve written a little one-liner for the UNIX command line to do exactly that. It took me a bit to get it right and so I thought it might come handy to you, rather than trying to reinvent the wheel. it It’s also available as a [public Gist](https://gist.github.com/gvenzl/1386755861fb42db492276d3864a378c) but I thought for visibility purposes it makes sense to blog it here, too.

```
LOCATION=$(curl -s https:``//api``.github.com``/repos/YOUR_ORGANIZTION/YOUR_REPO/releases/latest` `\``| ``grep` `"tag_name"` `\``| ``awk` `'{print "https://github.com/YOUR_ORGANIZATION/YOUR_REPO/archive/" substr($2, 2, length($2)-3) ".zip"}'``) \``; curl -L -o OUTPUT_FILE_NAME $LOCATION
```

For example:

```
LOCATION=$(curl -s https:``//api``.github.com``/repos/gvenzl/csv2db/releases/latest` `\``| ``grep` `"tag_name"` `\``| ``awk` `'{print "https://github.com/gvenzl/csv2db/archive/" substr($2, 2, length($2)-3) ".zip"}'``) \``; curl -L -o csv2db.zip $LOCATION
```

Here is how it goes:

```
LOCATION=$(...)
```

stores the output of all the commands in the brackets in the variable `$LOCATION`,

```
curl -s https:``//api``.github.com``/repos/gvenzl/csv2db/releases/latest
```

gets the latest release from your repository, in my case `https://github.com/gvenzl/csv2db`,

```
grep` `"tag_name"
```

grabs the tag name of the latest release (e.g. `v1.0.0`),

```
awk` `'{print "https://github.com/gvenzl/csv2db/archive/" substr($2, 2, length($2)-3) ".zip"}'
```

prints *https://github.com/gvenzl/csv2db/archive/* + *v1.0.0* + *.zip*
–>
https://github.com/gvenzl/csv2db/archive/v1.0.0.zip.

Now the `$LOCATION` environment variable is set to that string. From that point on you can do with that variable whatever you like, in case you have another use than downloading the binary. Or, just like below, you can complete the download process:

```
curl -L -o csv2db.zip $LOCATION
```

invokes cURL and downloads `$LOCATION` into `csv2db.zip`. The `-L` parameter is important so that cURL follows the URL, i.e. redirect.



## [Install a binary from GitHub releases](https://github.com/marketplace/actions/install-a-binary-from-github-releases) (GitHub Action)

#### [Finding a release](https://github.com/marketplace/actions/install-a-binary-from-github-releases#finding-a-release)

By default, this action will lookup the Platform and Architecture of the runner and use those values to interpolate and match a release package. **The release package name is first converted to lowercase**. The match pattern is:

```
`(osPlatform|osArchs).*(osPlatform|osArchs).*\.(tar\.gz|zip)`;
```

Natively, the action will only match the following platforms: `linux`, `darwin`, `windows`.

Some examples of matches:

- `my_package_linux_x86_64.tar.gz` (or `.zip`)
- `my_package_x86_64_linux.tar.gz` (or `.zip`)
- `my_package.linux.x86_64.tar.gz` (or `.zip`)
- `my_package.x86_64.linux.tar.gz` (or `.zip`)
- `linux_x86_64_my_package.tar.gz` (or `.zip`)
- `x86_64_linux_my_package.tar.gz` (or `.zip`)
- `linux.x86_64.my_package.tar.gz` (or `.zip`)
- `x86_64.linux.my_package.tar.gz` (or `.zip`)
- `linux_x86_64.tar.gz` (or `.zip`)
- `x86_64_linux.tar.gz` (or `.zip`)
- `linux.x86_64.tar.gz` (or `.zip`)
- `x86_64.linux.tar.gz` (or `.zip`)



## [Is there a way to get the latest tag of a given repo using github API v3](https://stackoverflow.com/questions/29109673/is-there-a-way-to-get-the-latest-tag-of-a-given-repo-using-github-api-v3)

The easiest I found (and usefull for my case where there is no "latest" and I dont want to checkout the branch) was:

```
curl  "https://api.github.com/repos/certbot/certbot/tags" | jq -r '.[0].name'
```

This jus prints the "highest" tag-number from the (e.g.) corresponding certbot tags-page (at https://github.com/certbot/certbot/tags)

kudos to https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-2649739
