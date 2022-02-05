(straight-use-package 'cmake-mode)

; cmake autocompletion
(add-hook 'cmake-mode-hook 'company-mode)
;; (add-hook 'cmake-mode-hook 'company-cmake)

; cmake language server
; NEEDS pip install cmake-language-server
(add-hook 'cmake-mode-hook 'lsp-mode)

; can you get usage hints as well?
