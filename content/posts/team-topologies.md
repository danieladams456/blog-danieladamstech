---
title: "Team Topologies"
date: 2023-07-03T12:00:00-04:00
draft: true
---

I decided to go a bit out on a limb and sign up for a [book club](https://brianchambers.substack.com/p/chamber-of-tech-secrets-757). I hoped to glean some useful concepts from the book as well as see what interesting people I might meet at discussion time. As a side note, this was the first time I had heard about [Chatham House Rule](https://en.wikipedia.org/wiki/Chatham_House_Rule). It lays a groundwork for an open discussion of ideas and kind of reminds me of open source software licenses. 😃

> When a meeting, or part thereof, is held under the Chatham House Rule, participants are free to use the information received, but neither the identity nor the affiliation of the speaker(s), nor that of any other participant, may be revealed.

The committed participants voted on the book, and [Team Topologies](https://teamtopologies.com/) was selected. If I had to pick three main takeaways from the book, they would be the following:

- The far-reaching implications of Conway's law
- A focus on balancing team cognitive load when working through team responsibility boundaries
- The realization that high levels of collaboration is not necessarily a good thing

Below I go deeper into these ideas and share some concepts that were insightful and helpful to me.

### Chapter 1

There are other structures besides the org chart that influence how work gets accomplished day-to-day. Influence, trust, and friendships drive communication patterns, and communication patterns drive software architecture. Conway's law is a core idea in this book. It states that an organization's software will look like the communication structures of the organization. This takes into account both the formal (and sometimes to a greater degree) informal communication structures.

We'll circle back on cognitive load in later chapters, but there is a warning in this one to be careful and explicit about planning for it. Some teams are victims of their own success. They deliver high quality work and keep operational [toil](https://sre.google/sre-book/eliminating-toil/) (from the Google SRE book) low. Because of their proven track record and ability to take on more work, their scope starts to increase. If that continues and the cognitive load of everything under the team's responsibility gets too broad, they will start to have specialists on the team. This can lead to bottlenecks and overall reduction in throughput. Chapter 8 talks about the feedback cycle organizations need and when it makes sense to split a team to maintain the desired scope of responsibility.

### Chapter 2

Conway's law is important enough and fundamental enough to effective software design that there have been extensions and corollaries examining various of its implications. One quote by [Ruth Malan](https://ruthmalan.com/Journal/JournalCurrent.htm) says:

> If the architecture of the system and the architecture of the organization are at odds, the architecture of the organization wins.

This implies that to begin with the end in mind, software architects should be the influencing team organization as it is fundamentally an architecture question. Chapter 6 lists several common "fracture planes" where organizations could choose to place their software and team boundaries. Consciously aligning communication patters at the start of a large initiative is referred to as a reverse Conway maneuver. It attempts to get out ahead of the software being written and shape the interfaces by team organization. This can be easier than trying to fight the natural tendencies later. Low or no communication between certain teams can be a sign that the architecture is working well. If two teams that shouldn't need to coordinate are communicating, that can be a sign that an interface is not quite right.

### Chapter 3

This chapter started out with a quick section on [Dunbar's number](https://en.wikipedia.org/wiki/Dunbar%27s_number) and some generic benchmarks:

- 5 people: close personal relationship
- 15 people: deep trust
- 50 people: mutual trust
- 150 people: remember their capabilities

On the low end, these relate to Amazon's popularized "two-pizza teams." As the numbers increase, the concept moves to how teams can interact and share information together. A high scale example is Amazon's [principal engineering community](https://medium.com/geekculture/belonging-to-amazons-principal-engineering-community-aa8059152fbf). In 2014, they were at 10k engineers and 300 principal engineers. This let them still all get together for off-sites and somewhat know other people. The post author estimates in 2021 that has grown to 70k engineers and 2-2.5k principals. That requires a different sub-grouping strategy to have any type of relationships.

Keeping Dunbar's number and human relationships in mind, that trust should lead to a team-first mindset. It is the _team_ that owns the software and the outcomes. Putting the team first (and not competing within the team) will result in the best long-term outcomes. The team should rise and fall together. Figuring a way to reward at the team level encourages team accomplishments and not people trying to be heros.

There are several types of cognitive load, and some are healthier than others. Kind of like trans fat is worse than saturated fat, which is worse some types of unsaturated fat.

- **Extraneous** cognitive load (useless peculiarities) has no value and should be eliminated as much as possible
- Some level of **Intrinsic** cognitive load is necessary like knowing your programming language. Minimize when possible through tech stack consistency, pairing, etc.
- Leave as much budget as possible for **Germane** cognitive load. This is the domain specific business problem and is where the most business value is gained.

### Chapter 4

Try to make teams as static as possible. Shifting people around for initial implementation and leaving others behind for support might not provide adequate level of ongoing work on that system. Optimize team structure for long term evolution, not short term "special" projects.

"Flow of change" optimized, low friction organizations and environments are inversely related to handoffs.
⁃ Corollary: any governance and security should happen as part of the flow (ideally automated async) and ideally not require a handoff to a person.

DevOps is an organizational pattern more than it is tooling. Have to get the feedback of running system performance back to devs as directly as possible.
⁃ question: just say you're coming from an Dev team plus Ops team. You align the same headcount into two stream aligned teams. How do you train everyone up to not just have two functions split in the same team?

Product teams need support via simplification of other concerns through interfaces (maintained by platform teams) to keep the cognitive load where it should be and focus on domain concerns.

Cloud team should make things self service and not be in the loop.
⁃ allow devs to create pipelines from catalog. Permissions requests for those apps are service requests (ideally PRs linked to SNOW for auditing).

SRE teams are just for large scale. Small scale, devs can own that. SRE teams are paired with one or couple specific steam aligned teams. Requires a high level of engineering discipline on everyone's part to not devolve into "us vs them."

"DevOps teams" should be only for transition and have an end date.

Review team dependencies and explicitly accept them or change process to remove them.

### Chapter 5

Stream aligned teams a specific product or customer persona. They are mixed discipline.
Enabling teams allow stream aligned teams to acquire missing capabilities or figure thinks that take more research/trials. They act as educators with the goal of making the stream aligned teams more self sufficient.
Platform teams abstract things to reduce cognitive load. They should measure themselves on ease of use and value derived from their services. "Thinnest viable platform."
Complicated subsystems teams are generally due to complexity of algorithms involved in their software, like video codecs. Decision is driven by cognitive load, not desire to create an interface to share software to multiple consumers.

If platforms are large enough (), they might have their own stream-aligned, complicated subsystem, and platform teams within. The platform still appears as a single entity and consumed via a single API by the line of business teams.

### Chapter 6

Speed of delivery necessitates correct team boundaries to enable autonomy.

Types of hidden monoliths

Fracture planes: where you can cleanly split software
⁃ business domain
⁃ Regulatory or risk level
⁃ Time zones for geographically split teams (Conway's law)

### Chapter 7

Interaction patterns
Sometimes intermittent interaction is better - note on 133

A team should not be in collaboration mode with more than one team at a time (spreading too thin)

### Chapter 8

Sensing is critical for adjustments (team structure changes, operational insights feeding back into development)

Separate Dev and ops teams limits the signal back into software design. Similarly, keeping new development separate from legacy system teams reduces the ability for the legacy systems to adopt newer telemetry and other techniques.

## Application

The concepts in this book closely aligned with some situations I have experienced in the last couple years. Data/Cloud eng overlap.
