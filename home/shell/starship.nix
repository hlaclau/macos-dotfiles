{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      palette = "catppuccin_mocha";

      # First line: Info & Status
      username = {
        format = " [╭─$user]($style)@";
        style_user = "bold lavender";
        style_root = "bold lavender";
        show_always = true;
      };

      hostname = {
        format = "[$hostname]($style) in ";
        style = "bold dimmed lavender";
        trim_at = "-";
        ssh_only = false;
        disabled = false;
      };

      directory = {
        style = "mauve";
        truncation_length = 0;
        truncate_to_repo = true;
        truncation_symbol = "repo: ";
      };

      git_status = {
        style = "text";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
        deleted = "x";
      };

      cmd_duration = {
        min_time = 1;
        format = "took [$duration]($style)";
        disabled = false;
      };

      # Second line: Prompt
      battery = {
        full_symbol = " ";
        charging_symbol = " ";
        discharging_symbol = " ";
        disabled = true;
      };

      time = {
        format = " 🕙 $time($style)\n";
        time_format = "%T";
        style = "text";
        disabled = true;
      };

      character = {
        success_symbol = " [╰─λ](mauve)";
        error_symbol = " [×](red)";
      };

      status = {
        symbol = "🔴";
        format = "[\\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\\]]($style)";
        map_symbol = true;
        disabled = false;
      };

      # Language/tool symbols
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      haskell.symbol = "λ ";
      memory_usage.symbol = " ";
      nim.symbol = " ";
      nix_shell.symbol = " ";
      package.symbol = " ";
      perl.symbol = " ";
      php.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      shlvl.symbol = " ";
      swift.symbol = "ﯣ ";

      docker_context = {
        symbol = " ";
        format = "via [$symbol$context]($style) ";
        style = "blue bold";
        only_with_files = true;
        detect_files = [ "docker-compose.yml" "docker-compose.yaml" "Dockerfile" ];
        detect_folders = [ ];
        disabled = false;
      };

      git_branch = {
        symbol = " ";
        style = "bold mauve";
      };

      golang.symbol = " ";

      python = {
        symbol = " ";
        format = "via [\${symbol}python (\${version} )(\\($virtualenv\\) )]($style)";
        style = "bold yellow";
        pyenv_prefix = "venv ";
        python_binary = [ "./venv/bin/python" "python" "python3" "python2" ];
        detect_extensions = [ "py" ];
        version_format = "v\${raw}";
      };

      nodejs = {
        format = "via [ Node.js $version](bold green) ";
        detect_files = [ "package.json" ".node-version" ];
        detect_folders = [ "node_modules" ];
      };

      # Catppuccin Mocha palette
      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };
}
