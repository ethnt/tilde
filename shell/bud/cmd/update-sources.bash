#!/usr/bin/env bash

# https://github.com/berberman/nvfetcher/pull/30#discussion_r723792876
# https://github.com/msteen/nix-prefetch/issues/28
export TMPDIR=/tmp

nvfetcher -c "$FLAKEROOT/pkgs/vscode/sources.toml" -o "$FLAKEROOT/pkgs/vscode/_sources"
