---
title: "Multiple Successful Paths"
date: 2023-10-20T21:00:00-04:00
linkedin: "Seemingly opposite approaches can both be successful.  Here is a story from Josh Wills at Slack regarding the meeting of contrary ideas."
---

I listened to an older [Software Engineering Podcast episode with Josh Wills](https://softwareengineeringdaily.com/2020/01/10/slack-data-platform-with-josh-wills/) this morning while running. Hearing from the first director of data engineering at Slack was insightful and engaging with some of his spicy takes! A big idea is that approaches that look opposite on the surface can both work out if executed well. We should learn from others' experiences and not disregard them since they don't line up with ones that have brought us success personally.

One topic was the path of decisions built on foundational mental models and paradigms. Google and Facebook are both very smart and successful companies that approached the issue of logging from completely different angles. When engineers were within their respective companies, the approach was standard and almost taken as a priori due to the consistency behind it. But then when both groups converged at Slack, the mostly-Google approach won. It won not because it was better, but because the first hires came from that approach and had first-mover status. Nothing would have been gained by refactoring between two "equally good" but very different approaches.

In the "choose your own adventure" game of the next 10 years of use within Google and Facebook, the two different approaches would run into different issues. However, both sets of issues could be overcome by good engineering and addressing pain points as they came up. Two sides of the coin are that the decision had a huge impact on the day-to-day lives of engineers for years to come (in different ways), but either decision would be overcome-able even if it wasn't 100% optimal. A point brought up along those lines is for CTOs at early-stage companies laying the groundwork, the 95% of decisions they got right (enabling the company to still be a company) aren't felt as much as the small sliver that causes pain. Analogy: no one was thinking about airplane cockpit door locks on 9/10.

**Google Logging**

- Single Protobuf schema for all logs across all services (huge!)
- One log at the end of a transaction
- Highly denormalized data, processed with MapReduce
- Aligned to the business of search (not really transactional, more about data aggregation)

**Facebook Logging**

- No single massive schema, multiple smaller Thrift schemas
- Multiple logs per transaction along the way
- Smaller logs joined by relational query engines - Hive came from Facebook
- Aligned to stack (PHP/MySQL) and business (more of transactional with posts)
