---
title: "Call Graph Voting Proposal"
date: 2024-12-28T22:00:00-05:00
draft: true
---

We all have errors.  What is your nominal error rate?  What does that mean - all errors or just internal errors?  Is everyone on the same page about that?

There's two aspects I believe need solved.
1. Error reporting **precision**: More granular status categorization than HTTP codes get you by themselves, including ambiguity of fault assignment.  This also covers APIs that only use a single HTTP code, like industry-specific XML APIs that report status in the body.
2. Error reporting **accuracy**: Propogation of and voting on fault assignment as requests travel through depth and breadth of a microservice call graph.

Solving these challenges reaps benefits.
1. Accurate fault assignment allows SLO creation.  Without a higher level categorization, SLO inclusion/exclusion logic can be brittle.
2. Combine multiple error conditions into semantic levels.  This allows for monitoring complexity to stay bounded as the number of error conditions grows.

<!-- Finalize: categorization vs classification.  Is classification more "fixed" in terms of buckets? -->
## Categorization
Categorizing errors in deeper granularity increases **precision**.  Sometimes you don't want precision, like when you need more statistical power in anomaly detection monitoring.  In those cases, the sub-categories can be combined back together into higher level categories: success, our fault, customer's fault.  But maintaining more precise, per-request outcomes is helpful for troubleshooting or assessing incident impact.

Here was a quote from David Reaver in his talk [How Stripe achieves five and a half 9s of availability, Re:Invent 2024](https://youtu.be/7vn49exuYxo?t=1576) that is a useful data point how some organizations are moving beyond just using status codes.  I would be curious to learn more about Stripe's error categorization framework.

> We don't solely rely on standard HTTP response codes to decide if a request is successful or not.  Classically 200 "that's great," 500 is "error and our fault," 400 is "error and your fault."
> 
>  That's too simple.  We don't do that.  There are lots of legitimate 400 responses that are kind of routine and expected.  You can't just page on them all the time.

### Examples:
404s on a system of record might have a different level of confidence than 404s on a derived data system.  It would be nice if we could engineer all systems to be like [KMS grant tokens](https://docs.aws.amazon.com/kms/latest/developerguide/using-grant-token.html) and overcome eventual consistency, but in reality, sometimes we have to deal with non-ideal scenarios.  It can be helpful to recognize and codify a particular system's resource not found as an `unclear attribution error` instead of just assuming it's the client's fault.  We can follow up with automation that checks if the item eventually shows up or correlate with processing/replcia latency metrics coming out of that system to get the full picture and raise the necessary alerts.

400 errors can also have a large semantic range.  One client might send a request with `North Carolina` instead of `NC` for an enum value and be rejected immediately. Another might fail further down the request path if North Carolina doesn't yet have regulatory approval for a product.  Both failures based on the customer-provided data.  We can categorize them more precisely into `customer data validation error` and `customer data error`.

Things can get tricky on conditionally required data.  A business rule upstream could necessitate an additional piece of data only sent in 1% of circumstances.  Is this a validation error or a calculation error?  This is why, irrespective of which categories your business chooses, they must be defined precisely.  The catorizations provided here are a starting point to jog ideas.  Each organization should agree on a set that covers all their incoming transactions.  The organization can then have a shared nomenclature, leading to more accurate commmunication.

## Voting
The second goal of this proposal is to increase error reporting accuracy via delegating and voting.  Whether you have microservices, a modular monolith, or any other design, there will be abstractions.  These abstractions shield complexity but also shield information.  Ultimately, we want to know the status of the final response to the customer, but the high abstraction component packaging it up might not know the details on why a failure occurred.  The solution is a structured and predictable way to pass and merge status from all levels on the call graph response path.

Errors can occur at any level of the call graph and before, during, or after work.
* Before: a request comes in, validation fails, and immediatly returns.
* During: an upstream service or DB is unavailable.
* After: two DB or RPC calls are made, then an error occurs merging the results.

We need a voting algorithm

## Feedback
What do you think?  Should we just attach very explicit business meaning to HTTP codes?  Does leaving them decoupled retain more flexibility for evolving categorizations while keeping the system API stable?  Are there existing standards or frameworks I can research that accomplish a similar objective?
