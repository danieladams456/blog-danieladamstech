---
title: "Three Competing Standards"
date: 2024-04-09T16:41:58-04:00
draft: true
---

Today, we'll look at two over-the-air transmission use cases that each spawned three different protocol standards. I'll include some pattern observations with respect to the two sets.

First, the obligatory XKCD.

![standards](https://imgs.xkcd.com/comics/standards.png)

The two domains we'll be looking at are **Ham radio digital voice** and **first-person-view drone video feeds**. Both of these used to exist in analog form, and then digital alternatives came out and started gaining adoption.

### Ham Radio Digital Voice

- [Digital Mobile Radio (DMR)](https://en.wikipedia.org/wiki/Digital_mobile_radio)
- [D-STAR](https://en.wikipedia.org/wiki/D-STAR)
- [Yaesu System Fusion (YSF)](https://systemfusion.yaesu.com/what-is-system-fusion/)
- Analog predecessor: [Frequency Modulation (FM)](https://en.wikipedia.org/wiki/Frequency_modulation)

### First-Person-View Video Transmitters

- [DJI O3](https://www.dji.com/o3-air-unit)
- [HDZero](https://www.hd-zero.com/technology)
- [Walksnail](https://caddxfpv.com/)
- Analog predecessor: [NTSC](https://en.wikipedia.org/wiki/NTSC) or [PAL,](https://en.wikipedia.org/wiki/PAL) like analog TV

[Betaflight documentation](https://betaflight.com/docs/wiki/getting-started/hardware/vtx) gives a concise comparison between the three standards.
HDZero is uncompressed, so all pixels are sent independently. This allows transmission errors to be [isolated to single pixels](https://www.hd-zero.com/motion-clarity) instead of being more intertwined with larger sections of the image.
