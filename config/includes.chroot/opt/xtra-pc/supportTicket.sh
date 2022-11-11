#!/bin/bash

##################################################################################
#                                                                                #
#  Script: support_ticket.sh                                                     #
#  Author: Prairie IT                                                            # 
#  Contact: support@xtra-pc.com                                                  #
#                                                                                #
#  support_ticket.sh gathers information about the computer and attached         #
#  devices for troubleshooting                                                   #
#                                                                                #
#  Output is saved to the user home directory with the file format               #
#  of:  support_ticket_<date_time>.tar.gz                                        #
#                                                                                #
##################################################################################
### BEGIN LICENSE                                                                # 
# Copyright (C) 2015-2021 Prairie IT support@xtra-pc.com PrairieIT               #
# This program is free software: you can redistribute it and/or modify it        # 
# under the terms of the GNU General Public License version 3, as published      # 
# by the Free Software Foundation.                                               #
#                                                                                #
# This program is distributed in the hope that it will be useful, but            # 
# WITHOUT ANY WARRANTY; without even the implied warranties of                   # 
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR             # 
# PURPOSE.  See the GNU General Public License for more details.                 #
#                                                                                # 
# You should have received a copy of the GNU General Public License along        # 
# with this program.  If not, see <http://www.gnu.org/licenses/>.                #
### END LICENSE                                                                  #
#                                                                                #
##################################################################################

ST=/home/$SUDO_USER/$1
SYSINFO=/tmp/sysinfo
LSHW=/tmp/lshw.html
DPKG=/tmp/dpkg

### Gather System information

echo "### /bin/uname -a ###" > $SYSINFO
/bin/uname -a >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/lspci -nn ###" >> $SYSINFO
/usr/bin/lspci -nn >> $SYSINFO
echo " " >> $SYSINFO

echo "### /sbin/lsmod ###" >> $SYSINFO
/sbin/lsmod >> $SYSINFO
echo " " >> $SYSINFO

echo "### /bin/dmesg ### >> $SYSINFO
/bin/dmesg >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/lsusb ###" >> $SYSINFO 
/usr/bin/lsusb >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/lsusb -t ###" >> $SYSINFO
/usr/bin/lsusb -t >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/lsusb -v ###" >> $SYSINFO
/usr/bin/lsusb -v >> $SYSINFO
echo " " >> $SYSINFO

echo "### /bin/df -h ###" >> $SYSINFO
/bin/df -h >> $SYSINFO
echo " " >> $SYSINFO

echo "### /bin/mount ###" >> $SYSINFO
/bin/mount >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/nmcli -p g ###" >> $SYSINFO
/usr/bin/nmcli -p g >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/nmcli -p n ###" >> $SYSINFO
/usr/bin/nmcli -p n >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/nmcli -p r ###" >> $SYSINFO
/usr/bin/nmcli -p r >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/nmcli -p c ###" >> $SYSINFO
/usr/bin/nmcli -p c >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/nmcli -p d ###" >> $SYSINFO
/usr/bin/nmcli -p d >> $SYSINFO
echo " " >> $SYSINFO

echo "### /sbin/ip a ###" >> $SYSINFO
/sbin/ip a >> $SYSINFO
echo " " >> $SYSINFO

echo "### /bin/cat /etc/fstab ###" >> $SYSINFO
/bin/cat /etc/fstab >> $SYSINFO
echo " " >> $SYSINFO

echo "### /bin/cat /etc/os-release ###" >> $SYSINFO
/bin/cat /etc/os-release >> $SYSINFO
echo " " >> $SYSINFO

echo "### /bin/ls -l /opt/xtra-pc ###" >> $SYSINFO
/bin/ls -l /opt/xtra-pc >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/hardinfo -m devices.so -m computer.so -m network.so -r ###" >> $SYSINFO
/usr/bin/hardinfo -m devices.so -m computer.so -m network.so -r >> $SYSINFO
echo " " >> $SYSINFO

echo "### /usr/bin/dpkg -l ###" > $DPKG
/usr/bin/dpkg -l >> $DPKG

# Gather lshw information
sudo lshw -html > $LSHW

# Gather syslog files and tar and zip up files
tar cfz $ST $SYSINFO $LSHW $DPKG /var/log/syslog* /home/$SUDO_USER/Xtrapc*

# Change permissions of file to rw for all users
sudo chmod 666 $ST

# Change owner to user that executed support ticket generation
sudo chown xpc:xpc $ST
