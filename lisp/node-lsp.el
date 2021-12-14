(straight-use-package 'json-mode)
(straight-use-package 'typescript-mode)
(straight-use-package 'yasnippet)

;; use language server ts-ls (all others busted)
;; (lsp-install-server nil 'ts-ls)

(setq js-indent-level 2)
(add-hook 'json-mode-hook 'electric-pair-mode)
(add-hook 'js-mode-hook 'typescript-mode)
(add-hook 'typescript-mode-hook 'lsp)

;; mumbo jumbo to get xref to work with javascript
(with-eval-after-load 'js (define-key js-mode-map (kbd "M-.") nil))

;; disable yasnippet TAB autocompletion as messes up company
(yas-minor-mode)
(define-key yas-minor-mode-map (kbd "TAB") nil)
