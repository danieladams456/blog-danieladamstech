---
title: "Measuring Entrypoint Layer Latency in NewRelic"
date: 2023-10-30T21:00:00-04:00
draft: true
---

In a microservices environment where services align to team boundaries, many times it will be necessary to call a service owned by another team. My team is responsible for the customer-facing external API layer for B2B transactions. We maintain multiple versions of [MISMO](https://www.mismo.org/) APIs, handle security, logging, monitoring, and mapping the customer request to a standardized data format our internal APIs can consume. The APIs we are fronting do a lot of work. They run large rule sets and other checks for mortgage insurance rate quotes or orders. Some are even dependent on external APIs like a credit pull. This leads to variance in response time.

As the customer-facing team, we want to ensure all our customers have a good experience. This leads us to track overall system response time. However, it is hard to track the performance of our own code via that metric as our code accounts for less than 5% of the total transaction time. How then can we set up meaningful alerts for our team's performance? We need to track timing at the team microservice boundary. This is simple when you're the "leaf node" on the downstream side. However, the entrypoint layer takes time on the front end and back end of the transaction. We need to identify a span in the distributed trace that represents the "noise" in measurement that we want to remove and then subtract out that duration from the outer span. This requires a bit of playing around with platform-specific query capabilities. In standard SQL, options are not very constrained, but sometimes approach needs to be adapted a bit to fit a streaming data analysis pipeline like the pipeline that drives monitoring alerts.

The query below attempts to execute this strategy. The where clause pulls in both the outer and inner transactions into the intermediate result set. Then the select portion calculates two metrics from the bisection of that result set by microservice and figures the difference.

```sql
FROM Span SELECT
  filter(percentile(duration, 90), where appName = 'Entrypoint Layer') -
  filter(percentile(duration, 90), where appName = 'Last Hop to Include') as entrypointLayerDuration
WHERE
  (appName = 'Entrypoint Layer' and TransactionCustomAttributeName = 'CustomValue')
  or (appName = 'Last Hop to Include' and name = 'External/destination.corp.net/CommonsHttp/execute')
```

This query works as long as the first and last hop queries can uniquely retrieve transactions under measurement. For example, if two different transactions in the last hop microservice made a call to the same uninstrumented DNS name, the second half of the query would pull in more traces and skew the timing. NewRelic [recently rolled out](https://newrelic.com/blog/how-to-relic/subquery-joins) [subquery joins.](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/nrql-query-tutorials/subquery-joins/) It has some cardinality restrictions, but I could see if those were meaningful if the need arose to more strictly match trace IDs instead of just taking the aggregate of two populations. One situation I'm thinking of as I write this post is if the entrypoint service errors and quickly returns. That drives down the first number to nearly instantaneous while the second number is only accounting for transactions that made it all the way to last hop service. The metric could go negative in that case.
