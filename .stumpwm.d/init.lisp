;; -*-lisp-*-

(in-package :stumpwm)
(setf *default-package* :stumpwm)
(load "/home/ebn/quicklisp/setup.lisp")

(defun lookup-or (key list or) (if-let ((kvp (member key list))) (cadr kvp) or))

;;; Looks
(setf *window-border-style* :thin)
(setf *ignore-wm-inc-hints* t)		; Fill frame
(set-border-color        "#000000")
(set-focus-color         "#5f9ea0")
(set-focus-color         "#000000")
(set-unfocus-color       "#000000")

;;; Mode-line
(setf *mode-line-foreground-color* "#000"
      *mode-line-background-color* "#d3d3d3")

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

(setf *mouse-policy* :click
      *mouse-focus-policy* :click
      *float-window-modifier* :SUPER)

;;; Applications

(defmacro my-defapp (name cmd &optional spec keybind)
  `(progn
     (defcommand ,name () ()
       ,(format nil "Run or raise ~s" name)
       (run-or-raise ,cmd ,spec))
     ,(when keybind
	`(define-key ,(car keybind) ,(kbd (cdr keybind)) ,(string name)))))

(my-defapp emacs "emacs --name \"emacs-main\"" '(:title "emacs-main") (*top-map* . "F1"))
(my-defapp chromium "chromium-bin" '(:role "browser") (*top-map* . "F2"))
(my-defapp xterm "xterm" '(:class "XTerm") (*top-map* . "F3"))
(my-defapp xclock "xclock" '(:class "XClock"))

(defcommand agenda () ()
  "Run Emacs agenda"
  (run-or-raise "emacs --name \"agenda\" --eval \"(progn (org-agenda-list) (delete-other-windows))\" "
		'(:title "agenda")))

(defcommand suspend () ()
  "Call loginctl suspend"
  (run-shell-command "loginctl suspend"))

(defcommand sshot () ()
  "Take a screenshot"
  (run-shell-command "import -window root png:$HOME/Pictures/Screenshots/stumpwm-$(date +%s)$$.png"))

(defcommand sshot-region () ()
  "Take screenshto of region"
  (run-shell-command "maim -s | xclip -selection clipboard -t image/png"))

(defcommand record () ()
  "Record screen"
  (run-shell-command "~/src/linux-config/bin/rat-record"))

(define-key *top-map* (kbd "s-o") "fselect")
(define-key *top-map* (kbd "s-p") "dmenu")
(define-key *root-map* (kbd "c") "calc")
(define-key *root-map* (kbd "a") "agenda")

(define-key *top-map* (kbd "s-p")
  "exec j4-dmenu-desktop --no-generic --dmenu=\"dmenu -i -nb '#ccc' -nf '#000' -sf '#000' -sb '#9fc5c6' -l 10 -fn 'jetbrains mono-12'\"")

(define-key *root-map* (kbd "C-l") "xclock")

;;; Windows, frames, groups
(define-key *root-map* (stumpwm:kbd "w") "frame-windowlist")
(define-key *root-map* (stumpwm:kbd "W") "windowlist")
(define-key *root-map* (stumpwm:kbd "g") "gselect")
(define-key *root-map* (stumpwm:kbd "o") "fselect")

(define-key *root-map* (stumpwm:kbd "B") "mode-line")

(define-frame-preference "Default"
  (1 t t :class "Emacs"))

(define-frame-preference "Default"
  (1 t t :class "chromium-bin-browser-chromium"))

(define-frame-preference "Default"
  (2 t t :class "XTerm"))

(define-frame-preference "Default"
  (0 t t :class "XClock"))

(define-frame-preference "Default"
  (2 t t :title "agenda"))

(defun get-file (path &rest format-arguments)
  (probe-file (uiop:native-namestring (apply 'format nil path format-arguments))))

(define-stumpwm-type :layout (_ prompt)
  (completing-read (current-screen) prompt '("default" "two-pane" "full")))

(defcommand my-restore-layout (name) ((:layout "name: "))
  (save-frame-excursion
    (if (equal name "full")
	(only)
	(when-let ((file
		    (get-file "~~/.local/share/stumpwm/~a.dump" name)))
	  (restore-from-file file)
	  (place-existing-windows)))))

(my-restore-layout "default")
