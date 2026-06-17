{pkgs, ...}: {
  config.vim = {
    extraPackages = with pkgs; [
      ripgrep
      tmux
      nodejs
    ];
  };
}
