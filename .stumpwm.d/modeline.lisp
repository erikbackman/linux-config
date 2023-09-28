(in-package :stumpwm)
(setf *default-package* :stumpwm)

(setf *mode-line-foreground-color* "#000"
      *mode-line-background-color* "#d3d3d3")

(setf *mode-line-foreground-color* "#d3d3d3"
      *mode-line-background-color* "#000")

(when *initializing*
  (mode-line))
