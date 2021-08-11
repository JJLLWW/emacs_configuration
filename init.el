;; basic usability
(fset 'yes-or-no-p 'y-or-n-p)  ;; Ask for y/n instead of yes/no
(setq confirm-kill-processes nil)
(desktop-save-mode 1)
(setq inhibit-startup-message t)
(load-theme 'wombat)
(global-linum-mode t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq make-backup-files nil)
(define-coding-system-alias 'UTF-8 'utf-8)

;; don't have the cursor blink in any buffer
(setq blink-cursor-mode nil)

;; default text size + resizing text
(set-face-attribute 'default nil :height 100)
(global-set-key (kbd "C--") (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "C-+") (lambda () (interactive) (text-scale-increase 1)))

;; don't ask to kill shells
(defun set-no-process-query-on-exit ()
 (let ((proc (get-buffer-process (current-buffer))))
   (when (processp proc)
     (set-process-query-on-exit-flag proc nil))))

(add-hook 'term-exec-hook 'set-no-process-query-on-exit)
(add-hook 'shell-mode-hook 'set-no-process-query-on-exit)

;; shell creation
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

;; switching windows
(when (fboundp 'windmove-default-keybindings)
	  (windmove-default-keybindings))

;; resizing windows
(global-set-key (kbd "C-h") 'shrink-window-horizontally)
(global-set-key (kbd "C-l") 'enlarge-window-horizontally)
(global-set-key (kbd "C-i") 'enlarge-window)

(global-set-key (kbd "C-u") 'shrink-window)
