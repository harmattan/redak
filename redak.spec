# file://./redak.spec

%define patchversion 0
%define package_letter r
%define qmake qmake

Name: redak
Version: 0.5.2
Release:%{patchversion}%{?dist}
Summary: Basic text editor to be used on touchscreen using QML
Group: Utils
License: GPL-3
URL: http://rzr.online.fr/q/redak
Source0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}.orig.tar.gz
Patch0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}-%{patchversion}.diff.gz

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
%doc

