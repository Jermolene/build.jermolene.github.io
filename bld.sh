#!/bin/bash

# Build all tiddlywiki.com assets using the version of tiddlywiki specified in package.json

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

# Make the CNAME file that GitHub Pages requires

echo "tiddlywiki.com" > $TW5_BUILD_OUTPUT/CNAME

# Delete any existing static content

mkdir -p $TW5_BUILD_OUTPUT/static
mkdir -p $TW5_BUILD_OUTPUT/dev
mkdir -p $TW5_BUILD_OUTPUT/dev/static
rm $TW5_BUILD_OUTPUT/static/*
rm $TW5_BUILD_OUTPUT/dev/static/*

# Redirects

echo "<a href='./plugins/tiddlywiki/tw2parser/index.html'>Moved to http://tiddlywiki.com/plugins/tiddlywiki/tw2parser/index.html</a>" > $TW5_BUILD_OUTPUT/classicparserdemo.html
echo "<a href='./plugins/tiddlywiki/codemirror/index.html'>Moved to http://tiddlywiki.com/plugins/tiddlywiki/codemirror/index.html</a>" > $TW5_BUILD_OUTPUT/codemirrordemo.html
echo "<a href='./plugins/tiddlywiki/d3/index.html'>Moved to http://tiddlywiki.com/plugins/tiddlywiki/d3/index.html</a>" > $TW5_BUILD_OUTPUT/d3demo.html
echo "<a href='./plugins/tiddlywiki/highlight/index.html'>Moved to http://tiddlywiki.com/plugins/tiddlywiki/highlight/index.html</a>" > $TW5_BUILD_OUTPUT/highlightdemo.html
echo "<a href='./plugins/tiddlywiki/markdown/index.html'>Moved to http://tiddlywiki.com/plugins/tiddlywiki/markdown/index.html</a>" > $TW5_BUILD_OUTPUT/markdowndemo.html
echo "<a href='./plugins/tiddlywiki/tahoelafs/index.html'>Moved to http://tiddlywiki.com/plugins/tiddlywiki/tahoelafs/index.html</a>" > $TW5_BUILD_OUTPUT/tahoelafs.html

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

# /upgrade.html				Custom edition for performing upgrades
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/upgrade \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--build upgrade \
	|| exit 1

# /encrypted.html			Copy of the main file encrypted with the password "password"
node $TW5_BUILD_TIDDLYWIKI \
	$TW5_BUILD_MAIN_EDITION \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--build encrypted \
	|| exit 1


######################################################
#
# Editions
#
######################################################

# /editions/translators/index.html	Translators edition
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/translators \
	--verbose \
	--output $TW5_BUILD_OUTPUT/editions/translators/ \
	--build index \
	|| exit 1

# /editions/introduction/index.html	Introduction edition
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/introduction \
	--verbose \
	--output $TW5_BUILD_OUTPUT/editions/introduction/ \
	--build index \
	|| exit 1

######################################################
#
# Plugin demos
#
######################################################

# /plugins/tiddlywiki/katex/index.html	Demo wiki with KaTeX plugin
# /plugins/tiddlywiki/katex/empty.html	Empty wiki with KaTeX plugin

# TODO: Build the static file with the release of 5.1.3
#	--rendertiddler $:/core/templates/static.template.html plugins/tiddlywiki/katex/static.html text/plain \

node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/katexdemo \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/katex/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/katex/empty.html text/plain \
	|| exit 1

# /plugins/tiddlywiki/tahoelafs/index.html	Demo wiki with Tahoe-LAFS plugin
# /plugins/tiddlywiki/tahoelafs/empty.html	Empty wiki with Tahoe-LAFS plugin
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/tahoelafs \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/tahoelafs/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/tahoelafs/empty.html text/plain \
	|| exit 1

# /plugins/tiddlywiki/d3/index.html	Demo wiki with D3 plugin
# /plugins/tiddlywiki/d3/empty.html	Empty wiki with D3 plugin
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/d3demo \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/d3/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/d3/empty.html text/plain \
	|| exit 1

# /plugins/tiddlywiki/codemirror/index.html	Demo wiki with codemirror plugin
# /plugins/tiddlywiki/codemirror/empty.html	Empty wiki with codemirror plugin
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/codemirrordemo \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/codemirror/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/codemirror/empty.html text/plain \
	|| exit 1

# /plugins/tiddlywiki/markdown/index.html		Demo wiki with Markdown plugin
# /plugins/tiddlywiki/markdown/empty.html		Empty wiki with Markdown plugin
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/markdowndemo \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/markdown/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/markdown/empty.html text/plain \
	|| exit 1

# /plugins/tiddlywiki/tw2parser/index.html		Demo wiki with tw2parser plugin
# /plugins/tiddlywiki/tw2parser/empty.html		Empty wiki with tw2parser plugin
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/classicparserdemo \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/tw2parser/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/tw2parser/empty.html text/plain \
	|| exit 1

# /plugins/tiddlywiki/highlight/index.html		Demo wiki with highlight plugin
# /plugins/tiddlywiki/highlight/empty.html		Empty wiki with highlight plugin
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/highlightdemo \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/highlight/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/highlight/empty.html text/plain \
	|| exit 1

######################################################
#
# Language editions
#
######################################################

../build.jermolene.github.io/languages-bld.sh

######################################################
#
# Tests
#
######################################################

# /test.html			Wiki for running tests in browser
# Also runs the serverside tests
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/test \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all test.html text/plain \
	|| exit 1
