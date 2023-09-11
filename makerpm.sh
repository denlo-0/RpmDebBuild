#!/bin/bash

#export TERM=xterm
 
#set -e
#set -o pipefail

clear
echo "----------------------------------------------------"
echo "Установка библиотек"
echo "----------------------------------------------------"

dnf_packages=("rpm-build" "rpmdevtools" "python3-pip")
pip_package="termcolor"

dnf install -y "${dnf_packages[@]}"
pip3 install "$pip_package"

echo "----------------------------------------------------"
echo "Подготовка файлов termcolor"
echo "----------------------------------------------------"

cd /root
rpmdev-setuptree

cp /dev/termcolor.spec /root/rpmbuild/SPECS/termcolor.spec

termcolor_version="1.1.0"
site_packages_python_dir="/usr/local/lib/python3.6/site-packages/"

mkdir -p "$site_packages_python_dir/termcolor-$termcolor_version"
mv "$site_packages_python_dir/termcolor.py" "$site_packages_python_dir/termcolor-$termcolor_version"
cd "$site_packages_python_dir"
tar -cvzf "/root/rpmbuild/SOURCES/termcolor-$termcolor_version.tar.gz" "./termcolor-$termcolor_version"

echo "----------------------------------------------------"
echo "Начало сборки"
echo "----------------------------------------------------"

rpmbuild -bb -vv /root/rpmbuild/SPECS/termcolor.spec

cp -r /root/rpmbuild/RPMS/noarch/* /dev/rpm/

echo "----------------------------------------------------"
echo "Готово!"
echo "----------------------------------------------------"