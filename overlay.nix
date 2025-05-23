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
		(use-package rust-mode
			:mode (("\\.rs\\'" . rust-mode))
			:hook
				(rust-mode . eglot-ensure)
			:config
				(add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer"))))
		(use-package company
      :bind (("C-M-i" . 'company-complete)
	    :map company-active-map
	      ("M-n" . 'company-select-next)
	      ("M-p" . 'company-select-previous)
	      ("M-y" . 'company-complete-selection)
	    :map company-search-map
	      ("M-n" . 'company-select-next)
	      ("M-p" . 'company-select-previous)
	      ("M-y" . 'company-complete-selection))
      :config
        (global-company-mode)
        (setq company-idle-delay 0)
        (setq company-minimum-prefix-length 2)
        (setq company-selection-wrap-around t)
        (setq company-show-numbers t)
        (setq company-frontends '(company-preview-frontend company-pseudo-tooltip-frontend))
        (setq company-format-margin-function 'company-vscode-dark-icons-margin))
  '';
  emacsForLec = prev.emacs-nox.pkgs.withPackages (epkgs: (with epkgs.melpaStablePackages; [
    (prev.runCommand "default.el" {} ''
      mkdir -p $out/share/emacs/site-lisp
      cp ${final.emacsForLecConfig} $out/share/emacs/site-lisp/default.el
    '')
    catppuccin-theme
    rainbow-delimiters
    epkgs.ddskk
    rust-mode
    epkgs.ob-rust
    epkgs.eglot
		company
  ]));
}
