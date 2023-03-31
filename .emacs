
;; Patch to linux config dir
(setq linux-config-dir "~/linux_config/")

;; Path and name to git repos
(setq linux-config-gitrepo1-dir "~/linux_config")
(setq linux-config-gitrepo1-name "reponame")
(setq linux-config-gitrepo2-dir "")
(setq linux-config-gerrit-url "https://gerrit.")

;; Path to external deps in bazel cache
(setq linux-config-bazel-cache-external-dir "")

;; Launch and load
(add-to-list 'load-path linux-config-dir)
(load (concat linux-config-dir "emacs.lisp"))
