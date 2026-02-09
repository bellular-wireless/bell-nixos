{
  programs.git = {
    enable = true;
    settings.user.email = "bell.dixon@proton.me";
    settings.user.name = "Bell Dixon";
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
