# file://./redak.spec

%define patchversion 0
%define package_letter r
%define qmake qmake

Name: redak
Version: 0.6.0
Release:%{patchversion}%{?dist}
Summary: Basic text editor to be used on touchscreen using QML
#Group: Utils
Group: Applications/Editors
License: GPL-3
URL: http://rzr.online.fr/q/redak
Source0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}.orig.tar.gz
Patch0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}-%{patchversion}.diff.gz


#redak.src: W: specfile-error sh: @__ID_U@: command not found #TODO
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:  pkgconfig(QtCore) >= 4.7.0
BuildRequires:  pkgconfig(QtGui)
BuildRequires:  desktop-file-utils
#BuildRequires:  pkgconfig(QtQuick)
#BuildRequires: qt-qmake
#BuildRequires: libqt-devel
#BuildRequires: libqtdeclarative4
#BuildRequires: QtDeclarative-devel


%description
Finger friendly text editor to load save and edit text on your touchscreen device


%prep
#zypper help
%setup -q

%patch0 -p1


%build

qmake-qt4 || qmake
qmake -makefile %{name}.pro
qmake
#configure
make %{?_smp_mflags}


%install
#rm -rf %{buildroot}
make install DESTDIR=%{buildroot} INSTALL_ROOT=%{buildroot}
#make install DESTDIR=%{buildroot}


%files
%defattr(-,root,root,-)
/opt/%{name}
/usr/share/applications/%{name}.desktop
#/usr/share/icons/hicolor/64x64/apps/%{name}.png
/usr/share/icons/hicolor/80x80/apps/%{name}80.png

#%doc docs/*
#%{_bindir}/*
#%{_libdir}/*
#%{_datadir}/*

#%doc

