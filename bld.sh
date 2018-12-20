#!/bin/bash

# Build all tiddlywiki.com assets

# Default to the current version number for building the plugin library

if [  -z "$TW5_BUILD_VERSION" ]; then
    TW5_BUILD_VERSION=v5.1.19
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
# /static.html			Static rendering of default tiddlers
# /alltiddlers.html		Static rendering of all tiddlers
# /static/*				Static single tiddlers
# /static/static.css	Static stylesheet
# /static/favicon.ico	Favicon for static pages
node $TW5_BUILD_TIDDLYWIKI \
	$TW5_BUILD_MAIN_EDITION \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--build favicon static index \
	|| exit 1

# /empty.html			Empty
# /empty.hta			For Internet Explorer
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/empty \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--build empty \
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

# /editions/xlsx-utils/index.html	xlsx-utils edition
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/xlsx-utils \
	--verbose \
	--output $TW5_BUILD_OUTPUT/editions/xlsx-utils/ \
	--build index \
	|| exit 1

# /editions/resumebuilder/index.html	Resume builder edition
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/resumebuilder \
	--verbose \
	--output $TW5_BUILD_OUTPUT/editions/resumebuilder/ \
	--build index \
	|| exit 1

# /editions/text-slicer/index.html	Text slicer edition
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/text-slicer \
	--verbose \
	--output $TW5_BUILD_OUTPUT/editions/text-slicer/ \
	--build index \
	|| exit 1

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

# /editions/full/index.html	Full edition
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/full \
	--verbose \
	--output $TW5_BUILD_OUTPUT/editions/full/ \
	--build index \
	|| exit 1

# /editions/tw5.com-docs/index.html	tiddlywiki.com docs edition
node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/tw5.com-docs \
	--verbose \
	--output $TW5_BUILD_OUTPUT/editions/tw5.com-docs/ \
	--build index \
	|| exit 1

######################################################
#
# Plugin demos
#
######################################################

# /plugins/tiddlywiki/dynaview/index.html	Demo wiki with DynaView plugin
# /plugins/tiddlywiki/dynaview/empty.html	Empty wiki with DynaView plugin

node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/dynaviewdemo \
	--verbose \
	--output $TW5_BUILD_OUTPUT \
	--rendertiddler $:/core/save/all plugins/tiddlywiki/dynaview/index.html text/plain \
	--rendertiddler $:/core/save/empty plugins/tiddlywiki/dynaview/empty.html text/plain \
	|| exit 1

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

# Delete any existing static content

rm $TW5_BUILD_OUTPUT/languages/de-AT/static/*
rm $TW5_BUILD_OUTPUT/languages/de-DE/static/*
rm $TW5_BUILD_OUTPUT/languages/es-ES/static/*
rm $TW5_BUILD_OUTPUT/languages/fr-FR/static/*
rm $TW5_BUILD_OUTPUT/languages/ja-JP/static/*
rm $TW5_BUILD_OUTPUT/languages/ko-KR/static/*
rm $TW5_BUILD_OUTPUT/languages/zh-Hans/static/*
rm $TW5_BUILD_OUTPUT/languages/zh-Hant/static/*

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

######################################################
#
# Plugin library
#
######################################################

node $TW5_BUILD_TIDDLYWIKI \
	../TiddlyWiki5/editions/pluginlibrary \
	--verbose \
	--output $TW5_BUILD_OUTPUT/library/$TW5_BUILD_VERSION \
	--build \
	|| exit 1

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
