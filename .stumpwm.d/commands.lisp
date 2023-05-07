(in-package :stumpwm)
(setf *default-package* :stumpwm)

(defmacro my-defapp (name cmd &optional spec)
  `(defcommand ,name () ()
     ,(format nil "Run or raise ~s" name)
     (run-or-raise ,cmd ,spec)))

(my-defapp emacs "emacs --name \"emacs-main\"" '(:title "emacs-main"))
(my-defapp chromium "chromium-bin" '(:role "browser"))
(my-defapp xterm "xterm" '(:class "XTerm"))
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
  "Take screenshot of region"
  (run-shell-command "maim -s | xclip -selection clipboard -t image/png"))

(defcommand record () ()
  "Record screen"
  (run-shell-command "~/src/linux-config/bin/rat-record"))
