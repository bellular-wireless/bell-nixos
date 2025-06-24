{...}: let
  wallpaperPath = "/home/bell/Pictures/1748584587849458.jpg";
  font = "0xProto Nerd Font";
in {
  home.file = {
    ".config/hypr/xdph.conf".source = ./xdph.conf;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "ALT";
      "$terminal" = "ghostty";
      "$browser" = "zen --browser";
      "$discord-client" = "dev.vencord.Vesktop";
      "$password-manager" = "bitwarden";
      "$launcher" = "rofi";
      "input:accel_profile" = "flat";

      general = {
        "col.inactive_border" = "rgb(6e6a86)";
        "col.active_border" = "rgb(9ccfd8)";
      };

      decoration = {
        "shadow"."enabled" = false;
      };

      animation = [
        "global, 1, 1, default"
      ];

      monitor = [
        "DP-3, preferred, 0x0, 1"
        "DP-2, preferred, 0x-1080, 1"
        "HDMI-A-1, preferred, -1080x0, 1, transform, 1"
      ];

      windowrulev2 = [
        "float, class:(^org.pulseaudio.pavucontrol$)"
        "float, class:(^.blueman-manager-wrapped$)"
        "center, class:(^Rofi$)"
      ];

      workspace = [
        "1, monitor:DP-3, default:true, persistent:true"
        "2, monitor:DP-3, persistent:true"
        "3, monitor:DP-3, persistent:true"
        "4, monitor:HDMI-A-1, default:true, persistent:true"
        "5, monitor:DP-2, default:true, persistent:true"
      ];

      exec-once = [
        "hyprpaper &"
        "waybar &"
        "openrgb -p main"
        "xrandr --output DP-3 --primary"
        "hyprctl setcursor whiteSur-Cursor 20"
        "[workspace 1] $terminal"
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod, return, exec, $terminal"
        "$mod, l, exec, hyprlock"
        "$mod, q, killactive"
        "$mod, TAB, cyclenext"
        "$mod, space, exec, rofi -show-icons -show drun"
        "$mod, s, layoutmsg, togglesplit"
        "$mod, f, togglefloating"
        "$mod, PRINT, exec, hyprshot -m region -z --clipboard-only"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        "$mod+CTRL, 1, movetoworkspace, 1"
        "$mod+CTRL, 2, movetoworkspace, 2"
        "$mod+CTRL, 3, movetoworkspace, 3"
        "$mod+CTRL, 4, movetoworkspace, 4"
        "$mod+CTRL, 5, movetoworkspace, 5"

        # "$mod+CTRL+SHIFT, "
      ];

      dwindle = {
        preserve_split = true;
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        monitor = "";
        path = wallpaperPath;
        blur_passes = 2;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };

      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
      };

      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 1;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgb(9ccfd8)";
        inner_color = "rgb(191724)";
        font_color = "rgb(e0def4)";
        font_family = "${font}";
        fade_on_empty = true;
        fade_timeout = 0;
        rounding = 0;
        check_color = "rgb(204, 136, 34)";
        # placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
        placeholder_text = "";
        dots_text_format = "*";
        position = "0, -200";
        halign = "center";
        valign = "center";
      };

      label = [
        # Date
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "${font}";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "${font} Bold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  programs.rofi = {
    enable = true;
    theme = ./rofi_theme.rasi;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        wallpaperPath
      ];

      wallpaper = [
        "HDMI-A-1,${wallpaperPath}"
        "DP-2,${wallpaperPath}"
        "DP-3,${wallpaperPath}"
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "hyprlock";
        }
        {
          timeout = 750;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
