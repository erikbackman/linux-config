(require :stumpwm)

(setf *mode-line-foreground-color* "#000"
      *mode-line-background-color* "#d3d3d3")

(when *initializing*
  (mode-line))
