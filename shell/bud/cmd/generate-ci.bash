#!/usr/bin/env bash

dhall-to-yaml \
  --file $FLAKEROOT/config/ci.dhall \
  --output $FLAKEROOT/.github/workflows/ci.yml
