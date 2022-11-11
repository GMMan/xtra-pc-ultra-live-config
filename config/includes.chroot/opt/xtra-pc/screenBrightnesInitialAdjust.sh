# change monitor brightness to 100% as default
if [ -e $HOME/.initxpcbrightnesssettings ]
then
    echo "Initial Xtra-PC monitor brightness settings already set"
else
    # change monitor brightness to 100% as default
    gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.freedesktop.DBus.Properties.Set org.gnome.SettingsDaemon.Power.Screen Brightness "<100>"

# Set flag that initial brightness settings were run
touch $HOME/.initxpcbrightnesssettings
fi

