(add-to-list 'load-path "~/linux_config/")

;; Compile shortcut
(global-set-key (kbd "<f1>") 'compile)
;;(setq compile-command "zdocker-exec make -j5 -k")
(setq compile-command "make-vo v3d-run-odometry v3d-core-visualizer -j5")
(setq compilation-scroll-output 'first-error)

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
(global-set-key (kbd "s-a") 'windmove-left)   ; move to left windnow
(global-set-key (kbd "s-d") 'windmove-right) ; move to right window
(global-set-key (kbd "s-w") 'windmove-up)       ; move to upper window
(global-set-key (kbd "s-s") 'windmove-down)   ; move to downer window
;; (global-set-key [s-left] 'windmove-left)   ; move to left windnow
;; (global-set-key [s-right] 'windmove-right) ; move to right window
;; (global-set-key [s-up] 'windmove-up)       ; move to upper window
;; (global-set-key [s-down] 'windmove-down)   ; move to downer window

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

;; Dockerfile mode
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; Make emacs pick up PATH and other stuff from bashrc
(setq shell-command-switch "-ic")

;; Tags
(defun update-tags ()
  "Update TAGS"
  (interactive)
  (shell-command "update_tags.sh")
  (visit-tags-table "/tmp/TAGS")
)
(global-set-key (kbd "<f3>") 'update-tags)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)


;; set up package sources
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
'("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

;; small interface tweaks
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)

;; bring up help for key bindings
(use-package which-key
:ensure t
:config
(which-key-mode))

;; Auto completion
(use-package auto-complete
:ensure t
:init
(progn
(ac-config-default)
(global-auto-complete-mode t)
))

;; on the fly syntax checking
(use-package flycheck
:ensure t
:init

(global-flycheck-mode t))

(setq flycheck-checker-error-threshold 10000)
(setq flycheck-gcc-args (list
                         "-O0"
                         "-DEIGEN_DONT_PARALLELIZE"
                        ;; "-nostdinc" "-nostdinc++"
                         "-Wall" "-Wextra" "-Wshadow" "-pedantic" "-fPIC" "-std=c++14" "-lm"))

(setq flycheck-gcc-include-path (list
                                 "/home/davtin/develop/vision_3dreconstruction/build/generated"
                                 "/home/davtin/develop/vision_3dreconstruction/core/src"
                                 "/home/davtin/develop/vision_3dreconstruction/core/src/external"
                                 "/home/davtin/develop/vision_3dreconstruction/common/include"
                                 "/home/davtin/develop/dockerenv/usr/local/include"
                                 "/home/davtin/develop/dockerenv/usr/local/include/opencv4"
                                 "/home/davtin/develop/dockerenv/usr/include"
                                 "/home/davtin/develop/dockerenv/usr/local/include/eigen3"
                                 ;; "/home/davtin/develop/dockerenv/usr/include/c++/5"
                                 ;; "/home/davtin/develop/dockerenv/usr/include/c++/5"
                                 ;; "/home/davtin/develop/dockerenv/usr/include/c++/5/tr1"
                                 ;; "/home/davtin/develop/dockerenv/usr/include/linux"
                                 "/home/davtin/develop/dockerenv/usr/include/x86_64-linux-gnu"
                                 ;; "/home/davtin/develop/dockerenv/usr/include/x86_64-linux-gnu/c++/5"
                                 ;; "/home/davtin/develop/dockerenv/usr/lib/gcc/x86_64-linux-gnu/5/include"
                                 ))
(require 'clang-format)
(add-hook
     'c++-mode-hook
      (lambda ()
      (local-set-key (kbd "<tab>") #'clang-format-region)))
;; (define-key c++-mode (kbd "<tab>") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)

;; snippets and snippet expansion
(use-package yasnippet
:ensure t
:init
(yas-global-mode 1))

;; Theme
(use-package color-theme
:ensure t)
(use-package moe-theme
:ensure t)
(moe-dark)
