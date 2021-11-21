;; dap mode 
;; !!!  pip install "ptvsd>=4.2" !!!

(straight-use-package 'dap-mode)
(require 'dap-python)

;; set default debug template to "Python :: Run file (buffer)" ???
(dap-register-debug-template "JWPython"
                             (list :type "python"
                                   :args ""
                                   :cwd nil
                                   :module nil
                                   :program nil
                                   :request "launch"
                                   :name "JWPython"))

;; (dap-auto-configure-mode)

;; vscode-like keybindingbs
(global-set-key (kbd "C-d") 'dap-debug)
(global-set-key (kbd "C-b") 'dap-breakpoint-toggle)
(global-set-key (kbd "<f5>") 'dap-continue)
(global-set-key (kbd "<f10>") 'dap-next)
(global-set-key (kbd "<f11>") 'dap-step-in)
(global-set-key (kbd "<escape>") 'dap-disconnect)

;; dap-disconnect exits the debugging session
