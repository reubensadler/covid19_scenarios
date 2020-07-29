#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
trap "exit" INT

# Removes "next" from package.json dependency list
# Reason: Trick Vercel into thinking that we are not using Next.js. All we want is to reproduce the generic CI
# environment and don't care about Vercel's integrations with Next.js.
sed -i.bak '/"next":/d' package.json
rm next.config.js
