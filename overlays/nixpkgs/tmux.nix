final: prev: {
  oh-my-tmux = prev.lib.inputs.oh-my-tmux;

  tmux-darwin =
    prev.runCommand prev.tmux.name { buildInputs = [ prev.makeWrapper ]; } ''
      source $stdenv/setup
      mkdir -p $out/bin
      makeWrapper ${prev.tmux}/bin/tmux $out/bin/tmux \
        --set __ETC_BASHRC_SOURCED "" \
        --set __ETC_ZPROFILE_SOURCED  "" \
        --set __ETC_ZSHENV_SOURCED "" \
        --set __ETC_ZSHRC_SOURCED "" \
        --set __NIX_DARWIN_SET_ENVIRONMENT_DONE ""
    '';
}
