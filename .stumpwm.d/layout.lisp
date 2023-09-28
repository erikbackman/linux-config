(in-package :stumpwm)
(setf *default-package* :stumpwm)

(setf stumpwm::*window-placement-rules* nil)

(define-frame-preference "Default"
  (1 t nil :title "emacs-main")
  (1 t nil :role "browser")
  (3 t nil :class "XTerm")
  (0 t t :title "clock")
  (2 nil nil :class "untitled"))

(defun get-file (path &rest format-arguments)
  (probe-file (uiop:native-namestring (apply 'format nil path format-arguments))))

(define-stumpwm-type :layout (input _)
  (declare (ignore _))
  (let ((options '(("default" :default)
		   ("full" :full)
		   ("three-pane" :three-pane)))
	(arg (argument-pop input)))
    (when arg
      (or (second (assoc arg options :test #'string=))
	  (throw 'error "invalid layout")))))

(defcommand my-restore-layout (layout) ((:layout "name: "))
  (if (equal layout :full)
      (only)
      (save-frame-excursion
	(when-let ((file
		    (get-file "~~/.local/share/stumpwm/~a.dump" (string-downcase layout))))
	  (restore-from-file file)
	  (place-existing-windows)))))

(defparameter *my-frame-keymap*
  (let ((m (stumpwm:make-sparse-keymap)))
    (define-key m (kbd "l") "my-restore-layout")
    (define-key m (kbd "f") "my-restore-layout full")
    (define-key m (kbd "d") "my-restore-layout default")
    (define-key m (kbd "s") "my-restore-layout three-pane")
    m))

(define-key *root-map* (kbd "f") '*my-frame-keymap*)
