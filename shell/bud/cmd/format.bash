#!/usr/bin/env bash

shopt -s globstar

nix fmt **/*.nix -- --check
