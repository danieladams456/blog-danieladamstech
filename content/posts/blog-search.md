---
title: "Blog Search and Premature Optimization"
date: 2023-09-21T21:00:00-04:00
draft: true
---

Head over to the [search](/search/) page to try out the newly added search feature!

Hugo has a [docs page on search options.](https://gohugo.io/tools/search/) Most solutions leverage [lunr](https://lunrjs.com/) or [fuse,](https://www.fusejs.io/) both JavaScript client-side libraries. This theme, Papermod, [supports search](https://github.com/adityatelange/hugo-PaperMod/wiki/Features#search-page) with fuse.js via Hugo's native [JSON output format.](https://gohugo.io/templates/output-formats/#customizing-output-formats)

When I turned on and enabled this, I noticed the JSON output at [index.json](/index.json) had the full text content of all blog posts. Fuse.js pulls this JSON client side and performs a fuzzy search on the content. Right now, the file size is 100KB, not bad. It did made me think how long it will take to grow large enough I'd rather not have it taking up bandwidth. The search page is probably more likely to be used from a laptop where data transfer matters less than on a mobile device.

[Pagefind](https://pagefind.app/) is a static site client-side search library focused on bandwidth efficiency. It released [1.0.0 last week.](https://github.com/CloudCannon/pagefind/releases/tag/v1.0.0) When I ran the CLI on my site, it generated a binary index for more compression. Playing with it on the [Pagefind website](https://pagefind.app/) leads me to believe it stores compressed full text of the pages instead of just wordlists since it will show sentence fragments the search term was found in. Very interesting!

As we all have heard, ["premature optimization is the root of all evil."](https://ubiquity.acm.org/article.cfm?id=1513451) The theme's default search on the full JSON dump of all blog posts is a fine place to start. Later if I write enough that it grows to 1MB, I will probably start looking at alternatives. I could investigate the level of compression something like Pagefind gives. It might scale closer to O(log n) and give more of a size difference than it does on my current small site size. Another option would be a search service like [Algolia.](https://www.algolia.com)
