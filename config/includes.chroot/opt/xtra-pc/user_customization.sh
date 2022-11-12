#!/bin/bash

# Only run commands once after initial login 
if [ -e $HOME/.initxpcsettings ]
then
    echo "Initial Xtra-PC settings already set"
else
    # Enable Maximize and Minimize window buttons
    gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface clock-show-weekday true
    gsettings set org.gnome.desktop.screensaver lock-enabled false
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
    gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'xtrapcControlCenter.desktop']"
    gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'xtrapcGettingStartedTutorial.desktop']"

    # change monitor brihjtness to 100% as default
    gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false

    #for i in {0..20}
    #do
    #    gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepUp > /dev/null 2>&1
    #done            

    # Enable apps menu extension
    gnome-shell-extension-tool -e apps-menu@gnome-shell-extensions.gcampax.github.com
    
    # Enable Windows List extension
    gnome-shell-extension-tool -e window-list@gnome-shell-extensions.gcampax.github.com
 
    # Enable Add To Desktop extension (Adds adding application shortcuts to desktop)
    gnome-shell-extension-tool -e add-to-desktop@tommimon.github.com

    # Enable Desktop Icons NG (DING) extension (Adds ability to add files and folders to desktop)
    gnome-shell-extension-tool -e ding@rastersoft.com

    # Additional items
    # Remove Japanese IME by default
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
    gsettings set org.gnome.desktop.interface gtk-im-module gtk-im-context-simple

    # 12-hour time
    gsettings set org.gnome.desktop.interface clock-format 12h
    gsettings set org.gtk.Settings.FileChooser clock-format 12h

    # Some Desktop icons
    mkdir -p "$HOME/Desktop"
    icon_names=( "xtrapcControlCenter.desktop" "xtrapcGettingStartedTutorial.desktop" )
    for app in "${icon_names[@]}"; do
        cp "/usr/share/applications/${app}" "$HOME/Desktop"
        chmod u+x "$HOME/Desktop/${app}"
        gio set "$HOME/Desktop/${app}" "metadata::trusted" "true"
    done

    # Bookmark to /data
    if [ -d "/data" ]; then
        mkdir -p ~/.config/gtx-3.0
        echo "file:///data" >> ~/.config/gtk-3.0/bookmarks
    fi

    # Set flag that initial settings were run
    touch $HOME/.initxpcsettings
fi
