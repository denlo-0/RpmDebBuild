#!/bin/bash

#export TERM=xterm

#set -e
#set -o pipefail

clear
echo "----------------------------------------------------"
echo "Установка библиотек"
echo "----------------------------------------------------"

apt-get update

termcolor_package="termcolor"
dnf_packages=("dpkg-dev" "devscripts" "python3-pip")

DEBIAN_FRONTEND=noninteractive apt-get install -y "${dnf_packages[@]}"
pip install "$termcolor_package"

echo "----------------------------------------------------"
echo "Подготовка файлов termcolor"
echo "----------------------------------------------------"

termcolor_dir="/dev/termcolor"
termcolor_debian_dir="$termcolor_dir/DEBIAN"
termcolor_usr_dir="$termcolor_dir/usr/bin"
termcolor_python_dir="/usr/local/lib/python3.8/dist-packages/termcolor"

mkdir -p "$termcolor_usr_dir"
mkdir -p "$termcolor_debian_dir"

mv "$termcolor_python_dir/__main__.py" "$termcolor_python_dir/termcolortest.py"
sed -i '1s|^.*$|#!/usr/bin/env python3|' "$termcolor_python_dir/termcolortest.py"
mv "$termcolor_python_dir/__init__.py" "$termcolor_python_dir/termcolor.py" "$termcolor_python_dir/termcolortest.py" "$termcolor_usr_dir"

chmod +x "$termcolor_usr_dir"/*

cp /dev/control "$termcolor_debian_dir/control"

echo "----------------------------------------------------"
echo "Начало сборки"
echo "----------------------------------------------------"

dpkg-deb --build "$termcolor_dir"

cp "$termcolor_dir.deb" /dev/deb/termcolor.deb

echo "----------------------------------------------------"
echo "Готово!"
echo "----------------------------------------------------"