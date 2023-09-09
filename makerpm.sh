echo ------------------------------------------------------------------------------------
echo install libs
echo ------------------------------------------------------------------------------------
dnf install -y rpm-build rpmdevtools
dnf install -y python3-pip
pip3 install termcolor
echo ------------------------------------------------------------------------------------
echo prep termcolor files
echo ------------------------------------------------------------------------------------
cd /root/
rpmdev-setuptree
cp /dev/termcolor.spec /root/rpmbuild/SPECS/termcolor.spec
cd /usr/local/lib/python3.6/site-packages
mkdir termcolor-1.1.0
mv ./termcolor.py termcolor-1.1.0 
tar -cvzf termcolor-1.1.0.tar.gz termcolor-1.1.0 
mv termcolor-1.1.0.tar.gz /root/rpmbuild/SOURCES/termcolor-1.1.0.tar.gz 
cd /root/rpmbuild/SPECS 
echo ------------------------------------------------------------------------------------
echo start build
echo ------------------------------------------------------------------------------------
rpmbuild -bb -vv /root/rpmbuild/SPECS/termcolor.spec
cp -r /root/rpmbuild/RPMS/noarch/* /dev/rpm/
echo ------------------------------------------------------------------------------------
echo DONE XDDDD