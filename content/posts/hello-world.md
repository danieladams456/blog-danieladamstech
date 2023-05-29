---
title: "Hello World"
date: 2023-05-29T06:00:00-04:00
draft: true
tags: ["writing"]
---

Two things are coming together at this moment leading me to start this blog. Exploring new tech has been a desire for a while. The other, writing, is a recent realization of necessity. My personal goal is to write one post a week for the next year.

## Writing

The more contemporary driving factor is improving my writing. Several sources I've read and listened to lately have emphasized the importance of writing. Brian Chambers, chief enterprise architect at Chick-fil-a, has [advocated for writing in public](https://brianchambers.substack.com/p/chamber-of-tech-secrets-10). One of the resources linked in his post is [Matt Rickard's blog](https://blog.matt-rickard.com/), which I now follow. Brian's description is:

> Matt writes every day and is incredible at cross-disciplinary pattern matching. I was amazed to learn he writes these super-technical posts in ~20 minutes a day. 🤯

Matt's daily writing of synthesized thought is amazing! "Cross-disciplinary pattern matching" reminds me of the book [Range](https://www.goodreads.com/en/book/show/41795733) my brother got me for Christmas several years ago. I haven't read enough to possess that skill set, but it is a long-term goal. [The Staff Engineer's Path](https://www.oreilly.com/library/view/the-staff-engineers/9781098118723/) (recommended by [Gergely Orosz](https://www.pragmaticengineer.com/)) champions writing as the way to scale influence across a large tech org. Several recent [Changelog](https://changelog.com/podcast) episodes featured writers who encouraged others to develop that skill as well.

And we all know about Hamilton's writing thanks to Lin-Manuel Miranda's compositions! ⭐️🕺🏻🎶

## Tech

The other half of the equation is playing with new tech. I have used AWS Lambda for a long time, but have been itching to try out some other serverless application building blocks. I have been following [Cloudflare's blog](https://blog.cloudflare.com/) for 4 years for their excellent tech articles. By the way, they write the best, most transparent postmortems I have ever seen, a fact that [Gergely highlighted when analyzing the DataDog outage](https://newsletter.pragmaticengineer.com/p/inside-the-datadog-outage).

I created this blog using a static site hosted on [Cloudflare Pages](https://pages.cloudflare.com/). I had looked at static site generators several years ago, but never ended up creating a website at that time. [Hugo](https://gohugo.io/) was popular then, but now [11ty](https://www.11ty.dev/) seems to be the top one for templating flexibility. I still stuck with Hugo for its single-binary simplicity.

This site and the Terraform for Cloudflare configuration are public on my GitHub at [blog-danieladamstech](https://github.com/danieladams456/blog-danieladamstech) and [terraform-danieladamstech-cloudflare](https://github.com/danieladams456/terraform-danieladamstech-cloudflare). I'd like to keep the Terraform public as long as possible. For now, it is relatively non-sensitive, but I might create new app configs in a private repo as needed.

In the future, I want to try building an API with [Cloudflare Workers](https://workers.cloudflare.com/). No cold starts would remove a major traditional downside of adopting serverless. Cloudflare is also innovative in the application zero trust architecture space. I would like to host an app on my Raspberry Pi and use Cloudflare [Tunnels](https://www.cloudflare.com/products/tunnel/) with [Access](https://www.cloudflare.com/products/zero-trust/access/) to expose it without opening up my home network to internet ingress.

Thanks for reading, and hope you enjoy future posts!
