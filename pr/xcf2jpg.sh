#!/bin/sh

gimp -n -i -b - <<EOF
(let* ( (file's (cadr (file-glob "$1" 1))) (filename "") (image 0) (layer 0) )
  (while (pair? file's) 
    (set! image (car (gimp-file-load RUN-NONINTERACTIVE (car file's) (car file's))))
    (set! layer (car (gimp-image-merge-visible-layers image CLIP-TO-IMAGE)))
    (set! filename "$2")
    (gimp-file-save RUN-NONINTERACTIVE image layer filename filename)
    (gimp-image-delete image)
    (set! file's (cdr file's))
  )
  (gimp-quit 0)
)
EOF
