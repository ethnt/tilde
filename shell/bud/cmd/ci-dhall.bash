#!/usr/bin/env bash

shopt -s globstar

dhall format --check ./**/*.dhall
