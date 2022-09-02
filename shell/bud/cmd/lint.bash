#!/usr/bin/env bash

shopt -s globstar

statix check .
dhall format --check ./**/*.dhall
