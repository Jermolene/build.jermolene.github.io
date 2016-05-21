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

rm $TW5_BUILD_OUTPUT/languages/de-AT/static/*
rm $TW5_BUILD_OUTPUT/languages/de-DE/static/*
rm $TW5_BUILD_OUTPUT/languages/es-ES/static/*
rm $TW5_BUILD_OUTPUT/languages/fr-FR/static/*
rm $TW5_BUILD_OUTPUT/languages/ja-JP/static/*
rm $TW5_BUILD_OUTPUT/languages/ko-KR/static/*
rm $TW5_BUILD_OUTPUT/languages/zh-Hans/static/*
rm $TW5_BUILD_OUTPUT/languages/zh-Hant/static/*

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

# /languages/es-ES/index.html		Demo wiki with es-ES language
# /languages/es-ES/empty.html		Empty wiki with es-ES language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/es-ES \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/es-ES \
	--build favicon empty static index \
	|| exit 1

# /languages/fr-FR/index.html		Demo wiki with fr-FR language
# /languages/fr-FR/empty.html		Empty wiki with fr-FR language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/fr-FR \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/fr-FR \
	--build favicon empty static index \
	|| exit 1

# /languages/ja-JP/index.html		Demo wiki with ja-JP language
# /languages/ja-JP/empty.html		Empty wiki with ja-JP language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/ja-JP \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/ja-JP \
	--build empty index \
	|| exit 1

# /languages/ko-KR/index.html		Demo wiki with ko-KR language
# /languages/ko-KR/empty.html		Empty wiki with ko-KR language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/ko-KR \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/ko-KR \
	--build favicon empty static index \
	|| exit 1

# /languages/zh-Hans/index.html		Demo wiki with zh-Hans language
# /languages/zh-Hans/empty.html		Empty wiki with zh-Hans language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/zh-Hans \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/zh-Hans \
	--build empty index \
	|| exit 1

# /languages/zh-Hant/index.html		Demo wiki with zh-Hant language
# /languages/zh-Hant/empty.html		Empty wiki with zh-Hant language
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/zh-Hant \
	--verbose \
	--output $TW5_BUILD_OUTPUT/languages/zh-Hant \
	--build empty index \
	|| exit 1
