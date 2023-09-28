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
(my-defapp xcalc "xcalc" '(:class "XCalc"))

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
  (run-shell-command "import -window root -crop $(slop) +repage png:- | xclip -selection clipboard -t image/png"))

(defun get-date-string ()
  (multiple-value-bind
	(second minute hour day month year day-of-week dst-p tz)
      (get-decoded-time)
    (format nil "~d-~d-~d_~d-~d-~d"
	    month
	    day
	    year
	    hour
	    minute
	    second)))

(defun pgrep (proc)
  (uiop:wait-process (uiop:launch-program (list "pgrep" proc))))

(defun pkill (proc)
  (uiop:run-program (list "pkill" proc) :ignore-error-status t))

(defun proc-alive? (proc)
  (equal 0 (pgrep proc)))

(defcommand record () ()
  "Record screen"
  (if (proc-alive? "ffmpeg")
      (progn
	(pkill "ffmpeg")
	(message "Recording stopped"))
      
      (progn
	(message "Recording started")
	(run-shell-command
	 (format nil
		 ;; "ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i $DISPLAY -c:v libx264rgb -crf 0 -preset ultrafast -color_range 2 output.mkv "
		 "ffmpeg -framerate 60 -f x11grab -video_size 3440x1440 -i :0.0+0,0 -c:a aac -c:v libx264 -crf 0 -preset ultrafast  ~~/Videos/srecording_~a.mkv"
		 (get-date-string))))))
