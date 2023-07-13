---
title: "Blog Images"
date: 2023-06-29T20:00:00-04:00
tags: ["blog"]
---

When I started writing, I anticipated it would be mostly text with the [occasional diagram](https://github.com/danieladams456/aws-assert-role/blob/main/docs/aws-assert-role.png) included. But my [most recent post](/2023/in-pursuit-of-learning/) was long enough I figured a picture might make it a bit more interesting.

I knew I _could_ store the images in my Hugo static site repo, but I didn't want the over-time slowdown caused by having to clone even small images. I wanted to host them outside the posts repo. There's a chance in the future I will create a separate repo using LFS for content tracking and a CI job for uploading them, but manual uploads will suffice for now.

I started by looking at Cloudflare Images. I had read some blog posts about that service, and it sounded like a nice API. Upload you images, and the service automatically resizes them into variants that can be requested by alias for different resolutions. The pricing had a floor of $5 a month instead of strictly per-request cost. I'm sure it is a great, developer-friendly service, but I am only planning on every 4th post having images or around 12 images uploaded a year. At that point, I wanted something that would be basically free. I ended up going with Cloudflare R2 storage (like S3), configuring https://images.danieladamstech.com to serve the bucket, and pre-computing the variants client side.

Cloudflare R2 is a storage service with [zero egress fees](https://www.cloudflare.com/products/r2/) and a S3 compatible API. [This docs page](https://developers.cloudflare.com/r2/api/s3/api) helpfully shows which portions of the API are implemented. The biggest feature missing in my mind is object versioning. I love S3's versioning in combination with a lifecycle to [expire noncurrent versions](https://docs.aws.amazon.com/AmazonS3/latest/API/API_NoncurrentVersionExpiration.html) after 30 days. This provides a convenient "recycle bin" to help prevent accidental deletion.

Many of my iPhone camera pictures are in heic format which needs conversion to jpg for display in browsers. I found [this article](https://medium.com/shell-life/convert-images-for-web-using-the-sips-command-line-on-macosx-656c502a67a6) about how to use the Mac built-in tool [sips](https://ss64.com/osx/sips.html) for image conversion. Then I read that [imagemagick had better results](https://decovar.dev/blog/2019/12/12/imagemagick-vs-sips-resize/) and is open source so ended up using that.

```sh
#!/bin/bash
set -eu

SOURCE="$1"
TARGET="$2"

# blog text width
magick "$SOURCE" -format jpg -resize 720 "$TARGET-small.jpg"
# 4k width
magick "$SOURCE" -format jpg -resize 3840 "$TARGET-large.jpg"

```
