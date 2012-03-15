%define patchversion 0
%define package_letter r
%define qmake qmake

Name: redak
Version: 0.0.0
Release:0%{?dist}
Summary: TODO
Group: Utils
License: TODO
URL: http://rzr.online.fr/q/contrib#${package}
Source0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}.orig.tar.gz
Patch0: http://rzr.online.fr/ubuntu/pool/main/%{package_letter}/%{name}/%{name}_%{version}-%{patchversion}.debian.tar.gz

BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires: qt-qmake 
BuildRequires: libqt-devel
BuildRequires: libqtdeclarative4
#BuildRequires: QtDeclarative-devel

%description
TODO

%prep
#zypper help
%setup -q
%build
qmake -makefile %{name}.pro
qmake
#configure
make %{?_smp_mflags}

%install
rm -rf %{buildroot}
make install DESTDIR=%{buildroot} INSTALL_ROOT=%{buildroot}

%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
/opt/%{name}
%doc

%changelog

* Sun Mar 02 2012 Philippe Coval <rzr@gna.org> 0.0.0
- wip
