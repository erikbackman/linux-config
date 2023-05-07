(require :stumpwm)
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
