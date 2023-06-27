#!/bin/bash
set -eu

GIT_BRANCH="${CF_PAGES_BRANCH:-main}"
echo "building on git branch: $GIT_BRANCH"

# Hugo docs recommend removing previous publish dir since hugo does not remove files automagically
# https://gohugo.io/getting-started/usage/#build-your-site
rm -rf public/

# main branch for prod deploy only builds non-drafts
if [[ "$GIT_BRANCH" == "main" ]]; then
  hugo
else
  # CF_PAGES_BRANCH set, so implies build in Cloudflare
  hugo --baseURL "$CF_PAGES_URL" --buildDrafts --buildFuture
fi
