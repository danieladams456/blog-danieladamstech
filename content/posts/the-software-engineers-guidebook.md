---
title: "The Software Engineers Guidebook"
date: 2024-01-10T21:06:58-05:00
draft: true
---

In my time off between Christmas and New Year, I generally read a book. Two great non-tech books I've read in past years are [Range: Why Generalists Triumph in a Specialized World](https://davidepstein.com/the-range/) and [The Spy and the Traitor: The Greatest Espionage Story of the Cold War](https://www.penguinrandomhouse.com/books/253399/the-spy-and-the-traitor-by-ben-macintyre/) on [Oleg Gordievsky.](https://en.wikipedia.org/wiki/Oleg_Gordievsky) Both of those were gifts from my brother.

This year's book was [The Software Engineer's Guidebook](https://www.engguidebook.com/) by Gergely Orosz. I am a reader of his newsletter, [The Pragmatic Engineer.](https://newsletter.pragmaticengineer.com/) The book traces through all software engineering career levels and highlights important practices to be following at each. I wanted to read through all of them and catch up on any tips or behaviors I had missed along the way. Below are groupings of advice I found helpful. The

### Own Your Own Career

YOU are the one responsible for your own continued learning and growth in your career! Reflecting on my own career growth, I have gone hard in most areas. These include broad and deep skill building as well as certifications. One activity I regret not starting sooner was signing up as an official mentee in the mentor program. I had worked on the team with our two Enterprise Architects for 3 years and learned a ton from them in an informal mentee relationship. I had some impostor syndrome if I was truly ready for a mentor from the business or would run out of things to ask them halfway through the year and look dumb. I'm so glad I took the plunge! Both my mentors have been very friendly and gracious. I switched partway through last year since my first mentor took a position as VP of Sales with around 140 reports at another company. Another career development move I know I need to make at some point is working for another company to get experience in scale. That one I'm going to need to time what works for my family, potentially the economic cycle/[ZIRP,](https://newsletter.pragmaticengineer.com/p/zirp) and navigate some more impostor syndrome.

In the eight years since college, [I have been on six teams.](https://blog.danieladamstech.com/2023/domain-allocation-trends/) Two of those I started from scratch (Cloud Engineering and Cloud Data Engineering.) I expanded my current Integrations team from being a business analyst group that borrowed developers from the general Services team to being a self-contained product team with software engineering group. I feel like I've stayed a good balance of time in each domain to grow deeper without the learning rate petering off. I currently hold [six AWS Certifications:](https://www.credly.com/users/daniel-adams.44f95131/badges) Architect and DevOps Pro, Data and Security Specialties, and the associate certs. My lapsed certs include CompTIA A+ (high school), Security+ (college), and Red Hat Certified Systems Administrator and Engineer on RHEL 7 (after college.)

The current balance I am trying to strike is how to best spend my time between coding and non-coding activities. I probably code between 30 and 40% of my time. I want to spend the remainder in high leverage direction-setting, doc writing, and mentoring tasks. In the project management realm, I am trying to be reflective on what are useful ways for me to contribute to coordinating smooth delivery while at the same time reserving time to personally help with some of the more critical migrations and implementations.

### Be Known as Someone Who Delivers

A prerequisite for being known as someone who delivers is to **actually** deliver. You should first be consistent, dependable, and meet or exceed the quality bar (see later about quality not being the end-all-be-all in some situations.) Then you can worry about if others are recognizing your results. It is important to not put the cart before the horse and try to sell something that's not there. Even when you are solid on the behavior, selling it can require walking a tightrope. You need to get a feel for what is acceptable in the engineering culture and not deviate too far from the norm. You don't want to come off as someone who just cares about their image more than the actual business outcomes. On the flip side, you don't want to sit on the sidelines assuming your work will speak for yourself in a company where there is an expectation to self-promote.

Avoid spreading yourself too thin in order to deliver meaningful work. My biggest takeaway from the book was "**know your #1 priority and always deliver that on time**." This priority should be stable for at least a week. Within the week, switching to a new #1 priority and should require managerial escalation and approval. I thought I was going to be able to use this and it be revolutionary... Turns out, it still doesn't mean you can just work on one or two things at a time. We are currently working on a major upgrade to one of our core business systems. There were three things we identified the Integrations team needed to contribute for customer rollout over a period of six weeks. Those were data synchronization from an on-prem system of record to the cloud, orchestration service updates, and new capabilities for our customer support tooling. The first two items were in the request path and had a dependency, so I took them. The third was independent, so I was hoping to get the request-path items done first and then start guiding someone on the support tooling. The good news was an offshore contractor had availability sooner than expected, so I am involved in breaking down the work for him sooner than I expected. At the end of the day, the timeline is still on track working on all three in parallel, just with a bit more context switching.

### Be Flexible and Adaptable

- know how to deliver what the company needs
- Product vs Platform teams
- Peacetime vs Wartime at companies

### Leverage Through Writing

- System documentation
- Roadmap planning, north star vision docs
- Good idea - read through past postmortems to get a feel for the type of things you should be watching out for
- make sure you are putting in appropriate effort - the more people that will read your doc over time, the more polished it should be
- team structure, dynamics, and collaboration

### Project management

- Build the right things. Stakeholder management/communication, understanding the business. These two go hand-in-hand
- estimating section made me think of [Stepping Stones, not Milestones.](https://medium.com/@jamesacowling/stepping-stones-not-milestones-e6be0073563f)
- "software physics" - tradeoff between timeline, people, and scope. When one goes down, at least one of the other two must go up. Fact of life, no getting around it. Working more hours is included as an option for people going up.

### Building Reliable Software

- Strategies for shipping to production. This is mainly around test strategies and rollout tooling stratified by different types of companies.
- Monitoring/alerting

### Architect Traits

Gergely's taxonomy of software architect traits helped me introspect and see where I fall among these characteristics. This list still requires business need awareness to pick which angle to adopt. While most people will have a personality tendency towards a subset of these traits, we need to honestly evaluate the business needs and be willing to adjust from our position of comfort to better serve the business. The new-shiny chaser and the old-schooler are the obvious dichotomy. But it is potentially hard to be both a coding machine and leave enough time for being the approachable one. Those are two I try to balance.

- More Theoretical
  - The ivory tower architect
  - Painfully precise
  - The theory addict
  - The philosopher
  - The superior linguist
  - The walk-away advisor
- More Practical
  - The coding machine
  - The integrator
  - The approachable one
  - The detailed documenter
  - The new, shiny chaser
  - The old-schooler

### Wrap Up

I would recommend this book for anyone in the first ten years of their software engineering career or for those wanting insight into what it means to be a "good developer" in big tech. It covers all the "need to knows," allowing you to feel comfortable you're not missing anything important in your mental model of how high quality software engineers should function. If you know me IRL, I would be happy to loan out this book. I currently have [Team Topologies](https://blog.danieladamstech.com/2023/team-topologies/) loaned out to business-side counterpart I used to work with when I was on the cloud data engineering team.

I am about sliding off my fence-straddling position into a paid subscription to Gergely's [The Pragmatic Engineer](https://newsletter.pragmaticengineer.com/) newsletter.`:)`The problem is a couple months ago I went on a Substack free subscription spree and now need to figure which others I need to cut to make time!
