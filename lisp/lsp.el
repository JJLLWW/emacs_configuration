;; ATTEMPT TO GET LANGUAGE SERVER PROTOCOL CLIENT SET UP

;; needs a system clangd, which itself requires clang and libtool

(straight-use-package 'lsp-mode)

(defun jw-lsp-if-small-file ()
  (let*
    (
    (limit 5000)
    (limit-str (number-to-string limit))
    (num-lines (count-lines (point-min) (point-max)))
    (big-file-prompt (concat "JW-LSP: File " limit-str "+ lines, run clangd?"))
    )
    (if (<= num-lines limit)
      (lsp)
      (if (y-or-n-p big-file-prompt)
        (progn (message "Running clangd.") (lsp))
      )
    )
  )
)

(add-hook 'c-mode-hook 'jw-lsp-if-small-file)
