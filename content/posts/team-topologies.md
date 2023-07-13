---
title: "Team Topologies"
date: 2023-07-06T22:00:00-04:00
tags: ["books"]
---

I went out on a limb and signed up for a [book club](https://brianchambers.substack.com/p/chamber-of-tech-secrets-757), hoping to glean some useful concepts and see what interesting people I might meet at discussion time. As a side note, this was the first time I had heard about [Chatham House Rule](https://en.wikipedia.org/wiki/Chatham_House_Rule). It lays a groundwork for an open discussion of ideas and kind of reminds me of open-source software licenses. 😃

> When a meeting, or part thereof, is held under the Chatham House Rule, participants are free to use the information received, but neither the identity nor the affiliation of the speaker(s), nor that of any other participant, may be revealed.

The committed participants voted on the book, and [Team Topologies](https://teamtopologies.com/) was selected. If I had to pick three main takeaways from the book, they would be the following:

- The far-reaching implications of Conway's law
- A focus on balancing team cognitive load when working through team responsibility boundaries
- The realization that a high levels of collaboration is not always a good thing

Below I go deeper into these ideas and share some concepts that were insightful and helpful to me.

### Chapter 1

There are other structures besides the org chart that influence how work gets accomplished day-to-day. Influence, trust, and friendships drive communication patterns, and communication patterns drive software architecture. Conway's law is a core idea in this book. It states that an organization's software will look like the communication structures of the organization. This takes into account both the formal (and sometimes to a greater degree) informal communication structures.

We'll circle back on cognitive load in later chapters, but there is a warning in this one to be careful and explicit about planning for it. Some teams are victims of their own success. They deliver high-quality work and keep operational [toil](https://sre.google/sre-book/eliminating-toil/) (from the Google SRE book) low. Because of their proven track record and ability to take on more work, their scope starts to increase. If that continues and the cognitive load of everything under the team's responsibility gets too broad, they will start to have specialists on the team. This can lead to bottlenecks and an overall reduction in throughput. Chapter 8 talks about the feedback cycle organizations need and when it makes sense to split a team to maintain the desired scope of responsibility.

### Chapter 2

Conway's law is important enough and fundamental enough to effective software design that there have been extensions and corollaries examining various of its implications. One quote by [Ruth Malan](https://ruthmalan.com/Journal/JournalCurrent.htm) says:

> If the architecture of the system and the architecture of the organization are at odds, the architecture of the organization wins.

This implies that, to begin with the end in mind, software architects should be the influencing team organization as it is fundamentally an architecture question. Chapter 6 lists several common "fracture planes" where organizations could choose to place their software and team boundaries. Consciously aligning communication patterns at the start of a large initiative is referred to as a reverse Conway maneuver. It attempts to get out ahead of the software being written and shape the interfaces by team organization. This can be easier than trying to fight the natural tendencies later. Low or no communication between certain teams can be a sign that the architecture is working well. If two teams that shouldn't need to coordinate are communicating, that can be a sign that an interface is not quite right.

### Chapter 3

This chapter started out with a quick section on [Dunbar's number](https://en.wikipedia.org/wiki/Dunbar%27s_number) and some generic benchmarks:

- 5 people: close personal relationships
- 15 people: deep trust
- 50 people: mutual trust
- 150 people: remember their capabilities

On the low end, these relate to Amazon's popularized "two-pizza teams." As the numbers increase, the concept moves to how teams can interact and share information together. A high scale example is Amazon's [principal engineering community](https://medium.com/geekculture/belonging-to-amazons-principal-engineering-community-aa8059152fbf). In 2014, they were at 10k engineers and 300 principal engineers. This let the group still all get together for off-sites and somewhat know other people. The post author estimates in 2021 that has grown to 70k engineers and 2-2.5k principals. That requires a different sub-grouping strategy to have any type of relationship.

Keeping Dunbar's number and human relationships in mind, that trust should lead to a team-first mindset. It is the _team_ that owns the software and the outcomes. Putting the team first (and not competing within the team) will result in the best long-term outcomes. The team should rise and fall together. Figuring a way to reward at the team level encourages team accomplishments and not people trying to be heroes.

There are several types of cognitive load, and some are healthier than others. Kind of like trans fat is worse than saturated fat, which is worse than some types of unsaturated fat.

- **Extraneous** cognitive load (useless peculiarities) has no value and should be eliminated as much as possible
- Some level of **Intrinsic** cognitive load is necessary like knowing your programming language. Minimize when possible through tech stack consistency, pairing, etc.
- Leave as much budget as possible for **Germane** cognitive load. This is the domain-specific business problem and is where the most business value is gained.

### Chapter 4

Try to make teams as static as possible. Shifting people around for initial implementation and leaving others behind for support might not provide an adequate level of ongoing work on that system. Optimize team structure for long-term evolution, not short-term "special" projects.

"Flow of change" optimized, low friction organizations are inversely related to the number of handoffs.

- Corollary: Any governance and security should happen as part of the flow (ideally automated async) and not require a handoff to a person.
- Platform teams should interact via code interfaces and not through manually filled tickets. Allow devs to create pipelines from a catalog. Permission requests for those apps are service requests (ideally PRs linked to SNOW for auditing).
  - Product teams need support via simplification of other concerns through interfaces (maintained by platform teams) to keep the cognitive load where it should be and focus on domain concerns.
- Review team dependencies and explicitly accept them or change processes to remove them.

DevOps is an organizational mindset and communication pattern more than it is tooling. Have to get the feedback of running system performance back to devs as directly as possible. "DevOps teams" should be only an enabling (educating) team for a transition period and have an end date. SRE teams are sometimes needed, but only for large scale. Stream-aligned teams can own those responsibilities on a small scale. SRE teams are paired with one or a couple of specific steam-aligned teams. This pairing requires a high level of engineering discipline on everyone's part to not devolve into "us vs them."

**Question**: Just say you're coming from a Dev team plus Ops team. You align the same headcount into two stream-aligned teams. How do you train everyone up to not just have two functions split within the same team?

### Chapter 5

The book now gets into the four fundamental team topologies, hence the title.

1. **Stream-aligned** teams serve a specific product or customer persona. They are multi-disciplinary for end-to-end software requirements, design, delivery, operation, and security. These have commonly been referred to as platform teams, but the book prefers the term stream-aligned team since it is more broadly applicable. This is because the customer value stream might flow through multiple products, or one product could be broken up into multiple independent work streams.
2. **Platform** teams abstract things to reduce cognitive load. They should measure themselves on ease of use and value derived from their services. "Thinnest viable platform" is a mantra these teams should strive for.
3. **Enabling** teams allow stream-aligned teams to acquire missing capabilities or figure out problems that take more research or trials. They act as educators with the goal of making the stream-aligned teams more self-sufficient. These teams are generally time-bound, at least with respect to each specific team they are serving. They don't do the work, but point out strategies that can be applied. This makes me think of hearing about the [AWS Cryptography Bar Raiser](https://aws.amazon.com/blogs/security/aws-security-profiles-matthew-campagna-sr-principal-security-engineer-cryptography/) program in a Re:Invent talk (not to be confused with an [Interview Bar Raiser](https://medium.com/geekculture/memoirs-of-an-amazon-bar-raiser-718e36241310)).
4. **Complicated subsystem** teams are formed due to the complexity of algorithms involved in their software, like video codecs. The decision to create this type of team is driven by cognitive load, not the desire to create an interface to share software with multiple consumers. Many companies won't need these teams unless they are doing something very specialized.

If platforms are large enough, they might have their own stream-aligned, complicated subsystem, and platform teams within. The platform still appears as a single entity and is consumed via a single API by the top-level stream-aligned teams.

### Chapter 6

Speed of delivery necessitates correct team boundaries to enable autonomy. The first half of the chapter covers types of hidden monoliths. Most people are familiar with these. One of the common ones I've seen a good bit of is the joined-at-the-database monolith. Data dependencies between apps sharing a database make it hard to break apps off and move the system of record elsewhere. Ongoing backfilling of the original database from the new system is necessary to keep the other apps working. That is just for a one-way dependency; it gets almost impossibly complex with multi-master datasets where more than one application modifies shared data.

Fracture planes are lines where you can cleanly split software when dividing responsibilities between stream-aligned teams.

- Business domain: As popularized by the book [Domain-Driven Design](https://www.domainlanguage.com/ddd/), this approach attempts to put different areas of the business into bounded contexts. Examples could include billing, sales, underwriting, etc. This is one that is unlikely to be done exactly right on the first shot, so it will need to morph over time as better boundaries are found.
- Regulatory or risk level: An example of this would be [PCI-DSS](https://listings.pcisecuritystandards.org/documents/PCI_DSS-QRG-v3_2_1.pdf) systems in a retailer.
- Performance isolation: At work, we keep performance-sensitive things separated from other processes that have much lower SLAs. We don't want a process that needs to run within two days to impact a process that needs sub-second response times.
- Time zones for geographically split teams: This fracture plane harkens back to Conway's law and the desire to maintain efficient communication within a team. I remember the AWS [Firecracker microVM](https://firecracker-microvm.github.io/) team being all located somewhere in Europe. I think it was this office in [Romania](https://www.amazon.jobs/en/locations/bucharest-romania).
- Others: change cadence, technology, user personas, etc.

### Chapter 7

Semi-orthogonal to the four team topologies, there are three interaction modes for teams: **Facilitating**, **Collaborating**, and **X-as-a-service**. We'll get facilitating out of the way first. This is most often correlated with Enabling teams helping educate other teams.

The other two are a spectrum of how much "entanglement" teams have with each other. For high flow, X-as-a-service should be the primary interaction mode. It is defined by good APIs between teams where one team can use another's product without human coordination between the teams. Services flow "up" the abstraction stack. Platform teams provide services to complicated subsystem and stream-aligned teams, and complicated subsystem teams provide software components to stream-aligned teams. X-as-a-service interaction patterns scale well across multiple consumers, which is great for platform teams at large companies. They could have tens or hundreds of stream-aligned teams using their platform.

For times when good APIs don't exist between teams, Collaboration mode is needed. This allows for rapid exploring of the problem space, building structures and abstractions, and then assigning ownership of the gray area to one team or the other. Much progress can be made during this time when teams are "pairing" with each other, but it comes at the cost of a higher cognitive load on both teams. Each team needs to partially learn the space of the other. One requirement of success is both teams need joint responsibility for the result, which leads to everyone pulling in the same direction and higher trust. Unlike X-as-a-service, a team should not be in collaboration mode with more than one team at a time. This would spread them too thin and force them to take on more cognitive load than is manageable.

One fascinating bit of research was from the referenced paper [How Intermittent Breaks in Interaction Improve Collective Intelligence](https://www.pnas.org/doi/10.1073/pnas.1802407115) (Bernstein et al.) It finds that while collaboration increases the average solution quality, the maximum quality is only reached with intermittent collaboration. Those involved can benefit from the group's shared understanding but still have the freedom and be forced to think on their own. This leads to less groupthink, more divergent exploration, and a larger possible solution space covered. The concept reminds me of an experimental design class in college taught by [Professor Long](https://www.linkedin.com/in/scott-long-a69bba12/) and hyperparameter tuning in ML models. The right level of randomness and exploration of the solution space will lead to an overall better result than getting stuck on a local maximum.

### Chapter 8

Sensing is critical for adjustments as needs change. Teams should be frequently analyzing their dependencies on other teams and explicitly decide if that is what makes sense for their goals or if change is needed. A boundary with one specific other team might be getting more well-defined as a result of collaboration. It could be time to pull back from that collaboration relationship and use that single collaboration quota in another area. Company and software footprint growth is a common driver of team splits to maintain the right level of cognitive load.

Another critical aspect of sensing is ensuring that operational insights and pain points inform development cycles. Not having that feedback cycle hurts productivity in the long run due to maintenance overload. A mechanism for adequately sensing in this area is [error budgets](https://sre.google/sre-book/embracing-risk/) as covered in the Google SRE book. Similarly, keeping new development separate from legacy system teams reduces the ability of the legacy systems to adopt newer telemetry and other techniques.

## Application

The concepts in this book closely aligned with some situations I have experienced in the last couple of years. As our cloud environment grew, in 2020 I moved off the Architecture team to start a new Cloud Engineering team. Then about a year later we started a Data Modernization program with a big focus on moving our data into Snowflake with modern data pipelines and analytics tooling. A high level of collaboration was needed between Cloud Engineering and the newly formed Data Engineering team as we built out that environment from the ground up. We utilized that collaboration to accomplish a lot. I used my existing relationship with the Security team to be the project liaison for security design reviews. We built out Snowflake and Talend infrastructure platform, data lake zone definitions, an ELT framework with CI/CD, serverless [ML Pipelines](/2023/platforms-not-products/), Eventbridge custom event integrations, to name a few.

After working closely with that project for almost two years, an opportunity came up to move back closer to software development on the Integrations team. After discussing with my manager, I applied for and accepted that position with the plan of staying for another three months while we hired some more Cloud Engineers. During the knowledge transfer process, I could see that we had probably gotten a bit farther than ideal into process entanglement between Cloud and Data Engineering teams. I had effectively become a Data Engineering team member with Cloud Engineering background and permissions. There was some decoupling we had to do over those months like me being less involved in design sessions, stopping going to Data standups, etc. In the end, we had a relatively smooth transition. There is still some more work to be done balancing separation of duties with not overloading the Cloud team with injects, but we are making process progress.

This process and reading the Team Topologies book did lead me to realize the care that needs to be taken when skirting not "staying in your lane." The three-month transition worked well, but it would have been rockier on a short transition. You don't want to leave a "you-sized hole" that makes it hard for you to move on to another opportunity or leave your team in the lurch since it is hard for them to replace your specific shape of responsibilities.
