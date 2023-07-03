---
title: "Team Topologies"
date: 2023-07-01T19:11:21-04:00
draft: true
---

I decided to go a bit out on a limb and sign up for a [book club](https://brianchambers.substack.com/p/chamber-of-tech-secrets-757). We voted on the book, and [Team Topologies](https://teamtopologies.com/) (my preferred pick) was selected. If I had to pick three main takwaways from the book, I think they would be the following:

- the far-reaching implications of Conway's law
- a focus on the correct amount of team cognitive load when working through team responsibility boundaries
- the realization that high levels of collaboration is not necessarily a good thing

Below are my notes of what I found most helpful or insightful from each chapter.

### Chapter 1

Be explicit about planning for cognitive load on teams and design team boundaries accordingly.
Conway's law is important

### Chapter 2

The architects should be the ones influencing team organization since it is fundamentally an architecture question (Conway's law.)

Low or no communication between certain teams can be a sign that the architecture is working well. If two teams that shouldn't have to communicate are communicating, that can be a sign that an interface is not quite right.

### Chapter 3

Team sizes and Dunbar's number relate to trust levels.
Figuring a way to reward at the team level encourages team accomplishments and not people trying to be heros.
Minimize intrinsic cognitive load (through tech stack consistency, pairing, etc) and extraneous cognitive load (useless peculiarities) to leave as much budget as possible for germane cognitive load (the domain specific business problem.)

Splitting domains on data eng team:
⁃ Core analytics data lake delivery
⁃ Consumption (interface with external teams)
⁃ Application side data (lender servicing modernization, upcoming projects)

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
