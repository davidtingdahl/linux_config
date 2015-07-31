(global-set-key (kbd "<f1>") 'compile)

(set-background-color "black")
(set-foreground-color "white")

;; Move between windows (as opened with C-x 2, C-x 3)
(global-set-key [M-left] 'windmove-left)   ; move to left windnow
(global-set-key [M-right] 'windmove-right) ; move to right window
(global-set-key [M-up] 'windmove-up)       ; move to upper window
(global-set-key [M-down] 'windmove-down)   ; move to downer window

;; Customizations of various modes
(global-auto-revert-mode 1)

;; Indentation using spaces
(setq-default indent-tabs-mode nil)
