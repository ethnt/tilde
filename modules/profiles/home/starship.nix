{ pkgs, inputs, ... }: {
  home.packages = [ inputs.starship-jj.packages.${pkgs.system}.starship-jj ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      character.success_symbol = "[➜](bold green)";

      # custom = {
      #   jj = {
      #     command = ''
      #       jj log -r@ -n1 --ignore-working-copy --no-graph --color always  -T '
      #         separate(" ",
      #           bookmarks.map(|x| truncate_end(10, x.name(), "…")).join(" "),
      #           tags.map(|x| truncate_end(10, x.name(), "…")).join(" "),
      #           surround("\"", "\"", truncate_end(24, description.first_line(), "…")),f
      #           if(conflict, "conflict"),
      #           if(divergent, "divergent"),
      #           if(hidden, "hidden"),
      #         )
      #       '
      #     '';
      #     when = "jj root";
      #     symbol = "jj ";
      #   };

      #   jjstate = {
      #     command = ''
      #       jj log -r@ -n1 --no-graph -T "" --stat | tail -n1 | sd "(\d+) files? changed, (\d+) insertions?\(\+\), (\d+) deletions?\(-\)" ' ''${1}m ''${2}+ ''${3}-' | sd " 0." ""
      #     '';
      #     when = "jj root";
      #   };
      # };
    };
  };
}
