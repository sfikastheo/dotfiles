### Configuring the Cursor theme X11.
Cursors are basically icon themes and should be located to the appropriate folders.
Common directories are `~/.local/share/icons` and `~/.icons`. For example i usually
extract the cursor theme folder under ~/.icons/Bibata-Modern-Ice/.  
Setting the specified cursor theme can be achieved by the following steps:
* Under the xinit script, or any autostart script, in case of using a window manager running 
`xsetroot -cursor_name left_ptr` is adviced. The package for the xsetroot utility on Arch is: 
xorg-xsetroot.
* Create the `~/.Xresources` file and incude the line `Xcursor.theme: Bibata-Modern-Ice`.
Alternate the cursor theme name accordingly. On the autostart procedure use the xrdb utility 
provided by the xorg-xrdb package on Arch as follows: `xrdb -merge ~/.Xresources`
* Create in case that does not exist the `~/.icons/default/index.theme` file and write the 
following: 
```
[icon theme] 
Inherits=Bibata-Modern-Ice
```
This applies for both X11 and Wayland, change the cursor theme name accordingly.
* For Gtk applications, for each version change the following lines in:
     ```
    gtk-font-name="FiraCode Nerd Font Mono Ret,  10"
    gtk-cursor-theme-name="Bibata-Modern-Ice"
    gtk-cursor-theme-size=24

    ```
    * For gkt-2 applications: `~/.gtkrc-2.0`:
    * For gtk-3 applications: `~/.config/gtk-3.0/settings.ini`
    * For gtk-4 applications: `~/.config/gtk-4.0/settings.ini`
Alternatively use the Lxapearance-gtk3 package to configure the above and more
using a gui environment.
