#!/usr/bin/env bash
set -e # halt script on error

# Travis will automatically install the dependencies based on the referenced gems (Gemfile).
bundle exec jekyll build        # build
#bundle exec htmlproofer ./_site # check
