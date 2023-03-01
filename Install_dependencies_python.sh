#!/bin/sh

if [ `grep -c "camera_auto_detect=1" $FIND_FILE` -ne '0' ];then
    sudo sed -i "s/\(^camera_auto_detect=1\)/camera_auto_detect=0/" /boot/config.txt
fi
if [ `grep -c "camera_auto_detect=0" $FIND_FILE` -lt '1' ];then
    sudo bash -c 'echo camera_auto_detect=0 >> /boot/config.txt'
fi
if [ `grep -c "dtoverlay=arducam-pivariety,media-controller=0" $FIND_FILE` -lt '1' ];then
    sudo bash -c 'echo dtoverlay=arducam-pivariety,media-controller=0 >> /boot/config.txt'
fi


sudo apt update
sudo apt install libopencv-dev -y
sudo apt-get -y install libcblas-dev
sudo apt-get -y install libhdf5-dev
sudo apt-get -y install libhdf5-serial-dev
sudo apt-get -y install libatlas-base-dev
sudo apt-get -y install libjasper-dev 
sudo apt-get -y install libqtgui4 
sudo apt-get -y install libqt4-test

sudo pip3 install opencv-python ArducamDepthCamera
sudo pip3 install numpy --upgrade

echo "reboot now?(y/n):"
read -r USER_INPUT
case $USER_INPUT in
'y'|'Y')
    echo "reboot"
    sudo reboot
;;
*)
    echo "cancel"
    echo "The script settings will only take effect after restarting, please restart yourself later."
    exit 1
;;
esac
