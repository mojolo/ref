# Dracula

### Color Palette

| Palette                                                      | Color     | ANSI 16 | ANSI 256 | HEX       |
| ------------------------------------------------------------ | --------- | ------- | -------- | --------- |
| Background <span style="background-color: #282A36">        </span> |           | 30      | 59       | `#282A36` |
| Current Line <span style="background-color: #44475A">        </span> |           | 30      | 60       | `#44475A` |
| Foreground <span style="background-color: #F8F8F2">        </span> | 7         | 97      | 231      | `#F8F8F2` |
| Comment <span style="background-color: #6272A4">         </span> | 8         | 34      | 103      | `#6272A4` |
| **BASE** ---                                                 | ---       | ---     | ---      | ---       |
| Black <span style="background-color: #21222c">        </span> | 0         |         |          | `#21222C` |
| Red <span style="background-color: #FF5555">        </span>  | 1         | 91      | 210      | `#FF5555` |
| Green <span style="background-color: #50FA7B">         </span> | 2         | 92      | 120      | `#50FA7B` |
| Yellow <span style="background-color: #F1FA8C">        </span> | 3         | 97      | 229      | `#F1FA8C` |
| Blue/Purple <span style="background-color: #BD93F9">        </span> | 4         | 97      | 183      | `#BD93F9` |
| Magenta/Pink <span style="background-color: #FF79C6">        </span> | 5         | 95      | 212      | `#FF79C6` |
| Cyan <span style="background-color: #8BE9FD">         </span> | 6         | 97      | 159      | `#8BE9FD` |
| White <span style="background-color: #F8F8F2">        </span> | 7         |         |          | `#F8F8F2` |
| Orange <span style="background-color: #FFB86C">        </span> |           | 93      | 222      | `#FFB86C` |
| **EXTRA** ---                                                | ---       | ---     | ---      | ---       |
| Black <span style="background-color: #6272A4">        </span> | 8         |         |          | `#6272A4` |
| Br. Red <span style="background-color: #FF6E6E">        </span> | 9         |         |          | `#FF6E6E` |
| Br. Green <span style="background-color: #69FF94">        </span> | 10        |         |          | `#69FF94` |
| Br. Yellow <span style="background-color: #FFFFA5">        </span> | 11        |         |          | `#FFFFA5` |
| Br. Blue/Purple <span style="background-color: #D6ACFF">        </span> | 12        |         |          | `#D6ACFF` |
| Br. Magenta/Pink <span style="background-color: #FF92DF">        </span> | 13        |         |          | `#FF92DF` |
| Br. Cyan <span style="background-color: #A4FFFF">        </span> | 14        |         |          | `#A4FFFF` |
| Br. White <span style="background-color: #FFFFFF">        </span> | 15        |         |          | `#FFFFFF` |
| Sel. Foreground <span style="background-color: #FFFFFF">        </span> | 15        |         |          | `#FFFFFF` |
| Sel. Background <span style="background-color: #44475A">        </span> | Curr Line |         |          | `#44475A` |
| URL (Cyan) <span style="background-color: #8BE9FD">         </span> | 6         | 97      | 159      | `#8BE9FD` |
| Cursor (White) <span style="background-color: #F8F8F2">        </span> | 7         | 97      | 231      | `#F8F8F2` |
| Cursor Text <span style="background-color: #282A36">        </span> | Bgnd      | 30      | 59       | `#282A36` |
| Mark1 <span style="background-color: #282A36">        </span> | Bgnd      | 30      | 59       | `#282A36` |
| Mark1 Bgnd <span style="background-color: #FF5555">        </span> | 1         | 91      | 210      | `#FF5555` |
|                                                              |           |         |          |           |
|                                                              |           |         |          |           |
|                                                              |           |         |          |           |
|                                                              |           |         |          |           |
|                                                              |           |         |          |           |



---

### Color codes

Most terminals support 8 and 16 colors, as well as 256  (8-bit) colors. These colors are set by the user, but have commonly  defined meanings.

#### 

#### 8-16 Colors

| Color Name | FG: 16/256 | BG: 16/256  | 256  |
| ---------- | ---------- | ----------- | ---- |
| Black      | `30` , `0` | `40` , `8`  | 0    |
| Red        | `31` , `1` | `41` , `9`  | 1    |
| Green      | `32` , `2` | `42` , `10` | 2    |
| Yellow     | `33` , `3` | `43` , `11` | 3    |
| Blue       | `34` , `4` | `44` , `12` | 4    |
| Magenta    | `35` , `5` | `45` , `13` | 5    |
| Cyan       | `36` , `6` | `46` , `14` |      |
| White      | `37` , `7` | `47` , `15` |      |
| Default    | `39`       | `49`        |      |
| Reset      | `0`        | `0`         |      |

> **Note:** the *Reset* color is the reset code that resets *all* colors and text effects, Use *Default* color to reset colors only.

Most terminals, apart from the basic set of 8 colors, also support the "bright" or "bold" colors. These have their own set of  codes, mirroring the normal colors, but with an additional `;1` in their codes:

```
# Set style to bold, red foreground.
\x1b[1;31mHello
# Set style to dimmed white foreground with red background.
\x1b[2;37;41mWorld
```

Terminals that support the [aixterm specification](https://sites.ualberta.ca/dept/chemeng/AIX-43/share/man/info/C/a_doc_lib/cmds/aixcmds1/aixterm.htm) provides bright versions of the ISO colors, without the need to use the bold modifier:

| Color Name     | Foreground Color Code | Background Color Code |
| -------------- | --------------------- | --------------------- |
| Bright Black   | `90`                  | `100`                 |
| Bright Red     | `91`                  | `101`                 |
| Bright Green   | `92`                  | `102`                 |
| Bright Yellow  | `93`                  | `103`                 |
| Bright Blue    | `94`                  | `104`                 |
| Bright Magenta | `95`                  | `105`                 |
| Bright Cyan    | `96`                  | `106`                 |
| Bright White   | `97`                  | `107`                 |

