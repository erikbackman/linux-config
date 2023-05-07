;; -*-lisp-*-

(in-package :stumpwm)
(setf *default-package* :stumpwm)

(load "/home/ebn/quicklisp/setup.lisp")

(load "~/.stumpwm.d/server.lisp")
(load "~/.stumpwm.d/theme.lisp")
(load "~/.stumpwm.d/modeline.lisp")
(load "~/.stumpwm.d/commands.lisp")
(load "~/.stumpwm.d/keybinds.lisp")
(load "~/.stumpwm.d/layout.lisp")

(run-shell-command "pgrep picom || picom &")

(set-prefix-key (stumpwm:kbd "C-comma"))

(setf *startup-message* nil
      *input-window-gravity* :top
      *message-window-gravity* :top
      *message-window-padding* 10
      *message-window-y-padding* 10)

(setf *mouse-policy* :click
      *mouse-focus-policy* :click
      *float-window-modifier* :SUPER)

(my-restore-layout "default")
