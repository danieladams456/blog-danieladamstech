---
title: "The Fediverse, LLMs, and Rate Limiting"
date: 2023-07-13T12:49:24-04:00
tags: ["hypothesis"]
draft: true
---

Both Reddit and Twitter made policy changes over the last couple months to restrict API access purportedly due to large increases in LLM training traffic.

# Centralized Social Media

I was just refreshing myself on the reddit situation timeline on [Wikipedia](https://en.wikipedia.org/wiki/2023_Reddit_API_controversy). [Reuters reported Feb 14](https://www.reuters.com/technology/reddit-aims-ipo-second-half-2023-information-2023-02-14/) that Reddit was looking to IPO in the second half of 2023. April 18th brought the announcement that Reddit would be charging for API access after a 60 day notice period ([Reddit](https://www.redditinc.com/blog/2023apiupdates), [The Verge](https://www.reuters.com/technology/reddit-aims-ipo-second-half-2023-information-2023-02-14/)). Mods staged a unified protest, shutting down several of the top subreddits June 12-14 by making them private. Some subreddits stayed private after the 48 hour "blackout." Understandably, Reddit was going to do whatever possible to get back to business-as-usual and keep moving toward IPO. Two days later on June 16th, [mods got a message from Reddit](https://www.theverge.com/2023/6/16/23763538/reddit-blackout-api-protest-mod-replacement-threat) basically saying "open up or get replaced." This reminds me of the Israelite captivity by Nebuchadrezzar of Babylon and how he set up Zedekiah as a puppet king. ([2nd Kings 24:17](https://www.bible.com/bible/59/2KI.24.ESV)) That didn't turn out well for him later BTW when he revolted. ([2nd Kings 25](https://www.bible.com/bible/59/2KI.25.ESV))

Based on the investigation of Gergely Orosz of the Pragmatic Engineer, it seems like there was [a connection between Twitter's rate limits and cost cutting on GCP ML services](https://blog.pragmaticengineer.com/twitter-vs-instagram-threads/). Evidently those services are needed to provide the level of service people have expected from Twitter over the years.

Instagram has sized the opportunity Reddit and Twitter both started to launch their Threads product. They have not imposed any limits, probably to appeal to Reddit and Twitter uses to join their platform. One analysis I was listening to (pretty sure from the All In podcast) noted that Facebook and Instagram are both now image and video heavy platforms with one-way posting. Interactive discussion, like on Reddit and Twitter, provides much better LLM training material. The [Threads app data collection policy](https://twitter.com/jack/status/1676018291918372864) pointed out by Jack Dorsey reinforces this.

# The [Future?] Fediverse

The fediverse promises a different model of data ownership. The content creators have more control over their data and can take it with them when switching hosts or servers. [Mastodon](https://mastodon.social/) (Twitter replacement), [Lemmy](https://join-lemmy.org/) (Reddit replacement), and [Bluesky](https://blueskyweb.xyz/) with its [AT protocol](https://atproto.com/) are all apps in this category. It is too early to tell which ones will get long-term, mainstream adoption. [Mastadon.help](https://mastodon.help/instances) counts around 11,000 instances currently running.
