---
# post comment
title: "Platforms, Not Products"
date: 2023-06-04T13:42:36-04:00
draft: true
---
Back in April, I read one of Gergley’s newsletters on Steve Yegge and Developer Productivity (https://newsletter.pragmaticengineer.com/p/steve-yegge).  It was a very insightful and enjoyable read, but the part that stood out to me was not the main topic of the post.  It was a semi-famous (but unknown to me) piece Steve had written after 6 years of tenure at both Amazon and Google.  Known as “Stevey's Google Platforms Rant” (https://gist.github.com/chitchcock/1281611), it contrasts Amazon’s and Google’s execution and mindset.  Even though Google did almost everything in a technically superior way, Amazon came away with the winning platform.

Amazon stressed that their internal APIs between their internal product teams must be the same level of quality as external product APIs.  Transitioning was not without challenges and learnings, as summarized in Steve’s piece, but the end result was a programmable platform.  The focus on solid internal APIs mirrors Chick-fil-a’s Enterprise Architecture principle “Design for Composability.” (https://medium.com/chick-fil-atech/ea-principles-series-design-for-composability-90f5e12ffecf) 

“A product is useless without a platform, or more precisely and accurately, a platform-less product will always be replaced by an equivalent platform-ized product.” - Steve Yegge

One of the biggest reasons to build a platform is you can’t please everybody.  Users being able to extend and tweak your software could be the difference between it fitting their use case or not.  Two types of platforms are services others build apps on top of, like S3.  Those were never meant to be used in isolation.  Another is an application that is meant to be extensible by the end user, like Shopify.  They can start off with the out-of-the-box experience and then customize it with hooks.

I read Steve’s Platforms post after adding event-based triggering to my ML Pipeline.  It provides orchestration for several models the Data Science team has deployed to production.  We wanted to move from static schedules to triggering on Snowflake table load events.  There were weekly and monthly models with some variety of conditions on when to run.  For example, one time series model needed monthly retraining but also when a specific external dataset was updated.  We could have written a rules engine and tried to describe all the conditions as rules.  However, we saw the probable trajectory of increasingly complex conditions on the horizon.  After thinking about it for a couple weeks while on backlog and gathering input from various team members and other teams, I decided to implement the event filtering with a Data Science controlled code hook.  Later reading Steve’s thoughts on platforms gave a great feeling of satisfaction that we had picked the right direction.

The code hook is stored in the ML model git repo.  If the ML Pipelines AWS Step function is triggered with a Cloudwatch event, it will invoke the code hook to determine which phases of data prep, training, inference, and post-processing to run.  The hook is run in a Lambda function as part of the Step function.  The interface is modeled after a lambda handler interface with an event and context.  The event is the unwrapped Eventbridge event (since it is nested in a Lambda event when it comes in the true lambda handler.)  The context parameter contains properties like ML model name (so code can be shared across models without modification.)  Future iterations of this interface will have other methods that can be called as needed like get_snowflake_connection().  After the event and context objects are prepared, the code hook is called.  It is imported via a dynamic module load as specified in the python importlib docs (https://docs.python.org/3/library/importlib.html#importing-a-source-file-directly).


Next week - how WASM enables Platforms!
