; basic usability
(fset 'yes-or-no-p 'y-or-n-p)  ; Ask for y/n instead of yes/no
(setq confirm-kill-processes nil)
(desktop-save-mode 1) ; save the desktop
(setq inhibit-startup-message t) ; no splash screen
(load-theme 'wombat) ; theme that isn't painful to look at
(global-linum-mode t)
(menu-bar-mode -1) ; disable GUI elements
(toggle-scroll-bar -1) ; ...
(tool-bar-mode -1) ; ...
(setq make-backup-files nil) ; don't make backup files
(define-coding-system-alias 'UTF-8 'utf-8)

; always highlight matching parantheses
(show-paren-mode t)

; disable 'electric-indent-mode' globally, as it  makes \n remove all leading
; whitespace on the last line. Also messes up comments in elisp
(electric-indent-mode -1)

; always use spaces instead of tabs for indentation (setq-default sets buffer local value globally)
(setq-default indent-tabs-mode nil)

; number of spaces to replace tabs with
(setq-default tab-width 4)

; let tab behave as normal if 
(setq tab-always-indent t)

; () autocompletion in elisp mode
(add-hook 'emacs-lisp-mode-hook 'electric-pair-local-mode)

;; (defun (jw-indent) (interactive) 
;;   (let ((cur_line (thing-at-point 'line t)))
;;     (progn
;;       ()
;;     )
;;   )
;; )

; have return match the indentation of the last line in all modes.
;; (defun jw-newline-match-indentation () (interactive)
;;     (let (()) 
;;     )
;; )

;; (global-set-key (kbd "RET") 'jw-newline-match-indentation)
;; (global-set-key (kbd "<C-return>") (lambda () (interactive) (progn (end-of-line) (jw-newline-match-indentation))))
; (global-set-key (kbd "RET") 'newline)

; don't have the cursor blink in any buffer
(setq blink-cursor-mode nil)

; default text size + resizing text
(set-face-attribute 'default nil :height 100)
(global-set-key (kbd "C--") (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "C-+") (lambda () (interactive) (text-scale-increase 1)))

; don't ask to kill shells
(defun set-no-process-query-on-exit ()
 (let ((proc (get-buffer-process (current-buffer))))
   (when (processp proc)
     (set-process-query-on-exit-flag proc nil))))

(add-hook 'term-exec-hook 'set-no-process-query-on-exit)
(add-hook 'shell-mode-hook 'set-no-process-query-on-exit)

; shell creation
(defun new-shell ()
  (interactive)

  (let (
        (currentbuf (get-buffer-window (current-buffer)))
        (newbuf     (generate-new-buffer-name "*shell*"))
       )

   (generate-new-buffer newbuf)
   (set-window-dedicated-p currentbuf nil)
   (set-window-buffer currentbuf newbuf)
   (shell newbuf)
  )
)

(defun select-line () (interactive) (progn (move-beginning-of-line nil)
                 (set-mark-command nil)
                 (move-end-of-line nil)
              )
       )

(global-set-key (kbd "<f9>") 'new-shell)
(global-set-key (kbd "M-9") 'select-line)

; switching windows
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

; resizing windows
(global-set-key (kbd "M-<right>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<down>") 'shrink-window)

; xref jump to definition
(global-set-key (kbd "M-.") 'xref-find-definitions)

; c-mode use google c style with 4 space default indentation.
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'google-c-style)
(add-hook 'c-mode-hook 'google-set-c-style)

; c-mode (, {, [, ', " auto-completion.
(add-hook 'c-mode-hook 'electric-pair-local-mode)

; straight setup mumbo-jumbo
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

; attempt to set up the lsp stuff
(load (concat user-emacs-directory "lisp/lsp.el"))
