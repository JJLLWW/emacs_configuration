; company elisp autocompletion
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'lisp-mode-hook 'company-elisp)

; distinguishable parantheses
(straight-use-package 'rainbow-delimiters)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
