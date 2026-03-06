{ pkgs, ... }: {
  home.packages = with pkgs; [ jj-starship ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = ''
        $username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$custom$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$hg_state$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$fortran$gleam$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$quarto$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$typst$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$nats$direnv$env_var$mise$crystal$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$netns$shell$character
      '';
      # format = ''
      #   ([\[](fg:8)$package$rust$username$hostname$cmd_duration$jobs[\]](fg:8))
      #   $directory([\[](fg:8)''${custom.jj}[\]](fg:8))$fill$status$time
      #   $character
      # '';
      character.success_symbol = "[➜](bold green)";
      custom.jj = {
        when = "jj-starship detect";
        shell = [ "jj-starship" ];
        format = "$output ";
      };
      git_branch.disabled = true;
      git_status.disabled = true;
      nix_shell.symbol = "❄️ ";
    };
  };
}
