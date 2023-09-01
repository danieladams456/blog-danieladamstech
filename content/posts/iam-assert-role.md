---
title: "IAM Assert Role"
date: 2023-08-31T20:00:00-04:00
tags: ["architecture"]
draft: true
---

Back at the start of 2021 I delved into a small curiosity project around how to assert ownership of an AWS role to a non-AWS entity. I implemented an API Gateway Sigv4 signer in a Spring `RestTemplateInterceptor`. Later we integrated that design in a production app. That security integration has had zero issues since. As a thought experiment, I wanted to see if it was possible to use an IAM root of trust when calling other endpoints besides API Gateway. AWS Sigv4 authentication is a symmetric scheme, but to keep things simple with less security resources on the verification side, I knew I needed to use asymmetric verification.

This idea was inspired by CyberArk DAP [IAM Authenticator integration](https://docs.cyberark.com/Product-Doc/OnlineHelp/AAM-DAP/Latest/en/Content/Operations/Services/AWS_IAM_Authenticator.htm). I later realized [Hashicorp Vault IAM authenticator](https://hashicorp.com) uses the same design. The client will pre-sign an STS [`GetCallerIdentity`](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetCallerIdentity.html) request, which can then be executed by a trusted entity. Handing over this signature will not compromise the security of the IAM role secret keys. The trusted entity will get a response directly from AWS STS, which can be trusted. We then know the caller has that specific role session. This design prevents administrators from seeing application tokens. The only ways for them to get tokens is to edit the IAM [role trust policy](https://aws.amazon.com/blogs/security/how-to-use-trust-policies-with-iam-roles/) or to get on the host itself and pull role credentials. Both of these would compromise the IAM role system as a whole, so we maintain the same security posture as access to AWS resources.

The presign and execute process could be done on every app request, but making a network call every time is slow and susceptible to throttling. We instead sign that assertion with [KMS asymmetric keys](https://aws.amazon.com/blogs/security/digital-signing-asymmetric-keys-aws-kms/). The `RSASSA_PKCS1_V1_5_SHA_256` algorithm supported by KMS is the same one used for `RS256` signed JWTs. By constructing the appropriate JWT header and body, this allows us to issue industry standard tokens which can be verified by client libraries across many languages. In standard JWT verification process, the verifier can have multiple public key IDs to support rotation of a specific key upon compromise. The backups signing key[s] can have deny policies in KMS. If a key is compromised, it can be scheduled for deletion thereby disabling the key. The next key can be enabled for usage without applications having to always check the public key endpoint.

`Insert Picture`

My previous Sigv4 signer integration was in Java, so I wanted to use some other languages for this exercise.

- Request formulation and presigning
  - JavaScript via AWS SDK middleware. This is a more roundabout hack method, but the SDK manages pulling credentials from the metadata endpoint and maintaining a fresh session token component
  - JavaScript via AWS SDK SignatureV4 module. Code is very straightforward, but doesn't pull the credentials for you.
  - The cleanest way is using the external dependency from **\_\_** `aws4`
- Posting to STS, signing with KMS, and constructing JWT - Python
- JWT verification - Go

The main shortcoming of this idea and why it isn't practical for using by itself in a production scenario is it only addresses authentication, not authorization. I believe AWS IAM roles are about the best root of trust available, but a good authorization system is necessary. Hashicorp Vault and CyberArk bring robust implementations on the authorization side, but that is not something I would want to code custom.

This is where AWS VPC Lattice comes in. I was very excited to hear about it when I attended Re:Invent last year. I switched my schedule around to go to a talk by the Lattice team. AWS API Gateway private APIs to backends over PrivateLink accomplishes something similar from a security perspective, but has a much more complex set of AWS resources. That is worth it when you are trying to achieve API governance, but sometimes you just want a simple connection with good security. The VPC lattice target group construct achieves this perfectly. VPC lattice uses `IAM policies to control traffic`, just like API Gateway. `Look up ARN format for policy`.
