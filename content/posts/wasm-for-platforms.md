---
title: "Wasm for Platforms"
date: 2023-06-12T22:00:00-04:00
tags: ["architecture"]
---

Today we will follow up on my [previous post about programmable platforms](/2023/platforms-not-products/) and delve into WebAssembly as an implementation option. I have read about [WebAssembly on the CloudFlare blog](https://blog.cloudflare.com/tag/webassembly/) since 2019, but my interest piqued the other day when listening to the [Software Snack Bites podcast about WebAssembly](https://shomik.substack.com/p/5-matt-butcher-ceo-fermyon-and-steve). The [1.0 spec](https://www.w3.org/TR/wasm-core-1/) was published in December 2019 which started a marked uptick in awareness. Notable implementations include [Wasmtime](https://wasmtime.dev/) by the [Bytecode Alliance](https://bytecodealliance.org/) (writers of the spec) and the CNCF project [WasmEdge](https://wasmedge.org/).

> [From the spec:](https://www.w3.org/TR/wasm-core-1/#introduction%E2%91%A2) WebAssembly (abbreviated Wasm) is a safe, portable, low-level code format designed for efficient execution and compact representation. Its main goal is to enable high-performance applications on the Web, but it does not make any Web-specific assumptions or provide Web-specific features, so it can be employed in other environments as well.

WebAssembly was originally developed for browser execution of optimized C++ via JavaScript bindings. As the specification solidified, other people saw promise on the server side. WebAssembly has several nice properties for serverless multi-tenancy. It is secure by default and only exposes interfaces through capabilities. On the performance side, it has "zero cold start penalty." This is HUGE for serverless platforms. One of the tradeoffs a developer must account for when deciding whether to go serverless or not has traditionally been acceptable p99 latency due to cold starts.

WebAssembly was designed for web levels of forward compatibility. If there were any backwards incompatible changes, a new binary format version would be created, but the expectation of that is ["very infrequently, if ever."](https://www.w3.org/TR/wasm-core-1/#modules%E2%91%A0%E2%93%AA) This is good news for both application and tooling developers, who can expect a stable set of system interface specifications that will not change.

Building platforms is a natural fit for Wasm. SaaS customers need ways of embedding custom logic in workflows within the platform. One way of delivering that capability is through rules engines or custom [DSLs](https://en.wikipedia.org/wiki/Domain-specific_language), but those are more constrained in the capabilities they offer. Securely and performantly executing customer-provided code provides the open-ended avenue necessary to unleash developer creativity.

Correctness of custom code is always the responsibility of the developer, but platforms hosting user code can take away much of the other complexity. The user does not have to worry about reachability and latency of API calls from the platform out to his endpoint. The "glue" is all managed by the platform host and generally provides the best end-user experience. A good example of platform-hosted and external extensibility in the same platform is Snowflake's [Snowpark UDFs](https://docs.snowflake.com/en/developer-guide/snowpark/python/creating-udfs) and [External Functions](https://developers.cloudflare.com/cloudflare-for-platforms/workers-for-platforms/). Sometimes a requirement for exclusive control might keep you from putting a piece of functionality into a platform, but in most other cases, the reliability and performance lean strongly towards submitting user code for the platform to manage and run.

I would like to call out two examples of these in the real world. [Shopify functions](https://shopify.dev/docs/apps/functions) allow developers to customize the behavior of the platform ranging from [discounts](https://shopify.dev/docs/apps/selling-strategies/discounts/experience), [payment customizations](https://shopify.dev/docs/apps/checkout/payment-customizations), [custom validations](https://shopify.dev/docs/apps/checkout/validation/server-side), and more. [Targeting WASM](https://shopify.dev/docs/apps/functions/language-support) allows developers to pick the most appropriate language for the task. High level logic can quickly be written in JavaScript or TypeScript, and computationally intensive operations can be optimally implemented in Rust. Picking 10 of the highest customer-requested "logic choke points" within the app and opening those up for extensibility can remove large burdens from the SaaS development teams. Customers that were previously blocked and have the resources to invest in customization can self-serve.

The other instance of Wasm support is in a "platform for platforms." It's like platform-ception! [Cloudflare Workers for Platforms](https://developers.cloudflare.com/cloudflare-for-platforms/workers-for-platforms/) provides a managed execution environment for customer-supplied code with developer-friendly [zero-cost abstractions](https://developers.cloudflare.com/workers/platform/bindings/about-service-bindings/). They allow Workers for Platforms customers to have an [unlimited number](https://developers.cloudflare.com/cloudflare-for-platforms/workers-for-platforms/platform/limits/) of scripts so all the end users can submit their customizations. If I was building a SaaS application, I would be very interested in trying this out.

As always, there is no completely free lunch. Platform hooks are just like any other API in that they must be kept stable. Increasing API surface before you know you have the correct abstraction can lock you into a design and prevent refactoring down the road. [This interview](https://changelog.com/podcast/531#transcript-68) with Nathan Sobo about building the [Atom](https://github.blog/2022-06-08-sunsetting-atom/) editor at GitHub (and his new editor [Zed](https://zed.dev/)) highlights this. Looking back, Nathan said they focused on extensibility a little too much when building Atom. Some of those decisions, like allowing extension code to run on the main thread instead of [VSCode's](https://code.visualstudio.com/) more constrained [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) design, lead to inflexibility down the road.
