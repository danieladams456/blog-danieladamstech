---
title: "Wasm for Platforms"
date: 2023-06-12T06:00:00-04:00
tags: ["architecture"]
draft: true
---

The previous post talked about making platforms programmable by the customer. The other day, I listened to the [Software Snack Bites podcast about WebAssembly](https://shomik.substack.com/p/5-matt-butcher-ceo-fermyon-and-steve). I have read about [WebAssembly on the CloudFlare blog](https://blog.cloudflare.com/tag/webassembly/), but this episode explored some other portions of the ecosystem. The [1.0 spec](https://www.w3.org/TR/wasm-core-1/) was published in December 2019, and there are several implementations. Notable ones include [Wasmtime](https://wasmtime.dev/) by the [Bytecode Alliance](https://bytecodealliance.org/) (writers of the spec) and the CNCF project [WasmEdge](https://wasmedge.org/).

> [From the spec:](https://www.w3.org/TR/wasm-core-1/#introduction%E2%91%A2) WebAssembly (abbreviated Wasm) is a safe, portable, low-level code format designed for efficient execution and compact representation. Its main goal is to enable high performance applications on the Web, but it does not make any Web-specific assumptions or provide Web-specific features, so it can be employed in other environments as well.

WebAssembly was originally developed for browser execution of optimized C++ and other code via JavaScript bindings. As the specification solidified, other people saw promise on the server side. WebAssembly has several nice properties for serverless multi-tenancy. It is secure by default and only exposes interfaces through capabilities. On the performance side, it has "zero cold start penalty." This is HUGE for serverless platforms. One of the tradeoffs a developer must account for when deciding whether to go serverless or not has traditionally been acceptable p99 latency due to cold starts.

WebAssembly was designed for web levels of forward compatibility. If there were any backwards incompatible changes, a new binary format version would be created, but the expectation of that is ["very infrequently, if ever."](https://www.w3.org/TR/wasm-core-1/#modules%E2%91%A0%E2%93%AA) This is good news for both application and tooling developers, who can expect a stable set of system interface specifications that will not change.

Building platforms is a natural fit for Wasm. SaaS customers need ways of embedding custom logic in workflows within the platform. One way of delivering that capability is through rules engines or custom [DSLs](https://en.wikipedia.org/wiki/Domain-specific_language), but those are more constrained in the capabilities they offer. Securely and performantly executing customer-provided code provides the open-ended avenue necessary to unleash developer creativity.

Correctness of custom code is always the responsibility of the developer, but platforms hosting user code can take away much of the other complexity. The user does not have to worry about reachability and latency of API calls from the platform out to his endpoint. The "glue" is all managed by the platform host and generally provides the best end user experience. A good example of platform-hosted and external extensibility in the same platform are Snowflake's [Snowpark UDFs](https://docs.snowflake.com/en/developer-guide/snowpark/python/creating-udfs) and [External Functions](https://developers.cloudflare.com/cloudflare-for-platforms/workers-for-platforms/). Sometimes a requirement for exclusive control might keep you from putting a piece of functionality into a platform, but in most other cases, the reliability and performance lean strong towards submitting user code for the platform to manage and run.

Shopify functions
https://shopify.dev/docs/apps/functions/language-support/webassembly

Cloudflare Workers for Platforms
https://developers.cloudflare.com/cloudflare-for-platforms/workers-for-platforms/
