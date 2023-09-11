Name:           termcolor
Version:        1.1.0   
Release:        1%{?dist}
Summary:        ANSI color formatting for terminal output

License:        MIT 
URL:            https://pypi.org/project/termcolor/
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  python3
Requires:       python3
Requires:       bash

BuildArch:      noarch

%description
ANSI color formatting for output in terminal

%prep
%setup -q

%install

mkdir -p %{buildroot}/usr/bin
install -m 755 -p termcolor.py %{buildroot}/usr/bin/termcolor.py

sed -i '1s|^.*$|#!/usr/bin/env python3|' %{buildroot}/usr/bin/termcolor.py


%files
/usr/bin/termcolor.py

%changelog
* Wed Sep  6 2023 root
-