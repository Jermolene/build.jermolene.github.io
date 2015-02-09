#!/bin/bash

# Build plugin library

# Use the pre-release edition as the main edition

export TW5_BUILD_MAIN_EDITION=../TiddlyWiki5/editions/prerelease

# Use the pre-release version of tiddlywiki

export TW5_BUILD_TIDDLYWIKI=./tiddlywiki.js

# Set up the build output directory

if [  -z "$TW5_BUILD_OUTPUT" ]; then
    export TW5_BUILD_OUTPUT=../jermolene.github.io/prerelease
fi

mkdir -p $TW5_BUILD_OUTPUT

# Build editions

node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/pluginlibrary \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--build \
	|| exit 1
