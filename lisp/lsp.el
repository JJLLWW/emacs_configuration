;; ATTEMPT TO GET LANGUAGE SERVER PROTOCOL CLIENT SET UP

;; needs a system clangd, which itself requires clang and libtool

;; Hide warning "LSP :: Yasnippet is not installed, but `lsp-enable-snippet' is set to `t'."
(setq lsp-enable-snippet nil)

;; flymake causes errors when loading a saved desktop "error in process sentinel: flymake-error ..."
(straight-use-package 'flycheck)

(straight-use-package 'cmake-mode)
(straight-use-package 'lsp-mode)

; we really want to bail out based on the time clangd takes to process the file
(defun jw-lsp-if-small-file ()
  (let*
    (
    (limit 6000)
    (limit-str (number-to-string limit))
    (num-lines (count-lines (point-min) (point-max)))
    (large-file-msg (concat "JW-LSP: File " limit-str "+ lines, no clangd"))
    )
    (if (<= num-lines limit)
      ;; this is significantly faster if many C files open
      (lsp-deferred)
      (message large-file-msg)
    )
  )
)

(add-hook 'c-mode-hook 'jw-lsp-if-small-file)
