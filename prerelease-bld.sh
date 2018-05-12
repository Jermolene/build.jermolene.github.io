#!/bin/bash

# Build all tiddlywiki.com assets using the version of tiddlywiki specified in package.json

# Default to the current version

export TW5_BUILD_VERSION=v5.1.18

# Use the pre-release edition as the main edition

export TW5_BUILD_MAIN_EDITION=../TiddlyWiki5/editions/prerelease

# Use the pre-release version of tiddlywiki

export TW5_BUILD_TIDDLYWIKI=./tiddlywiki.js

# Set up the build output directory

if [  -z "$TW5_BUILD_OUTPUT" ]; then
    export TW5_BUILD_OUTPUT=../jermolene.github.io/prerelease
fi

mkdir -p $TW5_BUILD_OUTPUT

# Invoke the main bld script
../build.jermolene.github.io/bld.sh
