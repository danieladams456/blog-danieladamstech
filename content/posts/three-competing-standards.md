---
title: "Three Competing Standards"
date: 2024-04-09T16:41:58-04:00
draft: true
---

Today, we'll look at two over-the-air transmission use cases that each spawned three different protocol standards. I'll include some pattern observations with respect to the two sets.

First, the obligatory XKCD.

![standards](https://imgs.xkcd.com/comics/standards.png)

The two domains we'll be looking at are **Ham radio digital voice** and **first-person-view drone video feeds**. Both of these existed in analog form, and then digital alternatives came out and started gaining adoption.

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

[Drone runtime software video transmitter documentation](https://betaflight.com/docs/wiki/getting-started/hardware/vtx) gives a concise comparison between the three standards.

HDZero is uncompressed, so all pixels are sent independently. This allows transmission errors to be [isolated to single pixels](https://www.hd-zero.com/motion-clarity) instead of being more intertwined with larger sections of the image. You can think of this as similar to [UDP.](https://en.wikipedia.org/wiki/User_Datagram_Protocol) Transmission is one-way with no retransmissions. Information that does arrive has the lowest possible latency, and we just deal with missing information. The main use case for HDZero is in racing or other shorter-distance situations where the lowest latency is required to enable quick reaction times.

DJI and Walksnail follow more of a [TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol) approach. The receiver will ask for retransmission of any data that was missed. It usually goes through the second or third time, so in the end, the pilot has a perfect picture. As signal degrades, it isn't the quality of the video feed that goes down, it's the latency as more transmission attempts are required. The retransmissions allow these systems to have greater overall range than single-shot transmission systems like analog and HDZero at the expense of higher latency.

### Observations

There will always be multiple standards in anything that has utility or economic opportunity. That is the great thing about competition on the free market. The existence of other standards pushes everyone to iterate and improve their offering.

After a couple of years, things settle down into a couple of winners. Generally these will have different tradeoffs that will appeal to different use cases. Once the major use cases are covered, there's not as much of a reason to create a new standard as the incremental improvement would be small and it would be an uphill battle to displace existing market share.

A pattern I see in these two situations (potentially [overfitting](https://en.wikipedia.org/wiki/Overfitting) on this small data set) is a set of three top runners with two approaches. Two of the standards use a similar approach, and the third has something fundamentally different. In the digital voice category, DMR is the standout with its timeslots capability. HDZero is by itself in drone digital video with its one-way transmissions.

Being different does not necessarily make you the winner. DMR has "won" in the last couple of years as the favorite. Their ability to have multiple concurrent conversations on different time slots is the killer feature that sets them apart. HDZero makes tradeoffs with downsides (lower latency for less range.) This makes it a use-case specific decision.

Ultimately, winners must manage additional factors than just what provides the best capability for the user [(VHS vs Betamax).](https://en.wikipedia.org/wiki/Videotape_format_war) Despite being the favorite, I am predicting DMR will take 10 years before it has a majority of the market share. Protocols have a strong network effect. You want to be on the same one as your friends, and if a metropolitan area already has several repeaters (radio towers) of a certain variety, the next incremental installation will probably be more of the same. Yaesu [flooded the market](https://www.facebook.com/groups/YaesuSystemFusionOfficial/posts/1088671291666478/) with at-cost repeaters around 2018-2021 to establish themselves as the dominant protocol. They knew they would make the money back on the handheld radios people would buy to connect to the repeaters.
