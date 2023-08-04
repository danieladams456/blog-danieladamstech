---
title: "Step Functions Use Cases"
date: 2023-08-03T20:00:00-04:00
draft: true
---

The Prime Video team made some waves back in March when they [wrote about refactoring their distributed microservices application into a monolith](https://www.primevideotech.com/video-streaming/scaling-up-the-prime-video-audio-video-monitoring-service-and-reducing-costs-by-90). It was a topic of various Medium and LinkedIn posts. Then two weeks later Werner Vogels published a follow-up post [Monoliths are not Dinosaurs](https://www.allthingsdistributed.com/2023/05/monoliths-are-not-dinosaurs.html). Generally, Werner is presenting about microservices and distributed event-driven architectures at Re:Invent, but he seemed to step in here to say engineering judgment is important and microservices are not always the right decision. At scale, actually profiling the workload is important. Converting media is a CPU-intensive process, but through empirical testing, the team found it was cheaper to transcode more than once than to pass around the files via S3.

Werner used [another Prime video post about distributed work scheduling and prioritization](https://www.primevideotech.com/cloud-and-scale/shaping-live-sports-publishing-traffic-through-a-distributed-scheduling-system) as a contrast to the monolithic architecture. This one implemented a serverless, event-based architecture in a more economical way. [Big-O notation](https://en.wikipedia.org/wiki/Big_O_notation) doesn't exactly apply here, but it could be slanted to say the video publishing queuing system was **O(1)** since it ran through the Lambda + SQS portion of the system once per job. On the other hand, the video quality analysis system "performed multiple state transitions for every second of the stream" which could be considered **O(n)** as it was constantly spinning throughout the duration of the job. This looping could have been what contributed to the S3 cost as the iteration speed of the Step Function seems to indicate repeatedly passing around chunks of video for real-time monitoring.

### My Analysis

I'll start by saying that I'm a big fan of Step Functions for certain use cases. I recently built two projects in Step Functions for our Data Modernization control plane. One was an [ML Pipeline with user-submitted code hooks to dynamically select phases at runtime](/2023/platforms-not-products/). The other was an event-based ETL run manager. Files would arrive at S3, [Eventbridge Pipes](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html) would route those S3 events to SQS queues, and a StepFunction would run the ETL on queue depth alarm and every ten minutes thereafter until the queue was cleared. These have been low-cost but high-impact processes.

Step Functions is very low maintenance - no language runtime or dependency upgrades. However, it seems like when writing them, I had to plan around limitations of the [intrinsic functions](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-intrinsic-functions.html) and more limited manners that you could merge state. For example, there is no function to test if a value exists in an array.

#### Know your "why"

Step Functions can be used for many purposes. Knowing for what reason you chose the service can help inform how much you are willing to pay.

1. Status tracking and debuggability of important processes
2. "Glue" orchestrating disparate systems
3. Replacing custom orchestration code for reduced maintenance

#### Use for things that "matter"

You have now figured out which benefits you wish to reap from centralized workflow management with Step Functions. The next step is evaluating how much those matter to the use case at hand. The top benefit in many of my scenarios is the innate status tracking for each transaction. The same detail can be gleaned from custom instrumentation or monitoring tools, but Step Functions naturally tracks any process whether sync or async. This enhanced tracking could be useful for things like financial transactions or delivering critical files to business partners. Most people would happily spend a couple more dollars on the AWS bill for peace of mind around a solid workflow engine running those processes.

In the Prime Video use case, tracking and debuggability are not that important for a monitoring tool. The team probably chose the solution for other reasons when it was first implemented. Along this axis, a less-natively-traceable solution like SQS queues would still fit the bill. With decentralized orchestration like SQS, passing things like [OpenTelemetry trace headers](https://opentelemetry.io/docs/concepts/signals/traces/) as [SQS message attributes](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-metadata.html#sqs-message-attributes) becomes more important for operational monitoring.

#### Pay attention to cost per business process execution

Straight-through processes with constant **O(1)** costs are easy to estimate. **O(n)** processes with looping can be estimated in the average case, but the high iteration case needs accounted for as well. Many times these loops are for polling "legacy" processes that are not event-based. Switching to an [Activity](https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-task-state.html#amazon-states-language-task-state-activity) task type can remove iteration from the StepFunction. If that is not possible, using exponential backoff and a timeout exit after a maximum number of polls can make the maximum invocation cost easier to predict.

#### If the cost/benefit is borderline, try to gauge the scaling pattern of the workload over the next couple years

Werner says in his blog post:

> My rule of thumb has been that with every order of magnitude of growth you should revisit your architecture, and determine whether it can still support the next order level of growth.

Premature optimization is never a good thing. However, looking ahead at projected growth can give a sense of the timeline a solution can stay in place. In a high-growth app, you could easily hit an order of magnitude in two years and be forced to iterate to the next design. In my industry of mortgage insurance, our business is tied to the housing market. Some areas of the business like orders are tied to that fixed-size market. Others like data analytics will probably see a 100x growth over the next ten years. For many of our transactional areas, we can design for long-term maintainability and don't need to redesign for scale every two years. If the economics don't look promising in the long term, then it could be good to consider the options that would be less of a drastic change to the system as it evolves over time.
