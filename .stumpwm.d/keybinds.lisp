(in-package :stumpwm)
(setf *default-package* :stumpwm)

(define-key *top-map* (kbd "F1") "emacs")
(define-key *top-map* (kbd "F2") "chromium")
(define-key *top-map* (kbd "F3") "fselect 2")
(define-key *top-map* (kbd "s-o") "other-in-frame")
(define-key *top-map* (kbd "s-p") "dmenu")
(define-key *top-map* (kbd "s-SPC") "float-this")

(define-key *top-map* (kbd "s-p")
  "exec j4-dmenu-desktop --no-generic --dmenu=\"dmenu -i -nb '#000' -nf '#fff' -sf '#000' -sb '#5f9ea0' -l 10 -fn 'Fantasque Sans Mono-11'\"")

(define-key *root-map* (kbd "b") "chromium")
(define-key *root-map* (kbd "C-l") "xclock")
(define-key *root-map* (kbd "c") "xcalc")
(define-key *root-map* (kbd "t") "xterm")
(define-key *root-map* (kbd "a") "agenda")
(define-key *root-map* (kbd "C-,") "other")

;;; Windows, frames, groups
(define-key *root-map* (stumpwm:kbd "w") "frame-windowlist")
(define-key *root-map* (stumpwm:kbd "W") "windowlist")
(define-key *root-map* (stumpwm:kbd "g") "gselect")
(define-key *root-map* (stumpwm:kbd "o") "fselect")
(define-key *top-map* (stumpwm:kbd "s-RET") "fselect")

(define-key *root-map* (stumpwm:kbd "B") "mode-line")
