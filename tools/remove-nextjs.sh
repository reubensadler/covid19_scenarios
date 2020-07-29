#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
trap "exit" INT

set -x

# Removes "next" from package.json dependency list
# Reason: Trick Vercel into thinking that we are not using Next.js. All we want is to reproduce the generic CI
# environment and don't care about Vercel's integrations with Next.js.
sed -i.bak '/"next":/d' package.json
rm next.config.js

# Creates a .next/<BUILD_ID> directory
# Reason: We don't use Vercel's integration with Next.js and here we fake BUILD_ID, so that Vercel don't fail in the end.
BUILD_ID=$(cat .build/production/tmp/BUILD_ID)
mkdir -p ".next/${BUILD_ID}"
mkdir -p ".build/production/web/${BUILD_ID}"

cp .build/production/tmp/BUILD_ID .build/production/web/
