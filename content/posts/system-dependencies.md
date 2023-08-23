---
title: "System Dependencies"
date: 2023-08-22T20:00:00-04:00
tags: ["architecture"]
draft: true
---

### Cloud Service Dependencies

When designing an app, we want to carefully evaluate what dependencies it has. Cloud services are highly available, but the union of many still is measurable.

Caching proxy write on response

Docker logs ring buffer

### Application Service Dependencies

Which cloud services you use might be a bit more in your purview, but sometimes what other application services you interact with (especially if owned by other teams) might be part of the business case. Still need to take inventory of the coupling.

Know your dependency graph to know how you have to bring things back up in a worst-case outage where everything is hard down. Figuring that our before an incident will be much easier than a chat storm during.

### Health Check Dependencies

Last week, I saw a service in Dev that was continually flapping unable to come up healthy. After looking at the ECS statuses and logs, it became apparent that the health check was failing, and the health check was failing due to a synthetic DynamoDB read failing. That health check was looking up a particular test data record which was no longer there. The dev database had probably been cleared at some point to start over fresh which caused the service to start flapping.

Health checks should depend on another service (cloud or app) only if the only way to recover from that service being down is to restart your container. This should be the small minority of cases as a service should be able to reinitialize connections to its dependencies without a full restart.
