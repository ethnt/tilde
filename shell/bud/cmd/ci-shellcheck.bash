#!/usr/bin/env bash

shopt -s globstar

shellcheck $(fd --glob "*.bash")
