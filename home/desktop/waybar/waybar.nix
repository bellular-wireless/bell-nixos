{...}: let
  clockModule = {
    format = "{:%I:%M %p}";
    tooltip-format = "{:%m/%d/%Y}";
  };
  memoryModule = {
    interval = 30;
    format = "  {used:0.1f}G";
  };

  cpuModule = {
    "format" = " {usage}%";
  };
in {
  home.file = {
    ".config/waybar/rose-pine.css".source = ./rose-pine.css;
  };
  programs.waybar = {
    enable = true;
    style = ./styles.css;
    settings = {
      secondaryBar = {
        layer = "top";
        name = "secondary";
        position = "bottom";
        height = 30;
        spacing = 5;
        output = [
          "HDMI-A-1"
          "DP-2"
        ];
        modules-right = ["memory#secondary" "cpu#secondary" "clock#secondary"];
        "clock#secondary" = clockModule;
        "cpu#secondary" = cpuModule;
        "memory#secondary" = memoryModule;
      };

      mainBar = {
        layer = "top";
        name = "main";
        position = "top";
        height = 30;
        spacing = 5;
        output = [
          "DP-3"
        ];
        modules-left = ["hyprland/workspaces" "memory" "cpu"];
        modules-center = ["hyprland/window"];
        modules-right = ["wireplumber" "network" "bluetooth" "tray" "clock"];

        "hyprland/workspaces" = {
          format = "<span size='larger'>{icon}</span>";
          on-click = "activate";
          format-icons = {
            active = "";
            default = "";
          };
          icon-size = 10;
          sort-by-number = true;
          all-outputs = true;
        };

        "cpu" = cpuModule;

        "clock" = clockModule;

        "wireplumber" = {
          format = "󰕾 {volume}%";
          max-volume = 100;
          scroll-step = 5;
          on-click = "pavucontrol";
        };

        "memory" = memoryModule;

        "temperature" = {
          format = "  {temperatureC}°C";
        };

        "network" = {
          format = "";
          format-ethernet = "󰈁";
          format-wifi = "{icon}";
          format-disconnected = "";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
        };

        "bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "blueman-manager";
        };

        "hyprland/language" = {
          format = "{short}";
        };

        "tray" = {
          icon-size = 16;
          spacing = 16;
        };
      };
    };
  };
}
