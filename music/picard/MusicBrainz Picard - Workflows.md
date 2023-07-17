# For Singleton Collections

### ***Note***:

​	Only do ***60 at a time*** to mitigate crashing

### Options

* `Options` > `Options` > `Tags`: `Preserve Timestamps`

* `Options` > `Options` > `File Naming`: Switch from `User: Primary` to `User: Singleton: Artist - Title`

* `Options` > `Options` > `Cover Art`:
  * Untick `Save cover images as separate files`
  * `Cover Art Providers`: **None** (originally Local, Covert Art Archive: Release, TheAudioDB, fanart.tv)

* `Options` > `Options` > `Scripting`: Disable

  > *Note*: **DNU** (do not use) the `Singleton SetMulti, UpperCase, CopyMerge, SortMulti` either

  * `SetMulti, UpperCase, CopyMerge, SortMulti`
  * `releasedate`
  * `releaseyear`
  * `Decade`
  * `Date Formatted As Year`
  * `artistsort & delprefix`
  * `albumartistsort & delprefix`

* `Options` > `Options` > `Scripting`: Enable `CopyMerge Singleton`

* `Options`: `move files` **OFF** -- **UNTICK**

### Preserve Tags

`Album`, `Track Number`, `Date`, `Album Artist`, `album artist`, `Album Artist Sort Order`, `Compilation (iTunes):1`, `decade`, `Total Tracks`, `year`

### Resultant tags (after scanning)

#### ~~Use Original?~~

* `Title`, `Artist`

#### ~~Delete~~

> Struck because no longer needed since the tag fields below are now being deleted automatically from the CopyMerge Singleton script



`Disc Number`, `mb release artist`, `mb release grp`, `mb release id`, `mb work id`, `Total Discs`, `Total Tracks`

```
discnumber
musicbrainz_albumartistid
musicbrainz_releasegroupid
musicbrainz_albumid
musicbrainz_workid
musicbrainz_albumartist
musicbrainz_albumartistsortname
totaldiscs
totaltracks
```

