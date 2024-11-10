#!/bin/bash

# Use hacksaw, shotgun and graphicsmagick utilities:
selection=$(hacksaw -f "-i %i -g %g")
shotgun $selection -f pam - | gm convert - jpg:- | xclip -t 'image/png' -selection clipboard

