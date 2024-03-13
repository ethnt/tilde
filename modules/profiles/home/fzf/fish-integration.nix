{ pkgs, ... }: {
  programs.fish = {
    interactiveShellInit = ''
      fzf_configure_bindings

      set fzf_complete_opts --cycle --reverse --height=50%
    '';

    plugins = [{
      name = "fzf";
      # https://github.com/PatrickF1/fzf.fish/pull/293
      src = pkgs.fetchFromGitHub {
        owner = "oddlama";
        repo = "fzf.fish";
        rev = "6331eedaf680323dd5a2e2f7fba37a1bc89d6564";
        sha256 = "sha256-BO+KFvHdbBz7SRA6EuOk2dEC8zORsCH9V04dHhJ6gxw=";
      };
    }];

    # interactiveShellInit = ''
    #   set -U fifc_fd_opts --color=never
    # '';

    # plugins = [{
    #   name = "fifc";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "gazorby";
    #     repo = "fifc";
    #     rev = "2ee5beec7dfd28101026357633616a211fe240ae";
    #     sha256 = "sha256-Nrart7WAh2VQhsDDe0EFI59TqvBO56US2MraqencxgE=";
    #   };
    # }];
  };
}
