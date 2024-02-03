---
title: "The Software Engineers Guidebook"
date: 2024-01-10T21:06:58-05:00
draft: true
---

In my time off between Christmas and New Year, I generally read a book. Two great non-tech books I've read in past years are [Range: Why Generalists Triumph in a Specialized World](https://davidepstein.com/the-range/) and [The Spy and the Traitor: The Greatest Espionage Story of the Cold War](https://www.penguinrandomhouse.com/books/253399/the-spy-and-the-traitor-by-ben-macintyre/) on [Oleg Gordievsky.](https://en.wikipedia.org/wiki/Oleg_Gordievsky) Both of those were gifts from my brother.

This year's book was [The Software Engineer's Guidebook](https://www.engguidebook.com/) by Gergely Orosz. I am a reader of his newsletter, [The Pragmatic Engineer.](https://newsletter.pragmaticengineer.com/) The book traces through all software engineering career levels and highlights important practices to be following at each. I wanted to read through all of them and catch up on any tips or behaviors I had missed along the way. Below are groupings of advice I found helpful. The

### Own Your Own Career

YOU are the one responsible for your own continued learning and growth in your career! Reflecting on my career growth, I have gone hard in most areas. These include broad and deep skill building as well as certifications. One activity I regret not starting sooner was signing up as an official mentee in the mentor program. I had worked on the team with our two Enterprise Architects for 3 years and learned a ton from them in an informal mentee relationship. I had some impostor syndrome if I was truly ready for a mentor from the business or would run out of things to ask them halfway through the year and look dumb. I'm so glad I took the plunge! Both of my mentors have been very friendly and gracious. I switched partway through last year since my first mentor took a position as VP of Sales with around 140 reports at another company. Another career development move I know I need to make at some point is working for another company to get experience in scale. That one I'm going to need to time what works for my family, potentially the economic cycle/[ZIRP,](https://newsletter.pragmaticengineer.com/p/zirp) and navigate some more impostor syndrome.

In the eight years since college, [I have been on six teams.](https://blog.danieladamstech.com/2023/domain-allocation-trends/) Two of those I started from scratch (Cloud Engineering and Cloud Data Engineering.) I expanded my current Integrations team from being a business analyst group that borrowed developers from the general Services team to being a self-contained product team with a software engineering arm. I feel like I've stayed a good balance of time in each domain to grow deeper without the learning rate petering off. I currently hold [six AWS Certifications:](https://www.credly.com/users/daniel-adams.44f95131/badges) Architect and DevOps Pro, Data and Security Specialties, and the associate certs. My lapsed certs include CompTIA A+ (high school), Security+ (college), and Red Hat Certified Systems Administrator and Engineer on RHEL 7 (after college.)

The current balance I am trying to strike is how to best spend my time between coding and non-coding activities. I probably code between 30 and 40% of my time. I want to spend the remainder in high-leverage direction-setting, doc writing, and mentoring tasks. In the project management realm, I am trying to reflect on what useful ways I can contribute to coordinating smooth delivery while at the same time reserving time to personally help with some of the more critical migrations and implementations.

### Be Known as Someone Who Delivers

A prerequisite for being known as someone who delivers is to **actually** deliver. You should first be consistent, dependable, and meet or exceed the quality bar (see later about quality not being the end-all-be-all in some situations.) Then you can worry about whether others are recognizing your results. It is important to not put the cart before the horse and try to sell something that's not there. Even when you are solid on the behavior, selling it can require walking a tightrope. You need to get a feel for what is acceptable in the engineering culture and not deviate too far from the norm. You don't want to come off as someone who just cares about their image more than the actual business outcomes. On the flip side, you don't want to sit on the sidelines assuming your work will speak for yourself in a company where there is an expectation to self-promote.

Avoid spreading yourself too thin to deliver meaningful work. My biggest takeaway from the book was "**know your #1 priority and always deliver that on time**." This priority should be stable for at least a week. Within the week, switching to a new #1 priority should require managerial escalation and approval. I thought I was going to adopt this and revolutionize my focus... Turns out, it still doesn't mean you can just work on one or two things at a time. We are currently working on a major upgrade and cloud migration for one of our core business systems. There were three things we identified the Integrations team needed to contribute for customer rollout over six weeks. Those were data synchronization from an on-prem system of record to DynamoDB, orchestration router service updates, and unifying our customer support tooling. The first two items were in the request path and had a dependency, so I took them. The third was independent, so I was hoping to get the request-path items done first and then start guiding someone on the support tooling. The good news was an offshore contractor had availability sooner than expected, so I started breaking down the work for him right away. At the end of the day, the timeline is still on track working on all three in parallel, just with a bit more context switching.

### Be Flexible and Adaptable

Flexibility and Adaptability are critical skills for delivering what is needed in the way it is needed. A company might be in a phase where speed is valued over quality - finding product market fit or launching a feature to catch up with a competitor that is taking your business. Or the company might have reached a point where stability and earning customers' trust is paramount. The interesting thing is that the progression between those extremes is not a monotonically increasing function. Some forces can cause oscillation between the two. Gergely cites the example of a startup going into a funding round vs one that just completed a funding round. The book includes an insightful comparison table between peacetime and wartime behaviors and leadership styles along a dozen different dimensions. For example, conflict is acceptable in a wartime company as long as it gets things done. Not so much in a peacetime company - relationships are the higher priority.

As I will mention later in the Architect Archetypes section, sometimes the company's needs don't exactly align with our default personality or behavior. That's ok. As software engineers, we should be comfortable in a relatively wide range of modes. [Impedance matching power transfer](https://en.wikipedia.org/wiki/Impedance_matching#Power_transfer) is an interesting parallel to an engineer's fit with company needs. In ham radio, we use radios and coax cable with 50 ohm impedances. The goal is to get the antenna's impedance as close to 50 ohms as possible to maximize power transfer. Power that is not transferred from the cable into the antenna is reflected back towards the radio and raises the [standing wave ratio or SWR.](https://en.wikipedia.org/wiki/Standing_wave_ratio) We use antennas designed to match 50 ohms as closely as possible or transformers to lower the impedance to the target. A software engineer will be able to do their best work when companies needs align within the range of what they are most comfortable producing. The broader the acceptable range, the more options you have.

Another type of flexibility engineers can develop the ability to thrive in either a product or platform team. Both teams build for their customers, but the types of inputs they get vary widely. Product teams have metrics that are easy to align with the business (new users, churn, revenue) while platform teams have an additional layer of indirection (engineering time saved, cost savings against a moving target.) At large companies, platform teams have the highest leverage since they can improve cross-cutting concerns for the whole organization. The best thing you can do as an engineer is to contribute in both team types. I spent more time on the platform side, so I wanted to switch over to a product team. Changing it up gave me a new energy for building a different type of deliverable.

### Leverage Through Writing

Informative, succinct, and persuasive writing is key to scaling your influence. You can reach more people by writing than in 1:1 conversations. Writing also memorializes the information for others a year down the road when you have moved on to the next project. We all think of system documentation as the main required form of writing for engineers. But other critical documents exist like RFCs/change proposals, roadmap planning, and "north star" team vision documents. Contributing to documents influencing **what** will be done is a high-leverage activity.

The quality of the writing you create is more critical in some cases than others. You should be aware of the intended but also potential audience and put in the commensurate level of tweaking. Ryan Peterman, staff engineer at Instagram, says [he spends 80% of his writing time polishing the final draft.](https://www.developing.dev/p/how-to-write) A cool story on Lenny's Podcast with Ethan Evans was [how he wrote the tagline for Ownership](https://youtu.be/GB0P0_nFPTA?t=3635) when it was on the chopping block. "An Owner never says that's not my job." Ownership is currently listed as [#2 out of Amazon's 16 Leadership Principles.](https://www.amazon.jobs/content/en/our-workplace/leadership-principles)

On the flip side, take time to digest what has been written previously. A great internal starting place the book calls out is the corpus of past postmortem reviews. They can give you a sense of what challenges the company has faced in the past and what improvements or mitigations should be implemented going forward. A good external source of knowledge is [The Amazon Builders' Library.](https://aws.amazon.com/builders-library/) One of my favorites is [Reliability, constant work, and a good cup of coffee](https://aws.amazon.com/builders-library/reliability-and-constant-work) about how control planes and other critical systems should do the same amount of work each time and sometimes avoid optimizations. Taking a shortcut in a NOOP condition that occurs when everything is normal and then doing work in edge cases or failure scenarios can overwhelm the system and lead to worse cascading failures.

### Project management

One of the ground rules in project management is to build the right thing. Engineers should work closely enough with the business that they can be a trusted extension of the business's decision-making. Alignment and knowing how your business counterpart would respond in various situations allows you to inform and move ahead rather than having to ask and wait for feedback. Stakeholder management is an important skill to be successful as a tech lead. You must ensure all stakeholders feel their input was taken seriously and all parties can arrive at a shared consensus on the project's goals and requirements. During execution, you need to keep them updated on progress, decision points, and risks. I generally provide a stakeholder update at the end of the week of what progress we have made and what is the direction for the upcoming week.

Estimations are always a challenge, but the vast majority of businesses need them. Sometimes multiple engineering teams need to roll out a joint effort around the same date. Other times Marketing will need to coordinate publicity around a product launch. The estimate always will factor into the decision of whether something is worth doing now, later, or never. The book coins the term "Triangle of Software Physics" consisting of the variables People, Scope, and Timeline. Just like the [ideal gas law,](https://en.wikipedia.org/wiki/Ideal_gas_law) when one variable changes, one or more others must counter to maintain equilibrium. The most common change of which everyone is familiar is increasing Scope! The only solution to that is to increase the People or extend the Timeline. [The Mythical Man-Month](https://en.wikipedia.org/wiki/The_Mythical_Man-Month) states that simply adding new people to a project that is behind is unlikely to speed it up. Thus many times people end up working overtime or pushing out other tasks to focus more on the project at hand.

The strategy around how a project is broken down and estimated reminds me of the blog post [Stepping Stones, not Milestones.](https://medium.com/@jamesacowling/stepping-stones-not-milestones-e6be0073563f) Creating waypoints along the path achieves the tandem goals of incrementally delivering value and gaining a clearer picture over time of the end goal. Incremental value still gives you something to show for your efforts if the business priority changes halfway through and the project gets dropped. Also, in large-scale projects, it is hard to pinpoint exactly how things should look at the very end. Starting with a broad end goal and continually narrowing the design over time will help you converge on a good solution.

### Building Reliable Software

Software reliability is a passion of mine. I don't know that my interest is full-bore SRE, but it skews towards that side. The book covers both the traditional monitoring and alerting topics as well as how companies safely ship to production. These practices on shipping to production are broken down between startups, traditional companies, larger tech companies, and Facebook. It was insightful to compare the various patterns along the dimensions of speed (latency and time spent) and safety. Facebook and Amazon have two different release strategies despite being at the same maturity due to the differing product risk tolerance. A bad update to Amazon RDS databases is a completely different thing than a bad update to Facebook's trending algorithm. After CI checks and code review, Facebook launches an [automated canary rollout](https://engineering.fb.com/2017/08/31/web/rapid-release-at-massive-scale/) across 4 successive environments (automated test, employees, small market, all users.)

This week I gave a lunch-and-learn on Monitoring and Observability. I highlighted some of the improvements I had worked on for our team over the past quarter. They included starting a NewRelic Terraform project for our team that managed alert conditions, alert routing, dashboards, and synthetics. I'm a big fan of infrastructure as code, and this was a step to get consistency across our environments. I also gathered feedback on an RFC I led regarding enterprise-wide baseline monitoring expectations for our services.

### Architect Archetypes

Gergely's taxonomy of software architect traits helped me introspect and see where I fall among these characteristics. Picking which angle to adopt still requires business need awareness. While most people will have a personality tendency towards a subset of these traits, we need to honestly evaluate the business needs and be willing to adjust from our position of comfort to better serve the business. The new-shiny chaser and the old-schooler are the obvious dichotomy. But it is potentially hard to be both a coding machine and leave enough time for being the approachable one. Those are two I try to balance.

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

I would recommend this book for anyone in the first ten years of their software engineering career or for those wanting insight into what it means to be a "good developer" in big tech. It covers all the "need to knows," allowing you to feel comfortable that you're not missing anything important in your mental model of how high-maturity software engineers should function. If you know me IRL, I would be happy to loan out this book. I currently have [Team Topologies](https://blog.danieladamstech.com/2023/team-topologies/) loaned out to a business-side counterpart I worked with when I was on the cloud data engineering team.

I am about to slide off my fence-straddling position into a paid subscription to Gergely's [The Pragmatic Engineer](https://newsletter.pragmaticengineer.com/) newsletter.`:)`The problem is a couple of months ago I went on a Substack free subscription spree and now need to figure which others to cut to make time!