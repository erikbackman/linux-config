(require :stumpwm)

(define-frame-preference "Default"
  (1 t t :class "Emacs"))

(define-frame-preference "Default"
  (1 t t :role "browser"))

(define-frame-preference "Default"
  (2 t t :class "XTerm"))

(define-frame-preference "Default"
  (0 t t :class "XClock"))

(define-frame-preference "Default"
  (2 t t :title "agenda"))

(defun get-file (path &rest format-arguments)
  (probe-file (uiop:native-namestring (apply 'format nil path format-arguments))))

(define-stumpwm-type :layout (input _)
  (let ((options '(("default" :default)
		   ("full" :full)))
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

(defvar *my-frame-keymap*
  (let ((m (stumpwm:make-sparse-keymap)))
    (define-key m (kbd "l") "my-restore-layout")
    (define-key m (kbd "f") "my-restore-layout full")
    (define-key m (kbd "d") "my-restore-layout default")
    m))

(define-key *root-map* (kbd "f") '*my-frame-keymap*)
