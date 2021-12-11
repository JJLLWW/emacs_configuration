;; toggle-frame-fullscreen

(straight-use-package 'powershell-mode)
(require 'powershell-mode)
;; (lsp-install-server pwsh-ls)
(add-hook 'powershell-mode-hook 'lsp-deferred)

;; auto start powershell-mode on .ps1 files
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
