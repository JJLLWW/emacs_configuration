;; ATTEMPT TO GET LANGUAGE SERVER PROTOCOL CLIENT SET UP

;; needs a system clangd, which itself requires clang and libtool

(straight-use-package 'lsp-mode)

;; nil => not in hook 
(defvar lsp-c-hook nil)

(defun jw-toggle-lsp-c-hook () (interactive)
  (if (eq lsp-c-hook nil) 
    (progn (add-hook 'c-mode-hook 'lsp) (setq lsp-c-hook t) (message "lsp-enabled")) 
    (progn (remove-hook 'c-mode-hook 'lsp) (setq lsp-c-hook nil) (message "lsp-disabled"))
  )
)

;; (add-hook 'c-mode-hook 'lsp)
