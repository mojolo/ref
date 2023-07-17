- create logfiles when importing, updating, using plugins to update

- Importfeeds plugin do the same?

- clean library (I know Autofix plugin below can do this too)

- For plugins, pipx inject or python -m pip install?

- any way to get discogs info without doing the full metadata autotagging

- Test: 

  - 1. No ImportAdded, Spotify, discogs, beetcamp

       * file mtimes not affected

       * `added`: 2023-06-16 19:06:17

       * acoustibrainz fields work well when it works

       * other times, acoustibrainze errors out (b/c song/fields not in database??)

         ```
         acousticbrainz: Acousticbrainz did not provide info about {highlevel,lowlevel,rhythm,tonal}
         ```

       * Seems to respect pre-existing `bpm` tag (ie, doesn't overwrite it) or it's just the same value pulled from the same acoustibrainz source

       * Only 1 `genre`

       * No `mood` tag at all

       * `style` tag is empty

    2. ImportAdded w/out `preserve_mtimes`

       * `added`: 2021-08-08 15:39:46
       * no change to file mtimes

    3. ImportAdded with `preserve_mtimes` -- absolutely no difference from above

       * `added`: 2021-08-08 15:39:46
       * no change to file mtimes

    4. ImportAdded, Spotify -- does it work on import too?

       * creates `spotify_token.json` file
       * does not create a spotify track identifier since autotagging is disabled. unfortunately, this is needed for spotifysync to add spotify fields. JUST DISABLE THE PLUGIN.
       * does not create any new spotify (tag) fields since autotagging is disabled

    5. ImportAdded, beetcamp -- does it work on import without autotagging? does it replace or append to genre? multi-value genre or just a long string?

       * Does nothing since autotagging is disabled. JUST DISABLE THE PLUGIN.

    6. ImportAdded, discogs -- does it work on import without autotagging? does it replace or append to genre? and separator `; ` as string

       * Nada. JUST DISABLE THE PLUGIN.

    7. LastImport

       * SOLID. Works well but not on import. Need to run the command from CLI: `beet lastimport`

  - ignore config option

- Run:
  - fetchartist after all done

- Checkout later:
  - Skipping files/albums/tracks during import: ignore config option, `filefilter` and `ihate`
  - Autofix (BeetsPluginAutofix)
  - whatlastgenre bin and plugin
  - MusicBrainz Collection Plugin
  - beets-audible Plug-in
  - beets-describe Plug-in
  - beet-summarize
  - beets-usertag
  - beets-xtractor for acoustibrainz-type data?
  - `beets-noimport` Plug-in
  - Export Plugin
  - `keyfinder` plugin
  - `mbcollection` plugin

# Install

```
pipx install 'beets[discogs,lastgenre,lastimport,lyrics,chroma,beatport] @ git+https://github.com/beetbox/beets.git'
```

##### Plug-ins via Pipx:

`beetcamp`

* `pipx inject beets beetcamp` (no need to add beetcamp/bandcamp plugin path to `pluginpath` in `config.yaml`)
* https://github.com/snejus/beetcamp.git

`fetchartist`

* Need to download zip and place where you want (`~/.config/beets` is my current choice). Then add the path (`/home/mojo_lo/_config/beets/fetchartist`) to `config.yaml`.

* https://github.com/dkanada/beets-fetchartist.git

`Autofix`

* https://github.com/adamjakab/BeetsPluginAutofix.git

`whatlastgenre` (if you ever use it again)

* https://github.com/YetAnotherNerd/whatlastgenre.git

##### For reference (libs installed by some plugins): 

`pylast`: LastImport Plugin, beets-fetchartist plugin

`requests`: Lyrics Plugin,  beets-fetchartist plugin, whatlastgenre plugin

`beautifulsoup4`: Lyrics Plugin, 

`langdetect`: Lyrics Plugin (for translation)

`python-mutagen`: whatlastgenre plugin

`python3-discogs-client`: Discogs Plugin

`pyacoustid`: Chromaprint/Acoustid Plugin

`requests-oauthlib`: Beatport

# [Configuration `config.yaml`](https://beets.readthedocs.io/en/latest/reference/config.html#pluginpath)

```
directory: /mnt/music/Music
library: ~/.config/beets/library.db
import:
    copy: no
    move: no
    write: no
    incremental: yes
    log: ~/.config/beets/importlog.txt
ui:
    color: yes
art_filename: cover
pluginpath:
    ~/.config/beets/fetchartist
plugins: acousticbrainz fetchartist importadded importfeeds info lastimport lyrics # bandcamp discogs spotify wlg
```

TLDR; Just go here: https://beets.readthedocs.io/en/latest/reference/config.html

* On Unix-like OSes, write `~/.config/beets/config.yaml`.

The config file uses [YAML](https://yaml.org/) syntax. You can use the full power of YAML, but most configuration options are simple key/value pairs. This means your config file will look like this:

```
option: value
another_option: foo
bigger_option:
    key: value
    foo: bar
```

In YAML, you will need to use spaces (not tabs!) to indent some lines. If you have questions about more sophisticated syntax, take a look at the [YAML](https://yaml.org/) documentation.

### Global Config Options

#### `directory`

The directory to which files will be copied/moved when adding them to the library. Defaults to a folder called `Music` in your home directory.

#### `library`

Path to the beets library file. By default, beets will use a file called `library.db` alongside your configuration file.

#### `plugins`

A space-separated list of plugin module names to load. See [Using Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#using-plugins).

#### `pluginpath`

Directories to search for plugins.  Each Python file or directory in a plugin path represents a plugin and should define a subclass of `BeetsPlugin`. A plugin can then be loaded by adding the filename to the plugins configuration. The plugin path can either be a single string or a list of strings—so, if you have multiple paths, format them as a YAML list like so:

```
pluginpath:
    - /path/one
    - /path/two
```

### Importer Config Options

#### `write`

Either `yes` or `no`, controlling whether metadata (e.g., ID3) tags are written to files when using `beet import`. Defaults to `yes`. The `-w` and `-W` command-line options override this setting.

#### `copy`

Either `yes` or `no`, indicating whether to **copy** files into the library directory when using `beet import`. Defaults to `yes`.  Can be overridden with the `-c` and `-C` command-line options.

The option is ignored if `move` is enabled (i.e., beets can move or copy files but it doesn’t make sense to do both).

#### `move`

Either `yes` or `no`, indicating whether to **move** files into the library directory when using `beet import`. Defaults to `no`.

The effect is similar to the `copy` option but you end up with only one copy of the imported file. (“Moving” works even across filesystems; if necessary, beets will copy and then delete when a simple rename is impossible.) Moving files can be risky—it’s a good idea to keep a backup in case beets doesn’t do what you expect with your files.

This option *overrides* `copy`, so enabling it will always move (and not copy) files. The `-c` switch to the `beet import` command, however, still takes precedence.

#### `resume`

Either `yes`, `no`, or `ask`. Controls whether interrupted imports should be resumed. “Yes” means that imports are always resumed when possible; “no” means resuming is disabled entirely; “ask” (the default) means that the user should be prompted when resuming is possible. The `-p` and `-P` flags correspond to the “yes” and “no” settings and override this option.

#### `incremental`

Either `yes` or `no`, controlling whether imported directories are recorded and whether these recorded directories are skipped.  This corresponds to the `-i` flag to `beet import`.

#### `log`

Specifies a filename where the importer’s log should be kept.  By default, no log is written. This can be overridden with the `-l` flag to `import`.

### To Manage an Existing Library

Stop beets from moving/renaming your files (i.e., keep them precisely where they are). Beets just tracks them where they are. In this case:

1. Turn off `copy` - defaults to `yes` so you need to set it in `config.yaml`

   >Either `yes` or `no`, indicating whether to **copy** files into the library directory when using `beet import`. Defaults to `yes`.  Can be overridden with the `-c` and `-C` command-line options.
   >
   >The option is ignored if `move` is enabled (i.e., beets can move or copy files but it doesn’t make sense to do both).

2. Turn off `move` - defaults to `no`, so don't need to set it in your `config.yaml`

   >Either `yes` or `no`, indicating whether to **move** files into the library directory when using `beet import`. Defaults to `no`.
   >
   >The effect is similar to the `copy` option but you end up with only one copy of the imported file. (“Moving” works even across filesystems; if necessary, beets will copy and then delete when a simple rename is impossible.) Moving files can be risky—it’s a good idea to keep a backup in case beets doesn’t do what you expect with your files.
   >
   >This option *overrides* `copy`, so enabling it will always move (and not copy) files. The `-c` switch to the `beet import` command, however, still takes precedence.

3. Enable `incremental` to skip already-imported directories (so beets can track what it has seen)

   > Either `yes` or `no`, controlling whether imported directories are recorded and whether these recorded directories are skipped.  This corresponds to the `-i` flag to `beet import`.

   > If you want to import only the *new* stuff from a directory, use the `-i` option to run an *incremental* import. With this flag, beets will keep track of every directory it ever imports and avoid importing them again. This is useful if you have an “incoming” directory that you periodically add things to. To get this to work correctly, you’ll need to use an incremental import *every time* you run an import on the directory in question—including the first time, when no subdirectories will be skipped. So consider enabling the `incremental` configuration option.

# Plug-ins

#### `plugins`

A space-separated list of plugin module names to load. See [Using Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#using-plugins).

#### `pluginpath`

Directories to search for plugins.  Each Python file or directory in a plugin path represents a plugin and should define a subclass of `BeetsPlugin`. A plugin can then be loaded by adding the filename to the plugins configuration. The plugin path can either be a single string or a list of strings—so, if you have multiple paths, format them as a YAML list like so:

```
pluginpath:
    ~/.config/beets/fetchartist
plugins: info lyrics fetchartist
```

### [AcousticBrainz Plugin](https://beets.readthedocs.io/en/latest/plugins/acousticbrainz.html)

The `acousticbrainz` plugin gets acoustic-analysis information from the [AcousticBrainz](https://acousticbrainz.org/) project. This plugin is now deprecated since the AcousicBrainz project has been shut down.  As an alternative the [beets-xtractor](https://github.com/adamjakab/BeetsPluginXtractor) plugin can be used.

#### Automatic Tagging

To automatically tag files using AcousticBrainz data during import, just enable the `acousticbrainz` plugin (see [Using Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#using-plugins)). When importing new files, beets will query the AcousticBrainz API using MBID and set the appropriate metadata.

#### Configuration

To configure the plugin, make a `acousticbrainz:` section in your configuration file. The available options are:

- **auto**: Enable AcousticBrainz during `beet import`. Default: `yes`.
- **force**: Download AcousticBrainz data even for tracks that already have it. Default: `no`.
- **tags**: Which tags from the list above to set on your files. Default: [] (all).
- **base_url**: The base URL of the AcousticBrainz server. The plugin has no function if this option is not set. Default: None

By default, the command will only look for AcousticBrainz data when the tracks doesn’t already have it; the `-f` or `--force` switch makes it re-download data even when it already exists. If you specify a query, only matching tracks will be processed; otherwise, the command processes every track in your library.

For all tracks with a MusicBrainz recording ID, the plugin currently sets these fields:

- `average_loudness`
- `bpm`
- `chords_changes_rate`
- `chords_key`
- `chords_number_rate`
- `chords_scale`
- `danceable`
- `gender`
- `genre_rosamerica`
- `initial_key` (This is a built-in beets field, which can also be provided by [Key Finder Plugin](https://beets.readthedocs.io/en/latest/plugins/keyfinder.html).)
- `key_strength`
- `mood_acoustic`
- `mood_aggressive`
- `mood_electronic`
- `mood_happy`
- `mood_party`
- `mood_relaxed`
- `mood_sad`
- `moods_mirex`
- `rhythm`
- `timbre`
- `tonal`
- `voice_instrumental`

### [Lyrics Plugin](https://beets.readthedocs.io/en/latest/plugins/lyrics.html)

The `lyrics` plugin fetches and stores song lyrics from databases on the Web. Namely, the current version of the plugin uses [Genius.com](https://genius.com/), [Tekstowo.pl](https://www.tekstowo.pl/), and, optionally, the Google custom search API.

#### Fetch Lyrics During Import

To automatically fetch lyrics for songs you import, enable the `lyrics` plugin in your configuration (see [Using Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#using-plugins)). Then, install the [requests](https://requests.readthedocs.io/en/master/) library.

When importing new files, beets will now fetch lyrics for files that don’t already have them. The lyrics will be stored in the beets database. If the `import.write` config option is on, then the lyrics will also be written to the files’ tags.

#### Configuration

To configure the plugin, make a `lyrics:` section in your configuration file. The available options are:

- **auto**: Fetch lyrics automatically during import. Default: `yes`.
- **bing_client_secret**: Your Bing Translation application password (to [Activate On-the-Fly Translation](https://beets.readthedocs.io/en/latest/plugins/lyrics.html#lyrics-translation))
- **bing_lang_from**: By default all lyrics with a language other than `bing_lang_to` are translated. Use a list of lang codes to restrict the set of source languages to translate. Default: `[]`
- **bing_lang_to**: Language to translate lyrics into. Default: None.
- **fallback**: By default, the file will be left unchanged when no lyrics are found. Use the empty string `''` to reset the lyrics in such a case. Default: None.
- **force**: By default, beets won’t fetch lyrics if the files already have ones. To instead always fetch lyrics, set the `force` option to `yes`. Default: `no`.
- **google_API_key**: Your Google API key (to enable the Google Custom Search backend). Default: None.
- **google_engine_ID**: The custom search engine to use. Default: The [beets custom search engine](https://www.google.com:443/cse/publicurl?cx=009217259823014548361:lndtuqkycfu), which gathers an updated list of sources known to be scrapeable.
- **sources**: List of sources to search for lyrics. An asterisk `*` expands to all available sources. Default: `google genius tekstowo`, i.e., all the available sources. The `google` source will be automatically deactivated if no `google_API_key` is setup. The `google`, `genius`, and `tekstowo` sources will only be enabled if BeautifulSoup is installed.

Here’s an example of `config.yaml`:

```
lyrics:
  fallback: ''
  google_API_key: AZERTYUIOPQSDFGHJKLMWXCVBN1234567890_ab
  google_engine_ID: 009217259823014548361:lndtuqkycfu
```

#### Fetching Lyrics Manually

The `lyrics` command provided by this plugin fetches lyrics for items that match a query (see [Queries](https://beets.readthedocs.io/en/latest/reference/query.html)). For example, `beet lyrics magnetic fields absolutely cuckoo` will get the lyrics for the appropriate Magnetic Fields song, `beet lyrics magnetic fields` will get lyrics for all my tracks by that band, and `beet lyrics` will get lyrics for my entire library. The lyrics will be added to the beets database and, if `import.write` is on, embedded into files’ metadata.

The `-p` option to the `lyrics` command makes it print lyrics out to the console so you can view the fetched (or previously-stored) lyrics.

The `-f` option forces the command to fetch lyrics, even for tracks that already have lyrics. Inversely, the `-l` option restricts operations to lyrics that are locally available, which show lyrics faster without using the network at all.

#### Activate Google Custom Search

Using the Google backend requires [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/), which you can install using [pip](https://pip.pypa.io) by typing:

```
pip install beautifulsoup4
```

You also need to [register for a Google API key](https://console.developers.google.com/). Set the `google_API_key` configuration option to your key. Then add `google` to the list of sources in your configuration (or use default list, which includes it as long as you have an API key). If you use default `google_engine_ID`, we recommend limiting the sources to `google` as the other sources are already included in the Google results.

Optionally, you can [define a custom search engine](https://www.google.com/cse/all). Get your search engine’s token and use it for your `google_engine_ID` configuration option. By default, beets use a list of sources known to be scrapeable.

Note that the Google custom search API is limited to 100 queries per day. After that, the lyrics plugin will fall back on other declared data sources.

#### Activate Genius and Tekstowo.pl Lyrics

Using the Genius or Tekstowo.pl backends requires [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/), which you can install using [pip](https://pip.pypa.io) by typing:

```
pip install beautifulsoup4
```

These backends are enabled by default.

#### Activate On-the-Fly Translation

Using the Bing Translation API requires [langdetect](https://pypi.python.org/pypi/langdetect), which you can install using [pip](https://pip.pypa.io) by typing:

```
pip install langdetect
```

You also need to register for a Microsoft Azure Marketplace free account and to the [Microsoft Translator API](https://docs.microsoft.com/en-us/azure/cognitive-services/translator/translator-how-to-signup). Follow the four steps process, specifically at step 3 enter `beets` as *Client ID* and copy/paste the generated *Client secret* into your `bing_client_secret` configuration, alongside `bing_lang_to` target language code.

### [LastImport Plugin](https://beets.readthedocs.io/en/latest/plugins/lastimport.html)

The `lastimport` plugin downloads play-count data from your [Last.fm](https://last.fm) library into beets’ database. You can later create [smart playlists](https://beets.readthedocs.io/en/latest/plugins/smartplaylist.html) by querying `play_count` and do other fun stuff with this field.

After you have pylast installed, enable the `lastimport` plugin in your configuration (see [Using Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#using-plugins)).

Next, add your Last.fm username to your beets configuration file:

```
lastfm:
    user: beetsfanatic
```

#### Importing Play Counts

Simply run `beet lastimport` and wait for the plugin to request tracks from Last.fm and match them to your beets library. (You will be notified of tracks in your Last.fm profile that do not match any songs in your library.)

Then, your matched tracks will be populated with the `play_count` field, which you can use in any query or template. For example:

```
$ beet ls -f '$title: $play_count' play_count:5..
Eple (Melody A.M.): 60
```

To see more information (namely, the specific play counts for matched tracks), use the `-v` option.

#### Configuration

Aside from the required `lastfm.user` field, this plugin has some specific options under the `lastimport:` section:

- **per_page**: The number of tracks to request from the API at once. Default: 500.
- **retry_limit**: How many times should we re-send requests to Last.fm on failure? Default: 3.

By default, the plugin will use beets’s own Last.fm API key. You can also override it with your own API key:

```
lastfm:
    api_key: your_api_key
```

### [Spotify Plugin](https://beets.readthedocs.io/en/latest/plugins/spotify.html)

The `spotify` plugin generates [Spotify](https://www.spotify.com/) playlists from tracks in your library with the `beet spotify` command using the [Spotify Search API](https://developer.spotify.com/documentation/web-api/reference/#/operations/search).

Also, the plugin can use the Spotify [Album](https://developer.spotify.com/documentation/web-api/reference/#/operations/get-an-album) and [Track](https://developer.spotify.com/documentation/web-api/reference/#/operations/get-track) APIs to provide metadata matches for the importer.

#### Configuration

This plugin can be configured like other metadata source plugins as described in [Using Metadata Source Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#metadata-source-plugin-configuration). In addition, the following configuration options are provided.

The default options should work as-is, but there are some options you can put in config.yaml under the `spotify:` section.

#### Obtaining Track Popularity and Audio Features from Spotify

The `spotify` plugin provides an additional command `spotifysync` to obtain these track attributes from Spotify:

- `beet spotifysync [-f]`: obtain popularity and audio features information for every track in the library. By default, `spotifysync` will skip tracks that already have this information populated. Using the `-f` or `-force` option will download the data even for tracks that already have it. Please note that `spotifysync` works on tracks that have the Spotify track identifiers. So run `spotifysync` only after importing your music, during which Spotify identifiers will be added for tracks where Spotify is chosen as the tag source.

  In addition to `popularity`, the command currently sets these audio features for all tracks with a Spotify track ID:

  - `acousticness`
  - `danceability`
  - `energy`
  - `instrumentalness`
  - `key`
  - `liveness`
  - `loudness`
  - `mode`
  - `speechiness`
  - `tempo`
  - `time_signature`
  - `valence`

### [`beets-fetchartist`](https://github.com/dkanada/beets-fetchartist)

A plugin that fetches artist covers from last.fm and  places them in the artist directories. They removed this functionality from their API a while ago so this  library is parsing the HTML and manually grabbing the images off their  site. Automatically fetching artist covers during import is not yet supported.

The plugin requires `pylast` and `requests` which can be installed using `pip` on the host machine.

```
sudo pip install pylast requests
```

Afterwards, beets has to be configured to use the plugin.

```
pluginpath:
  ~/fetchartist

plugins: fetchartist
```

#### Configuration

The configuration is located in the fetchartist section. Only the `filename` option exists at the moment, which will determine the filename of the images. It will default to empty and use the artist names.

```
fetchartist:
  filename: "poster"
```

#### Usage

This plugin should be the same as any other plugin for beets when using a recent version.

```
Usage: beet fetchartist [options]

Options:
-h, --help   show this help message and exit
-f, --force  force overwrite existing artist covers
```

### `discogs` Plugin

TLDR; https://beets.readthedocs.io/en/latest/plugins/discogs.html

### [`whatlastgenre` Plugin](https://github.com/YetAnotherNerd/whatlastgenre)

TLDR; 	 https://github.com/YetAnotherNerd/whatlastgenre

​				https://github.com/YetAnotherNerd/whatlastgenre/tree/master/plugin/beets

### `beetcamp` Plugin

TLDR; https://github.com/snejus/beetcamp

After installing with `pipx inject`, add `bandcamp` to the `plugins` list to your beets configuration file.

### [ImportAdded Plugin](https://beets.readthedocs.io/en/latest/plugins/importadded.html)

The `importadded` plugin is useful when an existing collection is imported and the time when albums and items were added should be preserved.

To use the `importadded` plugin, enable it in your configuration (see [Using Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#using-plugins)).

#### Configuration

To configure the plugin, make an `importadded:` section in your configuration file. There are two options available:

- **preserve_mtimes**: After importing files, re-set their mtimes to their original value. Default: `no`.
- **preserve_write_mtimes**: After writing files, re-set their mtimes to their original value. Default: `no`.

#### Reimport

This plugin will skip reimported singleton items and reimported albums and all of their items.

#### Usage

The mtime of files that are imported into the library are assumed to represent the time when the items were originally added.

The `item.added` field is populated as follows:

- For singleton items with no album, `item.added` is set to the item’s file mtime before it was imported.
- For items that are part of an album, `album.added` and `item.added` are set to the oldest mtime of the files in the album before they were imported. The mtime of album directories is ignored.

This plugin can optionally be configured to also preserve mtimes at import using the `preserve_mtimes` option.

When `preserve_write_mtimes` option is set, this plugin preserves mtimes after each write to files using the `item.added` attribute.

File modification times are preserved as follows:

- For all items:
  - `item.mtime` is set to the mtime of the file from which the item is imported from.
  - The mtime of the file `item.path` is set to `item.mtime`.

Note that there is no `album.mtime` field in the database and that the mtime of album directories on disk aren’t preserved.

### [ImportFeeds Plugin](https://beets.readthedocs.io/en/latest/plugins/importfeeds.html)

This plugin helps you keep track of newly imported music in your library.

To use the `importfeeds` plugin, enable it in your configuration (see [Using Plugins](https://beets.readthedocs.io/en/latest/plugins/index.html#using-plugins)).

#### Configuration

To configure the plugin, make an `importfeeds:` section in your configuration file. The available options are:

- **absolute_path**: Use absolute paths instead of relative paths. Some applications may need this to work properly. Default: `no`.

- **dir**: The output directory. Default: Your beets library directory.

- **formats**: Select the kind of output. Use one or more of:

  > - **m3u**: Catalog the imports in a centralized playlist.
  > - **m3u_multi**: Create a new playlist for each import (uniquely named by appending the date and track/album name).
  > - **link**: Create a symlink for each imported item. This is the recommended setting to propagate beets imports to your iTunes library: just drag and drop the `dir` folder on the iTunes dock icon.
  > - **echo**: Do not write a playlist file at all, but echo a list of new file paths to the terminal.

  Default: None.

- **m3u_name**: Playlist name used by the `m3u` format. Default: `imported.m3u`.

- **relative_to**: Make the m3u paths relative to another folder than where the playlist is being written. If you’re using importfeeds to generate a playlist for MPD, you should set this to the root of your music library. Default: None.

Here’s an example configuration for this plugin:

```
importfeeds:
    formats: m3u link
    dir: ~/imports/
    relative_to: ~/Music/
    m3u_name: newfiles.m3u
```

### [`Autofix` (Beets Plugin)](https://github.com/adamjakab/BeetsPluginAutofix)

TLDR; See: https://github.com/adamjakab/BeetsPluginAutofix

---

# Usage: [Command-Line Interface](https://beets.readthedocs.io/en/latest/reference/cli.html)

### Import

* By default, the command copies files to your library directory and updates the ID3 tags on your music. In order to move the files, instead of copying, use the `-m` (move) option. If you’d like to leave your music files untouched, try the `-C` (don’t copy) and `-W` (don’t write tags) options. You can also disable this behavior by default in the configuration file (below).

* Also, you can disable the autotagging behavior entirely using `-A` (don’t autotag)—then your music will be imported with its existing metadata.

* During a long tagging import, it can be useful to keep track of albums that weren’t tagged successfully—either because they’re not in the MusicBrainz database or because something’s wrong with the files. Use the `-l` option to specify a filename to log every time you skip an album or import it “as-is” or an album gets skipped as a duplicate. You can later review the file manually or import skipped paths from the logfile automatically by using the `--from-logfile LOGFILE` argument.
* If you want to import only the *new* stuff from a directory, use the `-i` option to run an *incremental* import. With this flag, beets will keep track of every directory it ever imports and avoid importing them again. This is useful if you have an “incoming” directory that you periodically add things to. To get this to work correctly, you’ll need to use an incremental import *every time* you run an import on the directory in question—including the first time, when no subdirectories will be skipped. So consider enabling the `incremental` configuration option.
* If you want to preview which files would be imported, use the `--pretend` option. If set, beets will just print a list of files that it would otherwise import.

#### Reimporting

The `import` command can also be used to “reimport” music that you’ve already added to your library. This is useful when you change your mind about some selections you made during the initial import, or if you prefer to import everything “as-is” and then correct tags later.

Just point the `beet import` command at a directory of files that are already catalogged in your library. Beets will automatically detect this situation and avoid duplicating any items. In this situation, the “copy files” option (`-c`/`-C` on the command line or `copy` in the config file) has slightly different behavior: it causes files to be *moved*, rather than duplicated, if they’re already in your library. (The same is true, of course, if `move` is enabled.) That is, your directory structure will be updated to reflect the new tags if copying is enabled; you never end up with two copies of the file.

The `-L` (`--library`) flag is also useful for retagging. Instead of listing paths you want to import on the command line, specify a [query string](https://beets.readthedocs.io/en/latest/reference/query.html) that matches items from your library. In this case, the `-s` (singleton) flag controls whether the query matches individual items or full albums. If you want to retag your whole library, just supply a null query, which matches everything: `beet import -L`

Note that, if you just want to update your files’ tags according to changes in the MusicBrainz database, the [MBSync Plugin](https://beets.readthedocs.io/en/latest/plugins/mbsync.html) is a better choice. Reimporting uses the full matching machinery to guess metadata matches; `mbsync` just relies on MusicBrainz IDs.

#### remove

```
beet remove [-adf] QUERY
```

Remove music from your library.

This command uses the same [query](https://beets.readthedocs.io/en/latest/reference/query.html) syntax as the `list` command. By default, it just removes entries from the library database; it doesn’t touch the files on disk. To actually delete the files, use the `-d` flag. When the `-a` flag is given, the command operates on albums instead of individual tracks.

When you run the `remove` command, it prints a list of all affected items in the library and asks for your permission before removing them. You can then choose to abort (type n), confirm (y), or interactively choose some of the items (s). In the latter case, the command will prompt you for every matching item or album and invite you to type y to remove the item/album, n to keep it or q to exit and only remove the items/albums selected up to this point. This option lets you choose precisely which tracks/albums to remove without spending too much time to carefully craft a query. If you do not want to be prompted at all, use the `-f` option.

#### update

```
beet update [-F] FIELD [-aM] QUERY
```

Update the library (and, by default, move files) to reflect out-of-band metadata changes and file deletions.

This will scan all the matched files and read their tags, populating the database with the new values. By default, files will be renamed according to their new metadata; disable this with `-M`. Beets will skip files if their modification times have not changed, so any out-of-band metadata changes must also update these for `beet update` to recognise that the files have been edited.

To perform a “dry run” of an update, just use the `-p` (for “pretend”) flag. This will show you all the proposed changes but won’t actually change anything on disk.

By default, all the changed metadata will be populated back to the database. If you only want certain fields to be written, specify them with the ``-F`` flags (which can be used multiple times). For the list of supported fields, please see ``beet fields``.

When an updated track is part of an album, the album-level fields of *all* tracks from the album are also updated. (Specifically, the command copies album-level data from the first track on the album and applies it to the rest of the tracks.) This means that, if album-level fields aren’t identical within an album, some changes shown by the `update` command may be overridden by data from other tracks on the same album. This means that running the `update` command multiple times may show the same changes being applied.

### write

```
beet write [-pf] [QUERY]
```

Write metadata from the database into files’ tags.

When you make changes to the metadata stored in beets’ library database (during import or with the [modify](https://beets.readthedocs.io/en/latest/reference/cli.html#modify-cmd) command, for example), you often have the option of storing changes only in the database, leaving your files untouched. The `write` command lets you later change your mind and write the contents of the database into the files. By default, this writes the  changes only if there is a difference between the database and the tags  in the file.

You can think of this command as the opposite of [update](https://beets.readthedocs.io/en/latest/reference/cli.html#update-cmd).

The `-p` option previews metadata changes without actually applying them.

The `-f` option forces a write to the file, even if the file tags match the  database. This is useful for making sure that enabled plugins that run  on write (e.g., the Scrub and Zero plugins) are run on the file.

#### Global Flags

Beets has a few “global” flags that affect all commands. These must appear between the executable name (`beet`) and the command—for example, `beet -v import ...`.

- `-l LIBPATH`: specify the library database file to use.
- `-d DIRECTORY`: specify the library root directory.
- `-v`: verbose mode; prints out a deluge of debugging information. Please use this flag when reporting bugs. You can use it twice, as in `-vv`, to make beets even more verbose.
- `-c FILE`: read a specified YAML [configuration file](https://beets.readthedocs.io/en/latest/reference/config.html). This configuration works as an overlay: rather than replacing your normal configuration options entirely, the two are merged. Any individual options set in this config file will override the corresponding settings in your base configuration.
- `-p plugins`: specify a comma-separated list of plugins to enable. If specified, the plugin list in your configuration is ignored. The long form of this argument also allows specifying no plugins, effectively disabling all plugins: `--plugins=`.
- `-P plugins`: specify a comma-separated list of plugins to disable in a specific beets run. This will overwrite `-p` if used with it. To disable all plugins, use `--plugins=` instead.

Beets also uses the `BEETSDIR` environment variable to look for configuration and data.
