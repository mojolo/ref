#### Resample & Reduct Bit Depth (`sox` will automatically apply dither if necessary)

```
for flac in *.flac; do sox -SGV "${flac}" -r 48000 -b 16 ./resampled/"${flac}"; done
for flac in *.flac; do sox -SGV "${flac}" -r 44100 -b 16 ./resampled/"${flac}"; done
```

#### Reduce Bit Depth (`sox` will automatically apply dither if necessary)

> **Do we need `-G` option?**

```
for wav in *.wav; do sox -SGV "${wav}" -b 16 ./bitd/"${wav}.flac"; done
for wav in *.wav; do sox -SV "${wav}" -b 16 ./bitd/"${wav}"; done
```

#### Resample

```
for flac in *.flac; do sox -SGV "${flac}" -r 48000 ./resampled/"${flac}"; done
for flac in *.flac; do sox -SGV "${flac}" -r 96000 ./resampled/"${flac}"; done
for flac in *.flac; do sox -SGV "${flac}" -r 44100 ./resampled/"${flac}"; done
for wav in *.wav; do sox -SGV "${wav}" -r 96000 ./resampled/"${wav}"; done
```

#### `deemph` CD

```
for flac in *.flac; do sox "${flac}" ./deemph/"${flac}" deemph; done
for wav in *.wav; do sox "${wav}" ./deemph/"${wav}" deemph; done
```

#### Reduce Bit Depth and `deemph`

```
for flac in *.flac; do sox -SV "${flac}" -b 32 ./deemph/"${flac}.wav" deemph; done
```

#### 

--clobber                Don't prompt to overwrite output file (default)
-D, --no-dither          Don't dither automatically
-G, --guard              Use temporary files to guard against clipping--no-clobber             Prompt to overwrite output file
-q, --no-show-progress   Run in quiet mode; opposite of -S
--replay-gain track|album|off  Default: off (sox, rec), track (play)
-R                       Use default random numbers (same on each run of SoX)
-S, --show-progress      Display progress while processing audio data
--single-threaded        Disable parallel effects channels processing
--temp DIRECTORY         Specify the directory to use for temporary files
-V[LEVEL]                Increment or set verbosity level (default 2); levels:
                           1: failure messages
                           2: warnings
                           3: details of processing
                           4-6: increasing levels of debug messages

-v|--volume FACTOR       Input file volume adjustment factor (real number)
-e|--encoding ENCODING   Set encoding (ENCODING may be one of signed-integer,
                         unsigned-integer, floating-point, mu-law, a-law,
                         ima-adpcm, ms-adpcm, gsm-full-rate)
-b|--bits BITS           Encoded sample size in bits
-N|--reverse-nibbles     Encoded nibble-order
-X|--reverse-bits        Encoded bit-order
--endian little|big|swap Encoded byte-order; swap means opposite to default
-L/-B/-x                 Short options for the above
-c|--channels CHANNELS   Number of channels of audio data; e.g. 2 = stereo
-r|--rate RATE           Sample rate of audio
-C|--compression FACTOR  Compression factor for output format
--add-comment TEXT       Append output file comment
--comment TEXT           Specify comment text for the output file
--comment-file FILENAME  File containing comment text for the output file
--no-glob                Don't `glob' wildcard match the following filename

Install

 $ sudo apt-get install sox

Convert FLAC files from 24/48 bit to 16 bit

```
$ mkdir resampled
$ for flac in *.flac; do sox -S "${flac}" -r 44100 -b 16 ./resampled/"${flac}"; done
```

Convert 24-bit/96kHz audio to 16-bit/44.1kHz

Sox automatically dithers when it is appropriate to do so.

sox input.wav -b 16 -r 44.1k output.wav

sox input.wav -b 16 -r 44.1k **dither** output.wav

Convert 24-bit/96kHz audio to 16-bit/44.1kHz with shibata noise-shaping algorithm.

unless you're 100% sure that you need to use a specific algorithm for  the type of audio you have, just let SoX 'do the right thing' per your  command above.

sox input.wav -b 16 -r 44.1k output.wav dither -f shibata

Convert & dither without unnecessarily adding dither noise on silence

sox input.wav -b 16 -r 44.1k output.wav dither -a -f shibata

Clipping

As suggested by the tool, try reducing the volume slightly, e.g. by  preceding  with -v 0.99 (or 0.98 etc.).  Such small changes in volume  are imperceptible.  

Example:

```
sox -v 0.99 <source_wav> -b 16 <dest_wav> channels 1 rate 16000 trim <startTime> =<endTime>
```

If you still get clipping then the audio is likely severely clipped  (i.e. disorted) to begin with (this is common with modern music; see  Wikipedia: [Loudness war](http://en.wikipedia.org/wiki/Loudness_war)) and so the warnings can be ignored—no additional distortion is being introduced.

As mentioned in the comments, the -G option can be given which will  automatically make any adjustment to the volume needed to avoid clipping (at the expense of a little extra CPU time, i.e. it runs slightly  slower with -G).

it doesn't decrease the volume automatically as this takes a little  longer and is not always what you want to do. It can be enabled though  with the -G (guard) option; with -V it will tell you how many dBs of  attenuation had to be applied to prevent clipping (dB "not reclaimed").

### Remove Pre-Emphasis

- Use 32-bit bit depth & floating point (benefits from clipping protection & preserving low-level details)
- increase gain if there is any decent amount of headroom left after the de-emphasis
- Convert to 16-bit with dithering

```
$ mkdir deemph
$ for flac in *.flac; do sox -S "${flac}" -b 32 ./deemph/"${flac}.wav" deemph; done
$ cd deemph
$ mkdir resampled
$ for wav in *.wav; do sox -S "${wav}" -b 16 ./resampled/"${wav}.flac"; done
```

