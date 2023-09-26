---
title: "Hammock Driven Development"
date: 2023-09-26T03:45:00-04:00
tags: ["software engineering"]
linkedin: "The story of this morning - waking up with an idea at 3:45..."
---

_...Or how good ideas sometimes come in the middle of the night._

An episode of the Big Ideas in App Architecture podcast introduced me to a set of talks by Rich Hickey. I think it was [this one with Joe Lynch?](https://www.cockroachlabs.com/big-ideas-podcast/joe-lynch/) Rich's talks were [Simple Made Easy](https://www.youtube.com/watch?v=SxdOUGdseq4) and [Hammock Driven Development](https://www.youtube.com/watch?v=f84n5oFoZBc). Both were insightful regarding what mindset to invoke when creating software.

The premise of hammock driven development is that thinking about a topic over a long enough period of linear time causes the subconscious mind to prioritize it. Prefer a week or more in the conscious thought space; it won't happen with cramming for a day or two. That conscious prioritization lets your mind know it is something you want it to work on in the background. That can lead to an aha moment when you're not expecting it. An implication of the timeline is that you should start thinking about projects and problems on the horizon with a good bit of lead time before you need to implement a solution. This will give you enough time to really digest the options. Who knows, this could all be a [bunch of hooey.](https://dictionary.cambridge.org/us/dictionary/english/hooey)

I tend to do my best thinking in the morning before the kids get up and before coming into the office since the house is quiet. I was one of those college students who would use the quiet study zone in the library to do my math homework. Today, I woke up at 3:45 with a generic idea of how the API I was trying to refactor could interact in a generic way with the data mapper to denormalize into the desired DynamoDB object structure. I thought through this from 3:45 to 4:30 and took some notes. Then I tried to go back to sleep, but unfortunately, that didn't work out. :P

The goal in modeling this API as defaults + overrides is gaining the ability to recategorize properties in the future between shared and specific to a service type.

## Data Service Notes

```
Record leaf(props...)
Record root(List<leaf+string serviceType> serviceTypes, props...) extends leaf

map(leaf, root) {
prop = coalesce(leaf, root)
return transform(prop)
}

root: ProfileConfig
leaf: ProfileServiceTypeConfig
```

[Reddit link on why Java Records are not extensible:](https://www.reddit.com/r/java/comments/nh34k3/why_are_records_not_extensible/gyv0kj3/)

> The restrictions on records may seem arbitrary at first, but they all stem from a common goal, which we can summarize as "records are the state, the whole state, and nothing but the state." Specifically, we want equality of records to be derived from the entirety of the state declared in the state description, and nothing else. Were mutable fields, or extra fields, or superclasses permitted, these would each introduce situations where equality of records either ignored certain state components (it is questionable to include mutable components in equality calculations), or was dependent on additional state that is not part of the state description (such as additional instance fields or superclass state). This would have greatly complicated the feature (since surely developers would demand the ability to separately specify which components are part of the equality calculation), and also undermine desirable semantic invariants (such as: extracting the state and constructing a new record from the resulting values should result in a record equal to the original).

Pivot to more static, less dynamic:

`It will probably be easier to validate required fields through annotations if they are statically either in root or leaf. The same 400 status code could be returned with a custom exception during data mapping, but then lose the automatic spring boot validation root cause analysis in RFC ProblemDetail error returned.`

`It's still an easy mapping change to move a property from one to the other. Also solves the read structure (knowing which properties to include at the root vs. leaf level) without reflection.`

## Rest of the Morning

1. Bible reading
2. Pushups and dumbbell rows listening to Morse code ([CRSnet streams](https://streammyaudio.com/archive))
3. Yogurt and nuts listening to the [All-In podcast](https://www.youtube.com/@allin)
4. Shower and developing the idea for this blog post
5. Writing blog post
6. Planning on hitting Chick-fil-A for a chicken biscuit for second breakfast on the way in to work.
