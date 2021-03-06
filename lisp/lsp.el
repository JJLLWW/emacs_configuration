;; ATTEMPT TO GET LANGUAGE SERVER PROTOCOL CLIENT SET UP

;; needs a system clangd, which itself requires clang and libtool

;; Hide warning "LSP :: Yasnippet is not installed, but `lsp-enable-snippet' is set to `t'."
(setq lsp-enable-snippet nil)

;; disable the annoying top bar
(setq lsp-headerline-breadcrumb-enable nil)

;; flymake causes errors when loading a saved desktop "error in process sentinel: flymake-error ..."
(straight-use-package 'flycheck)
;; autocompletion frontend
(straight-use-package 'company)
(straight-use-package 'company-lsp)
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

;; lsp python mumbo jumbo
(straight-use-package 'lsp-pyright)

;; hackery to avoid other bugs
(setq lsp-enable-file-watchers nil)
;; (defun jw-py-lsp () (interactive) (require 'lsp-pyright) (lsp))
(add-hook 'python-mode-hook (lambda () (require 'lsp-pyright) (lsp)))

;; python virtual environment (pip3 install virtualenv)
(straight-use-package 'pyvenv)

;; dap mode 
;; pip install "ptvsd>=4.2"

(if (eq system-type 'windows-nt) (load (concat user-emacs-directory "lisp/powershell-lsp.el")))

;; lsp-ui
(straight-use-package 'lsp-ui)
(require 'lsp-ui)
(lsp-ui-doc-enable t)
; no mouse required
(setq lsp-ui-doc-show-with-cursor t)

;; ;; better autocompletion in lsp buffers
;; (straight-use-package 'helm-lsp)
;; (straight-use-package 'helm-xref)
;; (require 'helm-xref)
;; (define-key global-map [remap find-file] #'helm-find-files)

; better M-x autocompletion
(straight-use-package 'helm)
(require 'helm)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
