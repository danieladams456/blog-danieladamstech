---
title: "Rss Setup"
date: 2023-07-17T06:00:00-04:00
tags: ["blog"]
---

I like RSS as an idea/protocol as well as a reading experience. It is one of the few places on the internet where you can consume only desired content and don't have algorithms pushing something else. Pulling RSS feeds from various sites embodies the peer-to-peer nature of the internet. Over time, we have swayed toward central entities being our conduit to information contained on other sites (Google, Facebook, Twitter, link aggregators like Reddit).

I used Google Reader in high school until it was shut down during my college years. [This history article](https://www.theverge.com/23778253/google-reader-death-2013-rss-social) gives a view inside how the "project" started and how it continually struggled to get recognized as a "product" within Google.

To set up my blog's RSS feed, I first looked in the build directory and saw [index.xml](/index.xml). Cool! I typed my site address into [Feedly](https://feedly.com/) and it did pull a feed. However, the default implementation only uses the [`.Summary`](https://gohugo.io/content-management/summaries/) text as part of the RSS feed. This by default is the sentences that include the first 70 words, but can be customized by a `<!--more-- >` divider. My issue wasn't with the length of the summary, but that it was not clear that there was more to the article. I looked into a way to add a "Continue reading at $LINK" text at the end. That required changing the template. The respective [Hugo framework](https://github.com/gohugoio/hugo/blob/master/tpl/tplimpl/embedded/templates/_default/rss.xml) and [Papermod theme](https://github.com/adityatelange/hugo-PaperMod/blob/master/layouts/_default/rss.xml) RSS templates were very similar and didn't have a provision for tacking on an ending footer. I wanted to stay aligned with upstream so didn't go that route.

The Papermod theme adds this provision for full article text. You don't get article page view counts if I added basic, non-invasive analytics in the future, but I liked the full article in the feed better as a reading experience. So I set the show full text parameter in [this commit](https://github.com/danieladams456/blog-danieladamstech/commit/f691d4e8cfdb3b08f805a62ffeaa03a038c4a296).

```go
{{- if site.Params.ShowFullTextinRSS }}
<content:encoded>{{ (printf "<![CDATA[%s]]>" .Content) | safeHTML }}</content:encoded>
{{- end }}
```

I wanted to make sure the increased size of the full article text wouldn't have a negative impact on feed XML load time so capped it. This pre-processor code at the start of the feed template has a parameter to limit to a certain number of the most recent posts. I set it to 2 for testing and then updated the parameter to a value of 20.

```go
{{- $limit := site.Config.Services.RSS.Limit -}}
{{- if ge $limit 1 -}}
{{- $pages = $pages | first $limit -}}
{{- end -}}
```

Then after making the change, I found the official [Hugo RSS docs](https://gohugo.io/templates/rss/) that mentioned the parameter should be `rssLimit`. My previous configuration of `services.rss.limit` must have been an internal parameter, so I updated to the "public API surface" [here](https://github.com/danieladams456/blog-danieladamstech/commit/c9525cc870252d03b3f650f2b108856b4ae6c777). Now, everything is set up as desired!
