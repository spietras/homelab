# Enable shells
{
  environment = {
    pathsToLink = [
      "/share/zsh"
    ];
  };

  programs = {
    zsh = {
      enable = true;
    };
  };
}
