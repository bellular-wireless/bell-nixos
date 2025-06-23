{...}: let
  wallpaperPath = "/home/bell/Pictures/1748584587849458.jpg";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      # decoration = {
      #   shadow_offset = "0 5";
      #   "col.shadow" = "rgba(00000099)";
      # };

      "$mod" = "ALT";
      "$terminal" = "ghostty";
      "$browser" = "zen --browser";
      "$discord-client" = "dev.vencord.Vesktop";
      "$password-manager" = "bitwarden";
      "$launcher" = "rofi";
      "input:accel_profile" = "flat";

      animation = [
        "global, 1, 1, default"
      ];

      monitor = [
        "DP-3, preferred, 0x0, 1"
        "DP-2, preferred, 0x-1080, 1"
        "HDMI-A-1, preferred, -1080x0, 1, transform, 1"
      ];

      workspace = [
        "1, monitor:DP-3, default:true"
        "2, monitor:DP-3"
        "3, monitor:DP-3"
        "4, monitor:HDMI-A-1, default:true"
        "5, monitor:DP-2, default:true"
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
        "$mod, space, exec, rofi -show drun"
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
  };

  programs.rofi = {
    enable = true;
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
}
