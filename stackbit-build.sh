#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e233a8b6bd1f2001a4617ee/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e233a8b6bd1f2001a4617ee 
fi
curl -s -X POST https://api.stackbit.com/project/5e233a8b6bd1f2001a4617ee/webhook/build/ssgbuild > /dev/null
jekyll build

curl -s -X POST https://api.stackbit.com/project/5e233a8b6bd1f2001a4617ee/webhook/build/publish > /dev/null
