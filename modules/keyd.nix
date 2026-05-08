{...}: {
  services.keyd = {
    enable = false;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          "control" = {
            "1" = "f1";
            "2" = "f2";
            "3" = "f3";
            "4" = "f4";
            "z" = "f5";
            "r" = "f6";
            "x" = "f7";
            "f" = "f8";
            "t" = "f9";
          };
        };
      };
    };
  };
}
