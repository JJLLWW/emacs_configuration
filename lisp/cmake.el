(straight-use-package 'cmake-mode)

; cmake autocompletion
(add-hook 'cmake-mode-hook 'company-cmake)
