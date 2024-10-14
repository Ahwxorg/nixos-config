#!/usr/bin/env bash

slurp | xargs -I {} grim -s 2 -t png -g {} - | tesseract - - | wl-copy -n
