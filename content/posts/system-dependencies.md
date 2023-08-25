---
title: "System Dependencies"
date: 2023-08-24T20:00:00-04:00
tags: ["architecture"]
linkedin: "This post looks at cloud service, application, and health check dependencies and what to keep in mind when designing and operating systems."
---

### Cloud Service Dependencies

To quote Werner Vogles, ["Everything fails all the time."](https://cacm.acm.org/magazines/2020/2/242334-everything-fails-all-the-time/abstract) When designing an app, we want to carefully evaluate what dependencies it requires. Cloud services are highly available, but the union of many can still lead to a measurable decrease in availability. Dependencies that are not absolutely necessary should fail open to allow the system to continue doing critical work. Below are two examples I have personally run into in the past couple of years.

#### Caching Proxy DynamoDB Write

We had a web app with the UI layer running out in AWS that used an authentication system on-prem. Session validation on every page load and Ajax call was causing performance issues, so I wrote a session caching service out in AWS to decrease the latency for validation. It was a huge success for the user experience, saving over 15 hours of waiting time per day. The service used a two-tier cache system: local cache within the service and DynamoDB within the cluster. Cache misses called the on-prem system.

The [December 7th, 2021 issue](https://aws.amazon.com/message/12721/) caused a DynamoDB outage for us. According to the postmortem, using VPC endpoints to connect to DynamoDB was what caused the impact. The service was correctly set to opportunistically write the response back to DynamoDB. The issue was my lookup only caught my custom `TokenNotFoundException.` DynamoDB failures threw a different exception which my code was not expecting. I made a quick fix to go to origin on any failure, but we ended up waiting out the outage and not trying to deploy during it. Only a portion of users were affected, and we didn't want to make the situation worse by the ongoing outage causing a deployment issue. After the outage and much testing with simulated conditions like removing IAM access to the table, we deployed the change to production.

#### Docker Log Driver Ring Buffer

One issue that hit us out of left field was the [Kinesis outage of November 25th, 2020.](https://aws.amazon.com/message/11201/) We had on-prem and ECS Docker services that froze up and were unable to deploy new. None of our applications used Kinesis, so what was going on? It turned out that the Docker log drivers can actually block the applications if logs aren't accepted. Cloudwatch logs depended on Kinesis and therefore couldn't ingest logs. I was surprised this was default behavior so [opened a Github issue](https://github.com/moby/moby/issues/41714) asking if there was any plan to change. We set all our services to non-blocking with a buffer after that event. AWS later released [a blog post](https://aws.amazon.com/blogs/containers/choosing-container-logging-options-to-avoid-backpressure/) addressing this issue and presenting the options tradeoffs.

### Application Service Dependencies

Which cloud services you use might be a bit more in your purview, but sometimes what other application services you interact with (especially if owned by other teams) can be necessitated by the requirements. We still should take explicit inventory of those dependencies. Having that information will allow us to better share knowledge about the system as well as prepare us for responding to incidents. If a downstream service encounters an outage, we can know what to expect from our system.

Knowing dependency ordering to bring up the whole system from a hard-down outage is important. Figuring that out before an incident will be much easier than a chat storm during. Extra care must be taken when trying to identify circular dependencies that can inhibit the application from coming up successfully. A recent interesting read along those lines is Gergely Orosz's article [Inside Datadog’s $5M Outage.](https://newsletter.pragmaticengineer.com/p/inside-the-datadog-outage) Many times these circular dependencies are at the control plane level. This is why we try to use services with managed control planes instead of running those ourselves. However, circular dependencies can still exist within applications, so we must be careful with those as well.

### Health Check Dependencies

Last week, I saw a service in Dev that was continually flapping unable to come up healthy. After looking at the ECS statuses and logs, it became apparent that the health check was failing, and the health check was failing due to a synthetic DynamoDB read failing. That health check was looking up a particular test data record that was no longer there. The dev database had probably been cleared at some point to start over fresh which caused the service to start flapping.

Health checks should depend on another service (cloud or app) only if the **only** way to recover from that service being down is to restart your container. This should almost never be the case as a service should be able to reinitialize connections to its dependencies without a full restart.

The AWS Builders Library has a great [article about things to watch for when implementing health checks](https://aws.amazon.com/builders-library/implementing-health-checks/). Two choice quotes below:

> Dependency health checks are appealing because they act as a thorough test of a server’s health. Unfortunately they can be dangerous because a dependency can cause a cascading failure throughout a system.

> The difficulty with health checks is this tension between, on the one hand, the benefits of thorough health checks and quickly mitigating single-server failures and, on the other hand, the harm done by a false positive failure across the entire fleet. Thus, one of the challenges of building a good health check is to guard carefully against false positives. In general, this means that the automation surrounding health checks should stop directing traffic to a single bad server but keep allowing traffic if the entire fleet appears to be having trouble.

Hopefully this post has given some food for thought about being cognizant of system dependencies, criticality of them, and plans for when they fail.
