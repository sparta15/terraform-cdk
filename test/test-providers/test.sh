#!/bin/sh
set -e

# Disable spinner even when we have a TTY
export CI='1'

scriptdir=$(cd $(dirname $0) && pwd)

cd $(mktemp -d)
mkdir test && cd test

# initialize an empty project
cdktf init --template typescript-minimal --project-name="typescript-test" --project-description="typescript test app" --local

# put some code in it
cp ${scriptdir}/main.ts .

# add null provider
cp ${scriptdir}/cdktf.json .
cdktf get
yarn compile

echo "PASS"