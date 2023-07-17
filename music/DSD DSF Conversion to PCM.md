## [The 24-Bit Delusion? (pg 13)](https://forums.stevehoffman.tv/threads/the-24-bit-delusion.921020/page-13)

I tried to use Weiss Saracon to convert from DSD to PCM. Under PCM output I have the following settings:

- **16 bit** (my choice)
- **Dither** : **TPDF** (default)
      (Other options: POWr1, POWr2, POWr3)
- **Sample**: **44** (my choice)
- **Gain DP 6.000000** ( the default choice)
- **Batch Mode** : **Smart Interleave**
      (Other options: normal, interleave all, split)

Which Dither, Gain and Batch Mode should I choose?

---

##### Dither

Whichever sounds best to you, or for the music being converted.

##### Gain

Depends on the maximum signal level of the source.  This used  to be really easy, 0 dB SACD = -6 dB PCM, but Sony Japan forced a change which allows SACD to peak at +3.1 dB SACD, so adding 6 dB in the  conversion could result in PCM clipping.  You will need to experiment to find the best level, and it will be on a case-by-case basis.

##### Batch Mode

Not sure how smart Smart Interleave is, but you require Normal mode.  Since you are inputting an interleaved file (either stereo or M-ch), you want the output to be a single file too.  Smart Interleave may realize that and revert to Normal.  If not, select  Normal.  You would use the interleave or split modes if you had mono  files and needed to create a single interleaved playback file, or had a  single interleaved file and wanted to create mono files (by mono, I mean individual files for left front, right front, center, etc.).

---

#### [Configuring Weiss Saracon to convert from DSD to PCM?](https://forums.stevehoffman.tv/threads/configuring-weiss-saracon-to-convert-from-dsd-to-pcm.924924/)

I already answered to your question on another thread. Get Tascam Hi-Res Editor, do some tests with the Gain level and use the right POWr  dither/noise shaping for the different kinds of music. POWEr1 for highly compressed/brickwalled music, POWEr2 for mid dinamic range music like  properly recorded and mastered Pop, Rock or Jazz and POWEr3 for high  dinamic range music like Classical or orchestral movie soundtracks.

Do some test conversions with different gain levels to match the level  of your conversion to the one of the original DSD file and choose the  right dither/noise shaping.

---

I have all my SACD's ripped to ISO's and their tracks extracted with  ISO2DSD. I currently play my DSD files as DSD over PCM (native DSD put  into a WAV container, the D/A detects it's DSD and not 176.4/24 PCM)   but before that I got all my DSD files to 176.4/24 PCM with Weiss  Saracon.

To convert DSD to PCM you cannot rely on the default +6 dB boost as some SACD's are mastered at other level, you also have to keep in mind that  either dither and noise shapping take bits so you have to compensate for that. I'll tell you I got my DSD albums properly converted (at least  for me) to PCM.

Then get Tascam Hi-Res Editor that is free. This lets you play DSD  files, shows you the waveform of the DSD files so you can see the  highest level on the track and while playing it shows you the level on  dB at the playing moment. You just have to do some test conversions with the tracks of the album that have the highest level and with the "Gain  dB" setting try to level match your PCM conversion to the one of the  native DSD file with Tascam Hi-Res Editor. Just convert two or three  tracks of an album, the ones you think have the highest levels. Don't do your test conversions to FLAC as Tascam Hi-Res Editor doesn't play it,  convert to WAV.

I use TPDF dither for my DSD to 176.4/24 PCM conversions as I think  Noise Shaping is overkill for 24 bit digital,but If you're going to  convert to 44.1/16 use POWr 2 for Rock, Pop or Jazz, music that has not a very high dinamic range. Use POWEr3 for music with high dinamic range  as Classical Music or orchestral movie soundtracks (I've converted quite some of them), and only use POWr1 for highly compressed music on the  case you come by a highly compressed/brickwalled DSD album.

It's not hard; it just requires a little bit of practice, I had fun learning to use Weiss Saracon with trial and error.

... I forgot to say that I think Weiss Saracon has some kind of limiter so you never get distorsion. To check this out I converted Michael  Jackson's Thriller SACD that is mastered at -3 dB instead of the more  standard -6 dB, but I set the conversion level at +6 and I got no  distorsion, the levels on Tascam Hi-Res Editor never passed the 0 dB  point but sound was clearly compressed compared to the original DSD.

Because of the limiter I think Weiss Saracon has I prefer to convert at a slightly lower level (half a decibel or so) as there's plenty of  headroom when converting DSD to 24 bit as DSD has a theoretical  resolution of 20 bit on the audio band, wasting half a decibel doesn't  make the conversion noisier with 24 bit audio and all the dinamic range  of the DSD original is preserved, I prefer that to get a compressed  file.

---

Thanx kiko. All fine with me, except the gain level... I want the matter simpler for me, without tests.  

Is there away I play it safe with gain level? Eg, one safe configuration for all SACDs? 		

---

Nope. If you want to do it right you have to set levels right. Most  SACD's are mastered at -6 dB's but not all and you have to decrease at  least 0.5 dB if you're using dither (TPDF) or any POWr dither/noise  shaping. There's no "one size fits all" if you want to do it right. You  can set the level at 6 dB, the limiter function on Weiss Saracon will  prevent clipping but you will end up with dinamically compressed files  if the album you're converting is mastered at -3 dB for example.
 If you're using a pro software that excells at converting you may want  to learn to set it up right for each album if you want to use this  excelence.

If you don't want to bother with setting levels you can use Tascam  Hi.Res Editor that converts DSD to 44.1/16 without any set up, but you  have to convert the files one by one.

---

Does Weiss Saracon allow DSD to be converted to 32-bit float PCM?  The  reason I ask is that, in my experience, 32-bit float doesn't saturate  when an audio level goes more positive than 0 dB.  The relative signal  levels are maintained with 32-bit float even when the signal level would force signed integer audio into clipping.

```
According to the manual it supports both 32-bit and 64-bit IEEE floating-point, as well as 16/20/24/32-bit fixed-point.
```

I will concede that it may not be an optimal approach, but what I do  using my copy of AuI ConverteR 48x44 PRODuce-RD is to convert DSD to  176.4k/32-bit float as my PCM master.  Assuming I have a set of such PCM masters, say as the result of first extracting the ISO from one of my  SACDs, I then make a pass through those files with an audio editor  (Sound Forge Pro 11, in my case) to determine the maximum 32-bit float  peak level among them.  If that maximum peak level is some *x* dB (*x* being positive, zero, or negative) then I adjust the volume level of each of the files by -(*x* + 1.0)dB to make a set of working files.  Doing that puts the overall  peak level at -1.0dB...which leaves a bit of headroom for intersample  peaking, while keeping the same relative levels that held across all the DSD original files for the album. The working files can be downsampled, if desired, and dithered into 16-bit or 24-bit integer PCM.  The  downsampling and dithering can even be done while making the "working"  files, as long as the volume adjustment precedes dithering to 16-bit or  24-bit integer PCM within the file processes.

 Ultimately, that's only different in mechanics from your approach, and  your approach is completely correct, but I like that my 32-bit float  master files have full internal visibility within 32-bit float aware  audio applications.  Oh, calling them "master" files doesn't necessarily mean they have to be kept forever (though they can be), for me they are primarily PCM master files within the context of a particular DSD -> final PCM conversion.

---

I prefer, as most things in my life, the direct approach. Why convert a DSD file twice when Weiss Saracon can do it right away?

---

I'm only converting from DSD a single time.  The 32-bit float "master"  files don't even have to necessarily saved out to disc (though that's  safer). The files can be left open through the looking for peak levels  (I use a file "normalize" scan with Sound Forge Pro--scan only, no file  modification carried out--which gives a file's peak level to 1/10th dB), and only saved out once all steps to convert to final PCM have been  completed.  However, I fully understand your point and have no  disagreement with it whatsoever.  In fact, my original "*I will concede that it may not be an optimal approach*" for the method I was about to state, was written exactly with the advantages of your particular approach in mind.

 The approach I use isn't better than your approach, only an alternative  approach that some may view as advantageous...or not in the slightest  advantageous.  I just wanted to put my approach out there because I'd  never seen anyone state it, and, for me, it's a bit more algorithmic.  ![:)](https://forums.stevehoffman.tv/images/smilies/orangesmile.gif)

 Again for me, my approach also has an advantage in converting  multichannel DSD to multichannel PCM...something I do to make  multichannel DVD-A discs for my car from multichannel SACDs.  The number of channels doesn't affect the process in the slightest since, in my  case, AuI ConverteR and Sound Forge Pro are both multichannel capable.



## [DSF to FLAC... Size Is very big?!](https://forums.stevehoffman.tv/threads/dsf-to-flac-size-is-very-big.920707/)

Whether higher sampling or bit rates make an audible difference is a  controversial topic that has been hotly debated for many years now. So  there is no easy answer to it. I'm personally not sure if I can tell a  real difference, but that doesn't mean it's not there. Maybe my ears are just not up to the task (I'm 51). Or maybe it's my gear. Or I just  don't know what to listen for. Who knows?

I settled for keeping files in their original resolution, just to be  safe. Hard drive space is no real issue nowadays, so why not? And when I convert DSD to PCM, I usually choose 24/88,2, mostly because there  seems to be some sort of consensus that it comes closest to the original DSD file. Converting DSD to 16/44,1 seems pointless to me, because in  that case I could just rip the CD layer.

So my advice for DSD files is, convert to 24/88,2 and don't worry about  it anymore. But that's just me, others may see it differently.

---

I convert DSD to FLAC using Weiss Saracon to 176.4/24 adding TPDF  dither. The end result is great. With Weiss Saracon converting DSD to  PCM/FLAC I prefer 176.4 Khz to 88.2 Khz,it sounds more transparent, this may be because filtering on the playing end is farther from the actual  audio range.

---

It is possible to configure JRiver to do DSD to PCM file conversions at  24/88.2 instead of higher sample rates. In fact, it is possible to  configure JRiver to do DSD file conversions at 24/88.2 while doing live  playback conversions at higher sample rates. JRiver is quite flexible in its settings. Also can be confusing due to that flexibility.

In general, converting DSD to 24/88.2 PCM is optimal in that 88.2 is  high enough to capture the DSD64 data without being higher than  necessary. It's the mathmatical optimal. But for live playback of DSD to PCM conversion you may find it better to have JRiver do the conversion  at the highest PCM sample rate that your DAC will accept. It's something you'll have to experiment with and decide what sounds best to you with  your gear. 

The good news is that JRiver has the flexibility to allow you to do DSD  to PCM file conversions at one sample rate and live playback conversion  at a different sample rate.	

---

Yup, agree with [@wolfram](https://forums.stevehoffman.tv/members/20767/) above, for SACD (DSD64), just convert to 24/88.2 and be happy for high quality SACDs.

Remember that there are many PCM --> SACD upconversions out there (here's [my list of 44/48kHz upconversions](http://archimago.blogspot.com/2013/07/list-suspected-44-or-48khz-pcm.html)) so based on the quality of that SACD, you might not even need 24/88. I had a look at the 2014 SHM-SACD of *Zenyatta Mondatta* and I see that while it looks like it came from an analogue source  (could just be a digital playback routed thru analog mixer and  redigitized), it is quite noisy and there's really no content (just  noise) above 24kHz. Here's "De Do Do Do, De Da Da Da" from the same  album:

 ![[IMG]](https://i.imgur.com/ns8MFS9.png)

I'd be tempted to compare 24/88.2 and a 16/48 conversion to hear if I  can tell a difference. Sure, it's nice to keep samplerates to a specific family - 44/88/176/... and 48/96/192/... but these days the  asynchronous conversions are excellent so no need to obsess.

Storage is cheap these days, but still no need to waste IMO. 				

---

I always wanted to do a test between different sampling frequencies and  bit depths and check what has more impact on sound, if bit depth or  sampling rate.

As I'm not a pro and I don't have any analogue master tapes to convert  with pro D/A converters at different rates I tried the next best thing:  take The Film Music Of Jerry Goldsmith (the Stereo tracks) that is a  native DSD recording, and with Weiss Saracon try these PCM rates,  44.1/24, 44.1/16, 88.2/24, 88.2/16, 176.4/24, 176.4/16. Conversions were done using TPDF dither.

 The test may be influenced by how my Topping D50 D/A converter performs  at different sampling rates and bit depths, I also double the tests  using the internal D/A converters of my Pioneer SC LX-76 A/V receiver  from 2012 that uses CS4398 D/A's.
 With a native DSD recording with a high dinamic range like this and  using TPDF dither my conclusion (aka,my opinion based on what I heard  with my equipment) is that sampling rate has a bigger impact on sound  than bit depth. The 44.1/24 and 44.1/16 sounded the same,very "red  bookish". With 88.2/24 and 88.2/16 I had the feeling of hearing real Hi  Res sound, there was an extended soundstage and sense of depth that both 44.1 versions lack. With 176.4/24 and 176.4/16 the soundstage widens  even more, there's a bigger sense of separation between instruments and  more "air" in the recording and I never felt that the 176.4/16  conversion lacked dinamic range compared to the 176.4/24 or that the  timber of instruments changed. I could have used POW-R 3 dithering and  noise shaping (the best performing one of the three kinds for recordings with a wide dinamic range) with the 16 bit versions but I think it  wouldn't have been a fair comparison and on the other hand I don't need  24 bit audio needs any kind of noise shapping. Dither helps to get a  better linearity on the D/A end or so I read a long time ago.

My conclusion is that thanks to increased sample rate filtering is taken farther from the audio range so it has less impact on audible  frequencies, and the higher the sample rate used filtering is taken  farther from the audio range so it has less effect on the audible range. I do all my DSD to PCM conversions at 176.4/24 with TPDF dither. I  needed that on the past as my Pioneer SC LX-76 A/V receiver converts all incoming DSD data to PCM no matter if I use the Pure Direct mode  (despite the CS4398 IC being able of doing native DSD conversion), al  DSD was converted to PCM at an unkown resolution. When used right, Weiss Saracon converts DSD much better than the built in DSD to PCM  conversion on my receiver. This is not strange as Weiss Saracon costs  more than my 2000 Euros A/V receiver. 				

---

The SACD spec recommends low pass filtering at 50kHz.  So 176.4 is just  wasted space if you’re filtering properly; there is basically nothing  there between 88.2 and 176.4.

---

I know and in fact Weiss Saracon does filter frequencies at around 40  Khz when converting from DSD to PCM. Anyway, converting to 176.4 Khz  sounds better tomy ears than 88.2 but that could be a matter of how my  set up plays different sample rates. Some D/A converters behave  differently when different sample frequencies,not only frequency  extension wise. 

---

I’m not sure why it would.  There’s nothing there and it’s not like it’s upsampling.  But if you’re happier with it, more power to ya.



## [DSD file rip converter?](https://forums.stevehoffman.tv/threads/dsd-file-rip-converter.1031868/)

* [TASCAM Hi-Res Editor | OVERVIEW | TASCAM | International Website ](https://tascam.com/int/product/hi-res_editor/top)
* [dBpoweramp: mp3 Converter, CD Ripper, FLAC, Apple Lossless, WAV, AAC, AIFF. Fix album art, Asset UPnP Server ](https://www.dbpoweramp.com)
      By default, it will convert DSD files to 24bit/96kHz in a variety of audio formats.
* JRiver Media Center 27 has something called DSP Studio that can now  import and employ VST3 plugins. I'm not familiar enough with the Digital Audio Workstation world to know if there are plugins that would be  useful to you, but if so, at least you wouldn't have to make a hardware  purchase.

For your reading pleasure:

* [Archimago's Musings: ANALYSIS: A Comparison of DSD Encoders & Decoders (KORG AudioGate, JRiver MC, Weiss Saracon) ](http://archimago.blogspot.com/2014/04/analysis-comparison-of-dsd-encoders.html)

* [Archimago's Musings: ANALYSIS: DSD-to-PCM Conversion 2015 - Windows & Mac OS X ](http://archimago.blogspot.com/2015/04/analysis-dsd-decoders-2015-windows-mac.html)

* [Archimago's Musings: ANALYSIS: DSD-to-PCM 2015 - foobar SACD Plug-In, AuI ConverteR, noise & impulse response... ](http://archimago.blogspot.com/2015/04/analysis-dsd-to-pcm-2015-foobar-sacd.html)

  ​    [@Archimago](https://forums.stevehoffman.tv/members/23723/) is a member here, so he may be able to comment on whether there is  anything newer/better that he's found since writing the above.

---

Just be aware that all software tools to convert DSD to PCM are not equal. Some sound better than others. Some much better.

I've been ripping SACDs. My favorite DACs are PCM only. So I've been on a quest to find a way to convert the DSD to high-res PCM that sounds good to me and is affordable. The best I've found so far is Weiss Saracon  but it's almost $2000 for the software. Yikes! The freeware tools and  inexpensive tools to convert DSD to PCM have not sounded good enough to  me. But I haven't yet tried them all. Maybe I'll find one I like and  consider good enough. I can't justify spending $2000 on software to  convert DSD to PCM. I'm not a mastering engineer who can bill this and  consider this a business expense. I'm just me with a limited audio  budget. HQPlayer is able to convert DSD to PCM on the fly and play it in its built-in audio player software and is about $260. But if you want  to actually save that conversion to a file you suddenly need the  mastering engineer version that is $3000. Yikes. This stuff gets  expensive if you want to do it to the quality that mastering engineers  and other audio engineering professionals use. 

Listen to the results of the various DSD to PCM conversion software you  find. Make sure the results are good enough for you. And keep the  original DSD files so you can redo the conversions again if/when you  find better tools to do the conversion.