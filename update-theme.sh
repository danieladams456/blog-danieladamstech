#!/bin/bash
set -eu

# https://github.com/adityatelange/hugo-PaperMod/wiki/Installation
# init when cloning repo if submodule doesn't get cloned automatically
git submodule update --init --recursive

# pull new
git submodule update --remote --merge
