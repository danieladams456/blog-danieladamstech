---
title: "The Fediverse, LLMs, and Rate Limiting"
date: 2023-07-13T12:49:24-04:00
tags: ["hypothesis"]
draft: true
---

Both Reddit and Twitter made policy changes over the last couple months to restrict API access purportedly due to large increases in LLM training traffic.

## Centralized Social Media

I was just refreshing myself on the reddit situation timeline on [Wikipedia](https://en.wikipedia.org/wiki/2023_Reddit_API_controversy). [Reuters reported Feb 14](https://www.reuters.com/technology/reddit-aims-ipo-second-half-2023-information-2023-02-14/) that Reddit was looking to IPO in the second half of 2023. April 18th brought the announcement that Reddit would be charging for API access after a 60 day notice period ([Reddit](https://www.redditinc.com/blog/2023apiupdates), [The Verge](https://www.reuters.com/technology/reddit-aims-ipo-second-half-2023-information-2023-02-14/)). Mods staged a unified protest, shutting down several of the top subreddits June 12-14 by making them private. Some subreddits stayed private after the 48 hour "blackout." Understandably, Reddit was going to do whatever possible to get back to business-as-usual and keep moving toward IPO. Two days later on June 16th, [mods got a message from Reddit](https://www.theverge.com/2023/6/16/23763538/reddit-blackout-api-protest-mod-replacement-threat) basically saying "open up or get replaced." This reminds me of the Israelite captivity by Nebuchadrezzar of Babylon and how he set up Zedekiah as a puppet king. ([2nd Kings 24:17](https://www.bible.com/bible/59/2KI.24.ESV)) That didn't turn out well for him later BTW when he revolted. ([2nd Kings 25](https://www.bible.com/bible/59/2KI.25.ESV))

Based on the investigation of Gergely Orosz of the Pragmatic Engineer, it seems like there was [a connection between Twitter's rate limits and cost cutting on GCP ML services](https://blog.pragmaticengineer.com/twitter-vs-instagram-threads/). Evidently those services are needed to provide the level of service people have expected from Twitter over the years.

Instagram has sized the opportunity Reddit and Twitter both started to launch their Threads product. They have not imposed any limits, probably to appeal to Reddit and Twitter uses to join their platform. One analysis I was listening to (pretty sure from the All In podcast) noted that Facebook and Instagram are both now image and video heavy platforms with one-way posting. Interactive discussion, like on Reddit and Twitter, provides much better LLM training material. The [Threads app data collection policy](https://twitter.com/jack/status/1676018291918372864) pointed out by Jack Dorsey reinforces this.

## The [Future?] Fediverse

The fediverse promises a different model of data ownership. The content creators have more control over their data and can take it with them when switching hosts or servers. [Mastodon](https://mastodon.social/) (Twitter replacement), [Lemmy](https://join-lemmy.org/) (Reddit replacement), and [Bluesky](https://blueskyweb.xyz/) with its [AT protocol](https://atproto.com/) are all apps in this category. It is too early to tell which ones will get long-term, mainstream adoption. [Mastadon.help](https://mastodon.help/instances) counts over 11,000 instances currently running.

Here we'll look at various options for gathering LLM training data from a decentralized system.

### Scrape the Fediverse servers

In this option, extracting the conversations requires connecting to each server. With over 11,000 Mastodon servers, that sounds like it would take quite the coordination. In reality, people would probably track the number of active users and quality of interactions and just pull from the top 5% of servers. There is probably a long tail of experimental servers that never take off. Even with a small subset of total servers, maintaining the data pipelines seems like a [yak shave](https://sketchplanations.com/yak-shaving) taking effort away from _using_ the data for model training. It also takes more time and infrastructure to pull historical data as just getting from current time forward is probably not enough for the training needs.

Badly secured servers could have the majority of traffic coming from bots instead of real users. What does it take to stop this? Anonymous access is easy to turn off, but question is how much ML do it take to effectively stop data scraping by crawler accounts. Either need static validations like Captchas/PATs or analytics like access pattern outlier detection. This could become a big cat and mouse game for people running servers.

Honestly, this route sounds like a lose-lose for the people running the infrastructure and the people trying to train the models. All hosting parties have to worry about bot management, and model trainers have to worry about data pipelines.

### Add a node on the Fediverse to capture events

Organizations that want to train models could hook into the system and get streaming updates. At first glance, this doesn't look very promising. The [ActivityPub Follow activity](https://www.w3.org/TR/activitypub/#follow-activity-outbox) seems like it is user ([Actor](https://www.w3.org/TR/activitypub/#actor-objects)) specific. Mastodon has a "local timeline" that includes all posts on that server, but can't be subscribed to from another server. This is different than blockchain where every node on the chain has a full history. Social media has too much data streaming in all the time to make that model tenable. It seems like option #1 where you must visit all servers and manage those pipelines.

### Rely on a company to give you easily queryable, analytics-ready extracts

If the fediverse takes off, there will probably be companies that aggregate and sell access to a corpus for model training. This is similar to gateway products like [Cloudflare Web3](https://www.cloudflare.com/web3/) for Ethereum and IPFS. These products provide live API access to blockchain-based systems. The model training providers would be slightly different in that they are serving optimized, compacted historical and constantly appending data sets. Two methods this data could be surfaced are file-based access and live query capability.

File-based sharing is the method taken by [Snowflake Marketplace](https://www.snowflake.com/en/data-cloud/marketplace/) and [AWS Data Exchange](https://aws.amazon.com/data-exchange/). Providers solely sharing data and not managing consumer compute vastly simplifies their business. In all, it is probably more cost efficient to have one compute layer (consumer) than two compute layers (query engine on the provider and processing on the consumer). Spark and other analytics tools are used to dealing with the S3 API. [Spark SQL uses Catalogs](https://iceberg.apache.org/docs/latest/spark-configuration/) to configure connections for [querying Iceberg tables](https://iceberg.apache.org/docs/latest/spark-queries/) natively. Iceberg tables seem to be a popular abstraction for file-based data lakes when not using a more managed data layer like Snowflake. File-based sharing could also be done on ones own without being a part of a data exchange, but it could be a bit more effort to onboard customers than if they have an already established pattern with one of the major data exchanges.

A query engine approach would probably be similar to [Amazon Athena](https://aws.amazon.com/athena/) where customers can pay for managed query compute per GB scanned. This requires more multi-tenant infrastructure management on the part of the data provider. It can take a lot of engineering to cover the security and "noisy neighbor" issues when trying to run multi-tenant query infrastructure. The decision probably comes down to how flexibly consumers want to consume the data. File level access will be cheaper, but query can give consumers a more targeted data set.
