final: prev: {
  emacsForLecConfig = prev.writeText "default.el" ''
    (load-theme 'catppuccin :no-confirm)
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
    (org-babel-do-load-languages
      'org-babel-load-languages
      '(
        (rust .t)
      )
    )
  '';
  emacsForLec = prev.emacs-nox.pkgs.withPackages (epkgs: (with epkgs.melpaStablePackages; [
    (prev.runCommand "default.el" {} ''
      mkdir -p $out/share/emacs/site-lisp
      cp ${final.emacsForLecConfig} $out/share/emacs/site-lisp/default.el
    '')
    catppuccin-theme
    rainbow-delimiters
    ddskk
    epkgs.ob-rust
  ]));
}
