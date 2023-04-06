#!/bin/bash

action=""
for file in ./*.svg
      do
action="${action}file-open:$file;select-all;object-stroke-to-path;export-filename:$file;export-do;file-close;"
      done
action="${action}quit-inkscape"
/Applications/Inkscape.app/Contents/MacOS/inkscape --batch-process --actions="$action"


