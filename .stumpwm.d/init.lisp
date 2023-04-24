;; -*-lisp-*-

(in-package :stumpwm)
(setf *default-package* :stumpwm)
(load "/home/ebn/quicklisp/setup.lisp")

(run-shell-command "setxkbmap se" nil)
(run-shell-command "xset r rate 150 25" nil)

(restore-from-file "desktop")

(when *initializing*
  (mode-line))

;;; Server
(ql:quickload :slynk)

(defvar *slynk-port* slynk::default-server-port)
(defparameter *stumpwm-slynk-session* nil)

(defcommand start-slynk (&optional (port *slynk-port*)) ()
  (handler-case
      (defparameter *stumpwm-slynk-session*
        (slynk:create-server
         :dont-close t
         :port port))
    (error (c)
           (format *error-output* "Error starting slynk: ~a~%" c)
           )))

(defcommand restart-slynk () ()
  "Restart Slynk and reload source.
This is needed if Sly updates while StumpWM is running"
  (stop-slynk)
  (start-slynk))

(defcommand stop-slynk () ()
  "Restart Slynk and reload source.
  This is needed if Sly updates while StumpWM is running"
  (slynk:stop-server *slynk-port*))

(defcommand connect-to-sly () ()
  (unless *stumpwm-slynk-session*
    (start-slynk))
  (exec-el (sly-connect "localhost" *slynk-port*))
  (emacs))

;;; Basic stuff
(set-prefix-key (stumpwm:kbd "C-comma"))

(setf *startup-message* nil
      *input-window-gravity* :top
      *message-window-gravity* :top
      *message-window-padding* 10
      *message-window-y-padding* 10)

(defcommand screenshot () ()
  "Take a screenshot"
  (run-shell-command "import -window root png:$HOME/Pictures/Screenshots/stumpwm-$(date +%s)$$.png"))

(setf *mouse-policy* :click
      *mouse-focus-policy* :click
      *float-window-modifier* :SUPER)

;;; Applications
(defmacro my-defapp (name command frame &optional (props))
   (list 'defcommand name () ()
     (format nil "Run or raise ~s" name)
     (list 'sb-thread:make-thread
       (list 'lambda ()
	  (list 'run-commands (format nil "fselect ~d" frame))
	  (list 'run-or-pull command props nil nil)))))

(my-defapp chromium "chromium-bin" 1 '(:class "Chromium"))
(my-defapp xterm "xterm" 1 '(:class "XTerm"))

(defcommand agenda () ()
  "Run Emacs agenda"
  (run-commands "fselect 2")
  (run-shell-command "emacs --eval \"(progn (org-agenda-list) (delete-other-windows))\""))

(defcommand suspend () ()
  "Call loginctl suspend"
  (run-shell-command "loginctl suspend"))

(defcommand dmenu () ()
  "Run dmenu"
  (run-shell-command "j4-dmenu-desktop --no-generic --dmenu=\"dmenu -i -nb '#121212' -sf '#000' -sb '#c7ccd1' -l 10 -fn 'iosevka'\""))

(define-key *top-map* (stumpwm:kbd "F1") "emacs")
(define-key *top-map* (stumpwm:kbd "F2") "chromium")
(define-key *top-map* (stumpwm:kbd "F3") "xterm")
(define-key *top-map* (stumpwm:kbd "s-o") "fselect")
(define-key *top-map* (stumpwm:kbd "s-p") "dmenu")

;;; Windows, frames, groups
(define-key *root-map* (stumpwm:kbd "w") "frame-windowlist")
(define-key *root-map* (stumpwm:kbd "g") "gselect")
(define-key *root-map* (stumpwm:kbd "o") "fselect")

;;; Looks
(setf *window-border-style* :thin)
(setf *ignore-wm-inc-hints* t)		; Fill frame
(set-border-color        "#000000")
(set-focus-color         "#5f9ea0")
(set-focus-color         "#000000")
(set-unfocus-color       "#000000")

(setf *mode-line-foreground-color* "#000000"
      *mode-line-background-color* "#d3d3d3")
