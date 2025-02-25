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
    (require 'eglot)
    (add-hook 'rust-mode-hook 'eglot-ensure)
    (autoload 'rust-mode "rust-mode" nil t)
    (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  '';
  emacsForLec = prev.emacs-nox.pkgs.withPackages (epkgs: (with epkgs.melpaStablePackages; [
    (prev.runCommand "default.el" {} ''
      mkdir -p $out/share/emacs/site-lisp
      cp ${final.emacsForLecConfig} $out/share/emacs/site-lisp/default.el
    '')
    catppuccin-theme
    rainbow-delimiters
    ddskk
    rust-mode
    epkgs.ob-rust
    epkgs.eglot
  ]));
}
