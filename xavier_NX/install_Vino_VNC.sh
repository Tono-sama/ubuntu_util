#!/bin/bash

# L4T-README
# README-vnc.txt

# ----------------------------------------------------------------------
echo "Installing the VNC Server"
# ----------------------------------------------------------------------
# It is expected that the VNC server software is pre-installed.
#  Execute the following commands to ensure that it is:
sudo apt update
sudo apt install vino
sudo apt install nano

# ----------------------------------------------------------------------
echo "Enabling the VNC Server"
# ----------------------------------------------------------------------
# Execute the following commands to enable the VNC server:

# Enable the VNC server to start each time you log in
sudo ln -s ../vino-server.service \
    /usr/lib/systemd/user/graphical-session.target.wants

# Configure the VNC server
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false

# Set a password to access the VNC server
# Replace thepassword with your desired password
gsettings set org.gnome.Vino authentication-methods "['vnc']"
# gsettings set org.gnome.Vino vnc-password $(echo -n 'thepassword'|base64)
# gsettings set org.gnome.Vino vnc-password $(echo -n 'max8char'|base64)
gsettings set org.gnome.Vino vnc-password $(echo -n 'open4me'|base64)

# ----------------------------------------------------------------------
echo "Setting the Desktop Resolution"
# ----------------------------------------------------------------------
# sudo nano /etc/X11/xorg.conf

cat - << EOS > xorg_tmp.conf

Section "Screen"
   Identifier    "Default Screen"
   Monitor       "Configured Monitor"
   Device        "Tegra0"
   SubSection "Display"
       Depth    24
       Virtual 1920 1080 # Modify the resolution by editing these values
   EndSubSection
EndSection
EOS

cat /etc/X11/xorg.conf xorg_tmp.conf > xorg.conf
rm xorg_tmp.conf
sudo cp xorg.conf /etc/X11/xorg.conf
rm xorg.conf
cat /etc/X11/xorg.conf


# ===
echo "Enable Automatic Login"
# The VNC server is only available after you have logged in to Jetson locally.
# If you wish VNC to be available automatically,
#  use the system settings application to enable automatic login.

# GDM GNOME Display Manager
# sudo nano /etc/gdm3/custom.conf
# /etc/gdm3/custom.conf
#  AutomaticLoginEnable = true
#  AutomaticLogin = user1
cp /etc/gdm3/custom.conf .
sed -i 's/^#  AutomaticLoginEnable/AutomaticLoginEnable/' custom.conf
sed -i "s/^AutomaticLoginEnable=False/AutomaticLoginEnable = true/" custom.conf
sed -i "s/^#  AutomaticLogin = .*/AutomaticLogin = $(whoami)/" custom.conf
sudo cp custom.conf /etc/gdm3/custom.conf
rm custom.conf
cat /etc/gdm3/custom.conf


# Reboot the system so that the settings take effect
# ===
# sudo reboot
echo '---'
echo "Reboot the system so that the settings take effect"
echo ''
echo "sudo reboot"

# ===
# ===
cd $SCRIPT_DIR
if [ -e ../bell.sh ]; then
  chmod +x ../bell.sh
  bash ../bell.sh
fi
