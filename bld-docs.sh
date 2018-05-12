#!/bin/bash

# Update the docs of tiddlywiki.com by building edition tw5.com

# Default to the current version

if [  -z "$TW5_BUILD_VERSION" ]; then
    TW5_BUILD_VERSION=v5.1.17
fi

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

mkdir -p $TW5_BUILD_OUTPUT/static
mkdir -p $TW5_BUILD_OUTPUT/dev
mkdir -p $TW5_BUILD_OUTPUT/dev/static
rm $TW5_BUILD_OUTPUT/static/*
rm $TW5_BUILD_OUTPUT/dev/static/*

# Redirects

######################################################
#
# Core distribution
#
######################################################

# /index.html			Main site
# /favicon.ico			Favicon for main site
# /empty.html			Empty
# /empty.hta			For Internet Explorer
# /static.html			Static rendering of default tiddlers
# /alltiddlers.html		Static rendering of all tiddlers
# /static/*				Static single tiddlers
# /static/static.css	Static stylesheet
# /static/favicon.ico	Favicon for static pages
node $TW5_BUILD_TIDDLYWIKI \
	$TW5_BUILD_MAIN_EDITION \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--build favicon empty static index \
	|| exit 1

# /dev/index.html			Developer docs
# /dev/favicon.ico			Favicon for dev site
# /dev/static.html			Static rendering of default tiddlers
# /dev/alltiddlers.html		Static rendering of all tiddlers
# /dev/static/*				Static single tiddlers
# /dev/static/static.css	Static stylesheet
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/dev \
	--verbose \
	--output $TW5_BUILD_OUTPUT/dev \
	--build index favicon static \
	|| exit 1

# /encrypted.html			Copy of the main file encrypted with the password "password"
node $TW5_BUILD_TIDDLYWIKI \
	$TW5_BUILD_MAIN_EDITION \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--build encrypted \
	|| exit 1
