#!/bin/bash

# Build language editions for tiddlywiki.com using the version of tiddlywiki specified in package.json

# Default to using tw5.com as the main edition

if [  -z "$TW5_BUILD_MAIN_EDITION" ]; then
    TW5_BUILD_MAIN_EDITION=../TiddlyWiki5/editions/tw5.com
fi

# Default to the version of TiddlyWiki installed in this repo

if [  -z "$TW5_BUILD_TIDDLYWIKI" ]; then
    TW5_BUILD_TIDDLYWIKI=../build.jermolene.github.io/node_modules/tiddlywiki/tiddlywiki.js
fi

# Set up the build output directory

if [  -z "$TW5_BUILD_OUTPUT" ]; then
    TW5_BUILD_OUTPUT=../jermolene.github.io
fi

if [  ! -d "$TW5_BUILD_OUTPUT" ]; then
    echo 'A valid TW5_BUILD_OUTPUT environment variable must be set'
    exit 1
fi

echo "Using TW5_BUILD_OUTPUT as [$TW5_BUILD_OUTPUT]"

# Delete any existing static content

rm $TW5_BUILD_OUTPUT/languages/de_AT/static/*
rm $TW5_BUILD_OUTPUT/languages/de_DE/static/*

######################################################
#
# Language editions
#
######################################################

# /languages/de-AT/index.html		Demo wiki with de-AT language
# /languages/de-AT/empty.html		Empty wiki with de-AT language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/de-AT \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/de-AT \
	--build favicon empty static index \
	|| exit 1

# /languages/de-DE/index.html		Demo wiki with de-DE language
# /languages/de-DE/empty.html		Empty wiki with de-DE language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/de-DE \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/de-DE \
	--build favicon empty static index \
	|| exit 1

# /languages/fr-FR/index.html		Demo wiki with fr-FR language
# /languages/fr-FR/empty.html		Empty wiki with fr-FR language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/fr-FR \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/fr-FR \
	--build index empty \
	|| exit 1

# /languages/zh-Hans/index.html		Demo wiki with zh-Hans language
# /languages/zh-Hans/empty.html		Empty wiki with zh-Hans language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/zh-Hans \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all languages/zh-Hans/index.html text/plain \
	--rendertiddler $:/core/save/empty languages/zh-Hans/empty.html text/plain \
	|| exit 1

# /languages/zh-Hant/index.html		Demo wiki with zh-Hant language
# /languages/zh-Hant/empty.html		Empty wiki with zh-Hant language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/zh-Hant \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all languages/zh-Hant/index.html text/plain \
	--rendertiddler $:/core/save/empty languages/zh-Hant/empty.html text/plain \
	|| exit 1
