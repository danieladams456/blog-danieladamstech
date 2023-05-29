---
title: "Hello World"
date: 2023-05-29T06:00:00-04:00
draft: true
tags: ["writing"]
---

Two things are coming together in this moment to make me want to write a blog. One has been a desire for a while, and the other, a recent realization of necessity.

## Writing

The more recent but more driving factor is improving my writing. Several of the sources I read and listen to have been emphasizing the importance of writing lately. Brian Chambers, chief enterprise architect at Chick-fil-a, has [advocated for writing in public](https://brianchambers.substack.com/p/chamber-of-tech-secrets-10). One of the resources linked in his post is [Matt Rickard's blog](https://blog.matt-rickard.com/), which I now follow. Brian's description is:

> Matt writes every day and is incredible at cross-disciplinary pattern matching. I was amazed to learn he writes these super-technical posts in ~20 minutes a day. 🤯

This reminded me of the book [Range](https://www.goodreads.com/en/book/show/41795733) my brother got me for christmas a couple years ago. I don't read enough to be truly good at cross-disciplinary pattern matching, but it is a long term goal. [The Staff Engineer's Path](https://www.oreilly.com/library/view/the-staff-engineers/9781098118723/) (recommended by [Gergely Orosz](https://www.pragmaticengineer.com/)) championed writing as the way to scale influence across a large tech org. Several recent [Changelog](https://changelog.com/podcast) episodes have featured writers who have encouraged others to develop that skill as well.

And we all know about Hamilton's writing thanks to Lin-Manuel Miranda! ⭐️🕺🏻🎶

## Tech

The other half of the equation is playing with new tech. I have used AWS Lambda for a long time, but have been itching to try out some other serverless application building blocks. I have been following [Cloudflare's blog](https://blog.cloudflare.com/) for 3-4 years for their excellent tech articles. By the way, they have the best transparent postmortems I have ever seen, a fact that was also [highlighted by Gergely when analyzing the DataDog outage](https://newsletter.pragmaticengineer.com/p/inside-the-datadog-outage).

I created this blog using a static site hosted on [Cloudflare Pages](https://pages.cloudflare.com/). I had looked at static site generators several years ago but never ended up creating a website at that time. Hugo was popular then, but now [11ty](https://www.11ty.dev/) seems to be the top one for speed + flexibility. I still stuck with [Hugo](https://gohugo.io/) for its single-binary simplicity.

This site and the Terraform for Cloudflare configuration are public on my github at [blog-danieladamstech](https://github.com/danieladams456/blog-danieladamstech) and [terraform-danieladamstech-cloudflare](https://github.com/danieladams456/terraform-danieladamstech-cloudflare). I'd like to keep the Terraform public as long as possible since it is relatively non-sensitive at the moment, but I might split off any more sensitive bits into a private repo if needed in the future.

In the future, I would like to try out [Cloudflare Workers](https://workers.cloudflare.com/) since the zero cold start performance properties are very interesting and remove a lot of the tradeoff you would previously have to evaluate when deciding whether to adopt serverless. Cloudflare is also innovative in the application zero trust architecture space. I would like to try out hosting some app on my Raspberry Pi and using Cloudflare [Tunnels](https://www.cloudflare.com/products/tunnel/) and [Access](https://www.cloudflare.com/products/zero-trust/access/) to expose it without opening up my home network to internet ingress.
