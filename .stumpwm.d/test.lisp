(defun my-restore-layout2 (layout)
  (trivia:match layout
    ((list :full rules) (only))
    ((list name rules)
     (save-frame-excursion
       (when-let ((file
		   (get-file "~~/.local/share/stumpwm/~a.dump" (string-downcase name))))
	 (restore-from-file file)
	 (setf *window-placement-rules* nil)
	 (loop for rule in rules do (define-frame-preference "Default" rule))
	 (place-existing-windows))))))

(my-restore-layout2  (list "Default" '((list 1 t t :class "Emacs")
				       (list 2 t t :title "agenda")
				       (list 2 t t :class "XCalc")
				       (list 0 t t :class "XClock")
				       (list 2 t t :class "XTerm")
				       (list 1 t t :role "browser")
				       (list 1 t t :class "Emacs"))))
