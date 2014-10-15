#!/bin/bash

# Build readmes from corresponding tiddlers

# Default to the version of TiddlyWiki installed in this repo

if [  -z "$TW5_BUILD_TIDDLYWIKI" ]; then
    TW5_BUILD_TIDDLYWIKI=../build.jermolene.github.io/node_modules/tiddlywiki/tiddlywiki.js
fi

# tw5.com readmes
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/tw5.com \
	--verbose \
	--output . \
	--build readmes \
	|| exit 1

# dev readmes
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/dev \
	--verbose \
	--output ../build.jermolene.github.io \
	--build build-readme \
	|| exit 1

