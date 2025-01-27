final: prev: {
  emacsForLec = pkgs.emacs-nox.override {
    melpaPackages = [ catppuccin-theme ];
  };
}
