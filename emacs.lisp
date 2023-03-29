;;
;; ******************** SETUP PATHS ********************
;;
(add-to-list 'load-path "~/linux_config/")
(setenv "PATH" (concat (getenv "PATH") ":/home/s0000413/linux_config/scripts"))
(setenv "PYTHONPATH"
        "/home/s0000413/develop/src:/home/s0000413/develop/src/vision/components/visual_odometry/toolbox/benchmarking/python/perf/")
(setq exec-path (append exec-path '("/home/s0000413/linux_config/scripts")))


;;
;; ******************** SETUP PACKAGE MANAGEMENT ********************
;;
(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(unless (package-installed-p 'use-package) 
  (package-refresh-contents) 
  (package-install 'use-package))


;;
;; ******************** INTERFACE ********************
;;
(setq-default inhibit-splash-screen t)    ;; Faster startup
(setq-default inhibit-startup-message t)  ;; Faster startup
(setq-default column-number-mode t)       ;; Show line numbers
(setq-default history-length 500)         ;; Longer history
(setq-default indent-tabs-mode nil)       ;; Indentation using spaces
(setq-default show-trailing-whitespace t) ;; show trailing ws

(tool-bar-mode -1)            ;; No toolbar below the menu bar
(fset 'yes-or-no-p 'y-or-n-p) ;; Use y/n instead of yes/no

;; Font
(custom-set-faces '(default ((t 
                              (:family "Ricty Diminished" 
                                       :foundry "PfEd" 
                                       :slant normal 
                                       :weight bold 
                                       :height 100 
                                       :width normal)))))
;; Theme
(use-package 
    moe-theme 
    :ensure t)
(moe-dark)

;; Customizations of various modes
(global-auto-revert-mode 1)
(global-linum-mode 1) ;; show line numbers

;; ANSI color in compilation buffer
(use-package 
    ansi-color 
    :ensure t)
(defun colorize-compilation-buffer () 
  (toggle-read-only) 
  (ansi-color-apply-on-region compilation-filter-start (point)) 
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Set colors based on current directory"
(defun set-local-colors () 
  (cond ((string-match-p "develop2/src" default-directory) 
         (face-remap-add-relative 'default 
                                  :background "black"))))


;;
;; ******************** KEY BINDINGS ********************
;;

;; Navigate between windows
(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)

;; Revert key
(global-set-key (kbd "<f5>") 'revert-buffer)

;; Compilation
(global-set-key (kbd "<f1>") 'projectile-compile-project)
(setq compilation-scroll-output 'first-error)
(setq compilation-skip-threshold 2) ;; skip warnings
(setq projectile-project-compilation-cmd "./bazel.py build")

;; Ubuntu-misc-checks
(defun ubuntu-misc-checks () 
  (interactive)
  ;; Switch to `*shell*'
  (shell)
  ;; Goto last prompt, clear old input if any, and insert new one
  (goto-char (point-max)) 
  (comint-kill-input) 
  (insert "cd ~/develop/src; src_config/jobs/ubuntu_misc_checks.py")
  ;; Execute
  (comint-send-input))
(global-set-key (kbd "<f6>") 'ubuntu-misc-checks)

;; Ipython macro
(fset 'ipython [?i ?m ?p ?o ?r ?t ?  ?I ?P ?y ?t ?h ?o ?n return ?I ?P ?y ?t ?h ?o ?n ?. ?e ?m ?b ?e
      ?d ?\( ?\) return ?e ?x ?i ?t ?\( ?1 ?\) return])
(global-set-key (kbd "<f2>") 'ipython)

;; Gerrit browse file
(defun src-master-gerrit-browse-file () 
  (interactive) 
  (setq repo_path (file-relative-name buffer-file-name (projectile-project-root))) 
  (setq url (concat "https://gerrit.cicd.autoheim.net/plugins/gitiles/src/+/refs/heads/master/"
                    repo_path)) 
  (browse-url url))


;;
;; ******************** SETUP PACKAGES ********************
;;

;; Helm
(use-package 
    helm 
    :ensure t 
    :init (setq helm-ff-lynx-style-map nil) ;; no arrow keys in helm-find-files
    :config (helm-mode 1) 
    (global-set-key (kbd "M-x") 'helm-M-x) 
    (global-set-key (kbd "M-y") 'helm-show-kill-ring) 
    (global-set-key (kbd "C-x b") 'helm-mini) 
    (global-set-key (kbd "C-x C-f") 'helm-find-files) 
    (global-set-key (kbd "C-x c c") 'helm-calcul-expression) 
    (define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history))


;; Projectile
(use-package 
    helm-projectile 
    :ensure t 
    :config (projectile-mode +1) 
    (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map) 
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map) 
    (add-to-list 'projectile-globally-ignored-directories "/home/s0000413/develop/src/sim") 
    (define-key projectile-mode-map (kbd "C-c C-f") 'helm-projectile-find-file) 
    (define-key projectile-mode-map (kbd "C-c C-s") 'helm-projectile-ag) 
    (define-key projectile-mode-map (kbd "C-C C-g") 'helm-do-ag))

(setq projectile-indexing-method 'alien)

;; Flyspell
(use-package 
    flyspell 
    :config (setq flyspell-issue-message-flag nil))

;; Magit
(use-package 
    magit 
    :ensure t 
    :config (setq git-commit-fill-column 72) 
    (setq git-commit-summary-max-length 50) 
    (global-set-key (kbd "C-x g") 'magit-status) 
    (add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell) ;; Flyspell in git-commit
    )

;; Bring up help for key bindings
(use-package 
    which-key 
    :ensure t 
    :config (which-key-mode))


;; Multiple cursors
(use-package 
    multiple-cursors 
    :ensure t 
    :config (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines) 
    (global-set-key (kbd "C->") 'mc/mark-next-like-this) 
    (global-set-key (kbd "C-<") 'mc/mark-previous-like-this) 
    (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; Bash completion
(use-package 
    bash-completion 
    :ensure t 
    :config (bash-completion-setup))


;;; Dired-sidebar
(use-package 
    dired-sidebar 
    :bind (("C-x C-n" . dired-sidebar-toggle-sidebar)) 
    :ensure t 
    :commands (dired-sidebar-toggle-sidebar) 
    :config (setq dired-sidebar-theme 'vscode) 
    (setq dired-sidebar-subtree-line-prefix "__") 
    (setq dired-sidebar-theme 'vscode) 
    (setq dired-sidebar-use-term-integration t) 
    (setq dired-sidebar-use-custom-font t))


;; Egerrit
(use-package 
    egerrit 
    :commands egerrit-dashboard 
    :load-path "/home/s0000413/3rdparty/egerrit" 
    :config (setq egerrit-project-configs 
                  '((:name "src" 
                     :code-repo "/home/s0000413/develop/src"))) 
    (setq egerrit-request-url "gerrit.cicd.autoheim.net") ;; runs gerrit-2.13
    (global-set-key (kbd "C-x o") 'egerrit-dashboard) 
    (setq-default show-trailing-whitespace t) 
    (add-hook 'egerrit-dashboard-mode-hook (lambda () 
                                             (setq show-trailing-whitespace 'nil))))

;; Tags
(setenv "GTAGSLIBPATH"
        "/home/s0000413/.cache/bazel/_bazel_s0000413/97e8f4cc27a395cdfb4287ada735f9db/external")
(defun update-tags () 
  "Update TAGS" 
  (interactive) 
  (shell-command "bash -c \"$HOME/linux_config/scripts/update_tags.sh\""))
(global-set-key (kbd "<f3>") 'update-tags)

(use-package 
    helm-gtags 
    :ensure t 
    :init (custom-set-variables '(helm-gtags-suggested-key-mapping t)) 
    :config (add-hook 'dkired-mode-hook 'helm-gtags-mode) 
    (add-hook 'eshell-mode-hook 'helm-gtags-mode) 
    (add-hook 'c-mode-hook 'helm-gtags-mode) 
    (add-hook 'c-or-c++-mode-hook 'helm-gtags-mode) 
    (add-hook 'c++-mode-hook 'helm-gtags-mode) 
    (add-hook 'c-mode-hook 'helm-gtags-mode) 
    (add-hook 'cuda-mode-hook 'helm-gtags-mode) 
    (add-hook 'asm-mode-hook 'helm-gtags-mode) 
    (add-hook 'python-mode-hook 'helm-gtags-mode) 
    (define-key helm-gtags-mode-map (kbd "C-c g") 'helm-gtags-tags-in-this-function) 
    (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select) 
    (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim) 
    (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack) 
    (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history) 
    (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history))


;;
;; ******************** CODE FORMATTING  ********************
;;

;; Elisp format
(add-hook 'lisp-mode-hook (lambda () 
                            (local-set-key (kbd "<C-tab>") #'elisp-format-buffer)))

;; Python format
(use-package 
    python-black 
    :ensure t 
    :config (add-hook 'python-mode-hook (lambda () 
                                          (local-set-key (kbd "<C-tab>") #'python-black-buffer))))
;; Python linter
(use-package 
    pylint 
    :ensure t 
    :config (setq pylint-options (list "--reports=n" "--output-format=parseable"
                                       "--rcfile=/home/s0000413/develop/src/support/common/pylint3.cfg")) 
    (add-hook 'python-mode-hook (lambda () 
                                  (local-set-key (kbd "<C-S-tab") #'pylint))))
;; Bazel format
(use-package 
    bazel 
    :ensure t 
    :config (add-hook 'bazel-build-mode-hook (lambda () 
                                               (local-set-key (kbd "<C-tab>") #'bazel-buildifier))) 
    (add-to-list 'auto-mode-alist '("\\.bazel\\'" . bazel-build-mode)) 
    (add-to-list 'auto-mode-alist '("\\.bzl" . bazel-build-mode))
    (add-to-list 'auto-mode-alist '("WORKSPACE" . bazel-build-mode))
    )


;; Json
(use-package 
    json 
    :ensure t 
    :config (add-hook 'json-mode-hook (lambda () 
                                        (local-set-key (kbd "<C-tab>") #'json-mode-beautify))) 
    (setq json-encoding-default-indentation "    "))


;; Clang-format
(use-package 
    clang-format 
    :ensure t 
    :config (setq clang-format-executable "/usr/bin/clang-format-15") 
    (add-hook 'c++-mode-hook (lambda () 
                               (local-set-key (kbd "<tab>") #'clang-format-region))) 
    (add-hook 'c++-mode-hook (lambda () 
                               (local-set-key (kbd "<C-tab>") #'clang-format-buffer))) 
    (add-hook 'cuda-mode-hook (lambda () 
                                (local-set-key (kbd "<tab>") #'clang-format-region))) 
    (add-hook 'cuda-mode-hook (lambda () 
                                (local-set-key (kbd "<C-tab>") #'clang-format-buffer))) 
    (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)))


;; Cuda
(use-package 
    cuda-mode 
    :ensure t)




;; ******************** LEGACY ********************
;; ;; Whitespace display
;; (progn
;;   ;; Make whitespace-mode with very basic background coloring for whitespaces.
;;   ;; http://ergoemacs.org/emacs/whitespace-mode.html
;;   (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

;;   ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
;;   (setq whitespace-display-mappings
;;         ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
;;         '((space-mark 32 [183]
;;            [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
;;           (newline-mark 10 [182 10])    ; LINE FEED,
;;           (tab-mark 9 [9655 9]
;;            [92 9])                      ; tab
;;           )))


;; (cl-loop for buffer in (buffer-list) do (with-current-buffer buffer (set-local-colors)))
;; (add-hook 'find-file-hook #'set-local-colors)
;; (add-hook 'dired-mode-hook #'set-local-colors)
;; (add-hook 'temp-buffer-setup-hook #'set-local-colors)
;; (add-hook 'c++-mode-hook #'set-local-colors)
;; (add-hook 'bazel-mode-hook #'set-local-colors)
;; (add-hook 'shell-mode-hook #'set-local-colors)
