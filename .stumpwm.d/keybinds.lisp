(in-package :stumpwm)
(setf *default-package* :stumpwm)

(define-key *top-map* (kbd "F1") "emacs")
(define-key *top-map* (kbd "F2") "chromium")
(define-key *top-map* (kbd "F3") "xterm")
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
