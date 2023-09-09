echo ------------------------------------------------------------------------------------
echo install libs
echo ------------------------------------------------------------------------------------
apt-get update
apt -y install python3-pip
pip install termcolor
DEBIAN_FRONTEND=noninteractive apt-get install -y dpkg-dev devscripts
echo ------------------------------------------------------------------------------------
echo prep termcolor files
echo ------------------------------------------------------------------------------------
cd /dev
mkdir termcolor
cd termcolor
mkdir -p DEBIAN/ usr/bin
cd /usr/local/lib/python3.8/dist-packages/termcolor
mv __main__.py termcolortest.py
sed -i '1s|^.*$|#!/usr/bin/env python3|' termcolortest.py
mv __init__.py termcolor.py termcolortest.py /dev/termcolor/usr/bin
chmod +x /dev/termcolor/usr/bin/*
cd /dev/termcolor/DEBIAN
cp /dev/control ./control
cd /dev
echo ------------------------------------------------------------------------------------
echo start build
echo ------------------------------------------------------------------------------------
dpkg-deb --build termcolor
cp termcolor.deb /dev/deb/termcolor.deb
echo ------------------------------------------------------------------------------------
echo DONE XDDDD