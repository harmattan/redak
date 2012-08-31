%define patchversion 0
%define package_letter r
%define qmake qmake

Name: redak
Version: 0.6.2
Release:%{patchversion}%{?dist}
Summary: Libre text editor to be used on touchscreen using QML
Group: Applications/Editors
License: GPL-3
URL: http://rzr.online.fr/q/redak
Source0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}.orig.tar.gz
Patch0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}-%{patchversion}.diff.gz

BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:  pkgconfig(QtCore) >= 4.7.0
BuildRequires:  pkgconfig(QtGui)
BuildRequires:  desktop-file-utils

Requires: libqtdeclarative4-folderlistmodel


%description
Finger friendly text editor to load save and edit text on your touchscreen device


%prep
%setup -q

%patch0 -p1


%build

qmake-qt4 || qmake
qmake -makefile %{name}.pro
qmake

make %{?_smp_mflags}


%install

make install DESTDIR=%{buildroot} INSTALL_ROOT=%{buildroot}


%files
%defattr(-,root,root,-)
/opt/%{name}
/usr/share/applications/%{name}.desktop
/usr/share/icons/hicolor/80x80/apps/%{name}80.png

