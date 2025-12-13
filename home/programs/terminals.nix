{ vars, ... }:

{
  # Ghostty configuration
  xdg.configFile."ghostty/config".text = ''
    window-decoration = true
    theme = Catppuccin Mocha
    background-opacity = ${toString vars.terminal.opacity}
    font-size = ${toString vars.theme.font.size}
    font-thicken = true
    font-family = ${vars.theme.font.family}
    mouse-hide-while-typing = true
    macos-option-as-alt = true
    keybind = super+t=ignore
    keybind = shift+enter=text:\n
    custom-shader = shaders/cursor_mauve.glsl
  '';

  # Ghostty shader
  xdg.configFile."ghostty/shaders".source = ../../.config/ghostty/shaders;

  # Kitty configuration (symlink existing config)
  xdg.configFile."kitty/kitty.conf".source = ../../.config/kitty/kitty.conf;
}
