(add-to-list 'load-path "~/linux_config/")


;; Compile shortcut
(global-set-key (kbd "<f1>") 'compile)

;; IPython macro
(fset 'ipython
   [?i ?m ?p ?o ?r ?t ?  ?I ?P ?y ?t ?h ?o ?n return ?I ?P ?y ?t ?h ?o ?n ?. ?e ?m ?b ?e ?d ?\( ?\) return ?e ?x ?i ?t ?\( ?1 ?\) return])
(global-set-key (kbd "<f2>") 'ipython)

;; No splash screen
(setq inhibit-splash-screen t)

;; Setup colours
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

(setq-default show-trailing-whitespace t)

;; Whitespace display
(progn
 ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://ergoemacs.org/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [182 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq-default c-basic-offset 4)
(require 'google-c-style)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" . c++-mode))
(add-hook 'c-mode-common-hook 'google-set-c-style)

(setq-default c-basic-offset 4)
(setq c-block-comment-prefix "* ")
;; Skip warnings
(setq compilation-skip-threshold 2)
