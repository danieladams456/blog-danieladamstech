---
title: "Three Competing Standards"
date: 2024-04-20T20:00:00-04:00
linkedin: "What parallels exist between digital drone video transmission and ham radio digital voice modes?  Both have three main competing standards vying to be accepted protocol.  Each application has one entry that takes a fundamentally different approach than the other similar competitors."
---

Today, we'll look at two over-the-air transmission use cases that each spawned three different protocol standards. I'll include some pattern observations concerning the two sets.

First, the obligatory XKCD.

![standards](https://imgs.xkcd.com/comics/standards.png)

The two domains we'll be analyzing are **Ham radio digital voice** and **first-person-view drone video feeds**. Both of these existed in analog form, and then digital alternatives came out and started gaining adoption.

### Ham Radio Digital Voice

- [Digital Mobile Radio (DMR)](https://en.wikipedia.org/wiki/Digital_mobile_radio)
- [D-STAR](https://en.wikipedia.org/wiki/D-STAR)
- [Yaesu System Fusion (YSF)](https://systemfusion.yaesu.com/what-is-system-fusion/)
- Analog predecessor: [Frequency Modulation (FM)](https://en.wikipedia.org/wiki/Frequency_modulation)

D-STAR was the first of the main three digital voice modes by a long shot, starting development back in the 1990s. Then YSF launched in 2013, and DMR came from the commercial space to amateur space in 2014. YSF sought to improve on the status quo in the area of compatibility with analog FM through automatic mode detection and switching. It was never truly published as an open specification, which gave some people reservations about adopting it. DMR published its first set of specs (tier 1 and tier 2) in 2005 and tier 3 in 2012. Commercial radio manufacturers adopted the standard and began making products. Despite the standard being "commercial-first" and implementations less friendly for amateur use, the on-air protocol had advantages. The main one was that it uses [time-division multiple access](https://en.wikipedia.org/wiki/Time-division_multiple_access) to multiplex two conversations on the same frequency channel. Simultaneously transmitting multiple concurrent data streams is something we are used to now in packet and IP-based systems we have today, but historically, radio voice transmission had been a single stream per frequency.

### First-Person-View Video Transmitters

- [DJI O3](https://www.dji.com/o3-air-unit)
- [HDZero](https://www.hd-zero.com/technology)
- [Walksnail](https://caddxfpv.com/)
- Analog predecessor: [NTSC](https://en.wikipedia.org/wiki/NTSC) or [PAL,](https://en.wikipedia.org/wiki/PAL) like analog TV

[Drone runtime software video transmitter documentation](https://betaflight.com/docs/wiki/getting-started/hardware/vtx) gives a concise comparison between the three standards.

HDZero is uncompressed, so all pixels are sent independently. This allows transmission errors to be [isolated to single pixels](https://www.hd-zero.com/motion-clarity) instead of being more intertwined with larger sections of the image as is common in video compression codecs. Transmission is one-way with no retransmissions, similar to [UDP.](https://en.wikipedia.org/wiki/User_Datagram_Protocol) Information that does arrive has the lowest possible latency, and we just deal with missing information. The main use case for HDZero is in racing or other shorter-distance situations where the lowest latency is required to enable quick reaction times.

DJI and Walksnail follow more of a [TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol) approach. The receiver will ask for retransmission of any data that was missed. It usually succeeds on the second or third attempt, so in the end, the pilot has a perfect picture. As the signal degrades, it isn't the quality of the video feed that goes down, it's the latency as more transmission attempts are required. The retransmissions allow these systems to have greater overall range at the expense of higher latency than single-shot systems like analog and HDZero.

### Observations

There will always be multiple standards in anything that has utility or economic opportunity. That is the great thing about competition in the free market. The existence of other standards pushes everyone to iterate and improve their offering. After a couple of years, things settle down into a couple of winners. Generally, these will have different tradeoffs that will appeal to different use cases. Once the major use cases are covered, there's not as much of a reason to create a new standard as the incremental improvement would be small and it would be an uphill battle to displace existing market share.

A pattern I see in these two situations (potentially [overfitting](https://en.wikipedia.org/wiki/Overfitting) on this small data set) is a set of three top runners with two approaches. Two of the standards use a similar approach, and the third has something fundamentally different. In the digital voice category, DMR is the standout with its timeslots capability. HDZero is by itself in drone digital video with its one-way transmissions.

Being different does not necessarily make you the winner. DMR has "won" in the last couple of years as the favorite (depending on who you ask.) Their ability to have multiple concurrent conversations on different time slots is the killer feature that sets them apart. HDZero makes tradeoffs with downsides (lower latency for less range.) This makes it a use-case-specific decision.

Ultimately, winners must manage additional factors than just what provides the best capability for the user [(VHS vs Betamax).](https://en.wikipedia.org/wiki/Videotape_format_war) Despite being the favorite, I am predicting DMR will take 10 years before it has a majority of the market share. Communication protocols have a strong network effect. You want to be on the same one as your friends. If a metropolitan area already has several repeaters (radio towers) of a certain variety, the next incremental installation will probably be more of the same. Yaesu [flooded the market](https://www.facebook.com/groups/YaesuSystemFusionOfficial/posts/1088671291666478/) with at-cost repeaters around 2018-2021 to establish themselves as the dominant protocol. They knew they would make the money back on the handheld radios people would buy to connect to the repeaters.

These are just two sets of standards I've come across lately in hobby pursuits that seemed to parallel. I'm curious what other areas might be out there that exhibit similar phenomenon.
