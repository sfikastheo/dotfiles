### Screen shot terminal utilities: 
Collecting screenshot utilities that i have tried and configurations:

* [flameshot](https://github.com/flameshot-org/flameshot): Powerfull screenshot utility.
Works perfecty out of the box in X11, But there are some hardships moving to wayland.
Build with qt5, so in case you are not qt-based, flameshot is a bit heavy.
Utilize with `flameshot gui` in order to partially capture display.

* [maim](https://github.com/naelstrof/maim): Great terminal utility for basic needs (X11).
The github page also includes a lot of execution examples and is available to almost
every distribution. Big problem the utility faces in that in copying large screen areas
to the xclip board, the image size prossibly overloads the system.  
Examples:
    * Copy to clipboard: `maim -s | xclip -selection clipboard -t image/png`
    * Save to folder: `maim -s ~/Pictures/$(date +%s).png`

* [shotgun](https://github.com/neXromancers/shotgun): Shotgun is a rust drop in replacement
to maim. The creators showcase an at least 2X performance increase in contrast, while
also managing to be lighter. In my testing it faces the same problems with maim when copying
to clipboard large screenshot areas. To be utilized effectively as an area capture utility
[hacksaw](https://github.com/neXromancers/hacksaw) by the same development team, or
[slop](https://github.com/naelstrof/slop) by the development team of maim are necessary.
The shotgun utility could possibly work effectively on wayland, if paired with a display selector
that supports it. However this is not tested and just speculation.  
Examples:
    *
    ```
    selection=$(hacksaw -f "-i %i -g %g")
    shotgun $selection - | xclip -t 'image/png' -selection clipboard`
    ```

#### Using [imagemagick](https://imagemagick.org/script/command-line-processing.php) and [graphicsmagick](http://www.graphicsmagick.org/utilities.html) with maim and shotgun:
Both maim and shotgun can produce either pam or png image formats. The utilities imagemagick and
graphicsmagick are complimentary to the image capturing utilities, for their extensive ability to
work with images. Graphicsmagick is seen as a more powerfull, multithreaded and safe alternative 
to imagemagick and has replaced it i RHEL based distributions. Both utilities seem to work best with
X11 but i have not tested their compatibility with the Wayland display manager. 
Keep in mind that graphicsmagick command line utility uses `gm <action>` and might clash with the
bach-completion package.
Examples:
    Converting the [png to jpeg](https://www.linuxfordevices.com/tutorials/linux/convert-png-to-jpeg-terminal):
    ```
    selection=$(hacksaw -f "-i %i -g %g")
    shotgun $selection -f pam - | gm convert - jpg:- | xclip -t 'image/png' -selection clipboard
    ```
    Why go through so much trouble ? Now the image size is much smaller and can easily be pasted.

