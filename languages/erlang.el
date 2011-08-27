;; erlang-mode is part of the Erlang source, and I found
;; no simple way to create a el-get package. So it's one
;; more thing thats not installed through el-get.

(add-to-list 'load-path "~/.emacs.d/languages/erlang")
(setq erlang-root-dir "/usr/local")
(setq exec-path (cons "/usr/local/bin" exec-path))
(require 'erlang-start)
(require 'erlang-flymake)
