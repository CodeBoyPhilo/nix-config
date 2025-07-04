{
  config,
  hostname,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  monitor = "HDMI-A-3";
  background = "/home/phil_oh/Pictures/wallpapers/A.png";
  stylix-colors = config.lib.stylix.colors;
  hex2rgb = inputs.nix-colors.lib.conversions.hexToRGBString;

in
{
  home.packages = with pkgs; [
    hyprlock
    hypridle
  ];

  programs = {
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 5;
          hide_cursor = true;
          immediate_render = true;
          no_fade_in = false;
          no_fade_out = false;
        };
        background = [
          {
            path = background;
            blur_passes = 3;
            blur_size = 12;
            color = ''rgb(${hex2rgb "," stylix-colors.base00})'';
          }
        ];
        image = [
          {
            # Avatar
            monitor = monitor;
            path = "$HOME/.face";
            border_size = 2;
						border_color = ''rgba(${hex2rgb "," stylix-colors.base07}, 0.7)'';
            size = 140;
            rounding = -1;
            rotate = 0;
            reload_time = -1;
            position = "0, 40";
            halign = "center";
            valign = "center";
          }
        ];
        label = [
          {
            # Date (1 hour)
            monitor = monitor;
            text = ''cmd[update:3600000] echo -e "$(date +"%a, %d %b")"'';
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 0.9)'';
            font_size = 25;
            font_family = "Maple Mono NF CN";
            position = "0, 440";
            halign = "center";
            valign = "center";
          }
          {
            # Weather (30min)
            monitor = monitor;
            text = ''cmd[update:1800000] ${lib.getExe pkgs.curl} -sLq "wttr.in?format=%c+%t"'';
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 0.9)'';
            font_size = 16;
            font_family = "Maple Mono NF CN";
            position = "0, 390";
            halign = "center";
            valign = "center";
          }
          {
            # Time Border left
            monitor = monitor;
            text = "$TIME";
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 0.9)'';
            font_size = 120;
            font_family = "Maple Mono NF CN";
            position = "-4, 250";
            halign = "center";
            valign = "center";
            zindex = 0;
          }
          {
            # Time Border right
            monitor = monitor;
            text = "$TIME";
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 0.9)'';
            font_size = 120;
            font_family = "Maple Mono NF CN";
            position = "4, 250";
            halign = "center";
            valign = "center";
            zindex = 0;
          }
          {
            # Time Border up
            monitor = monitor;
            text = "$TIME";
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 0.9)'';
            font_size = 120;
            font_family = "Maple Mono NF CN";
            position = "0, 246";
            halign = "center";
            valign = "center";
            zindex = 0;
          }
          {
            # Time Border down
            monitor = monitor;
            text = "$TIME";
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 0.9)'';
            font_size = 120;
            font_family = "Maple Mono NF CN";
            position = "0, 254";
            halign = "center";
            valign = "center";
            zindex = 0;
          }
          {
            # Time
            monitor = monitor;
            text = "$TIME";
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 0.9)'';
            font_size = 120;
            font_family = "Maple Mono NF CN";
            position = "0, 250";
            halign = "center";
            valign = "center";
            zindex = 1;
          }
          {
            # Username
            monitor = monitor;
            text = ''<span foreground="##${stylix-colors.base07}">󰝴</span> $DESC'';
            color = ''rgba(${hex2rgb "," stylix-colors.base05}, 1.0)'';
            font_size = 18;
            font_family = "Maple Mono NF CN";
            position = "0, -130";
            halign = "center";
            valign = "center";
          }
        ];
        # Username box
        shape = [
          {
            monitor = monitor;
            size = "420, 60";
            position = "0, -130";
            color = ''rgba(${hex2rgb "," stylix-colors.base01}, 1.0)'';
            rounding = 8;
            border_size = 2;
            border_color = ''rgba(${hex2rgb "," stylix-colors.base01}, 1.0)'';
            rotate = 0;
            xray = false; # do not make a "hole" in the background
            halign = "center";
            valign = "center";
          }
        ];
        # Password
        input-field = [
          {
            monitor = monitor;
            size = "420, 60";
            position = "0, -210";
            outline_thickness = 2;
            dots_size = 0.35;
            dots_spacing = 0.25;
            dots_center = true;
            fade_on_empty = false;
            placeholder_text = ''<span foreground="##${stylix-colors.base07}"><big>  󰌋  </big></span>'';
            fail_text = ''<span foreground="##${stylix-colors.base0E}">󰀧</span>  <i>$FAIL</i> <span foreground="##${stylix-colors.base0E}"><b>($ATTEMPTS)</b></span>'';
            fail_timeout = 3000; # milliseconds before fail_text and fail_color disappears
            fail_transition = 500; # transition time in ms between normal outer_color and fail_color
            hide_input = false;
            halign = "center";
            valign = "center";
            rounding = 8;
            outer_color = ''rgba(${hex2rgb "," stylix-colors.base07}, 1.0)'';
            inner_color = ''rgba(${hex2rgb "," stylix-colors.base01}, 1.0)'';
            font_color = ''rgba(${hex2rgb "," stylix-colors.base05}, 1.0)'';
            capslock_color = ''rgba(${hex2rgb "," stylix-colors.base0D}, 1.0)'';
            check_color = ''rgba(${hex2rgb "," stylix-colors.base09}, 1.0)'';
            fail_color = ''rgba(${hex2rgb "," stylix-colors.base0F}, 1.0)'';
          }
        ];
      };
    };
  };
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "${lib.getExe pkgs.hyprlock}";
          before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
        };
        listener = [
          {
            timeout = 3600;
            on-timeout = "${lib.getExe pkgs.hyprlock}";
          }
          {
            timeout = 5400;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        "$SUPER, l, exec, ${lib.getExe pkgs.hyprlock} --immediate"
      ];
    };
  };
}
