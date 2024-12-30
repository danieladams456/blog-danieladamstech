---
title: "Call Graph Voting Proposal"
date: 2024-12-28T22:00:00-05:00
draft: true
---

We all have errors.  What is your nominal error rate?  What does that mean?  Who's fault are the errors?  If we couldn't complete an order since the product hasn't yet received regulatory approval in the user's state, what HTTP status code is that?

There's two aspects I believe need solved.
1. More granular status categorization than HTTP codes get you by themselves, including ambiguity.
2. Propogation of and voting on fault assignment as requests travel through depth and breadth of a microservice call graph.
3. Monitoring APIs that only use a single HTTP code, like industry-specific XML APIs that report status in the body.

Two benefits can come out of this.
1. Combine multiple error conditions into semantic levels.  This allows for monitoring complexity to stay semi-bounded as the number of error conditions grows.
2. Fault assignment allows SLO creation.  Without a higher level categorization, SLO inclusion/exclusion logic can be brittle.

What do you think?  Should we just attach very explicit business meaning to HTTP codes?  Does leaving them decoupled retain more flexibility for changing alert severity while still keeping API response codes stable?