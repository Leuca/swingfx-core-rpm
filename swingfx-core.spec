Name:			swingfx-core
Version:		1.0.0
Release:		%autorelease
Summary:		Swing utilities core
BuildArch:		noarch

License:		GPLv3

Source0:		https://github.com/spreiter301/Core/archive/master/swingfx-core.tar.gz

ExclusiveArch:	%{java_arches} noarch

%if 0%{?fedora} < 40 || (0%{?rhel} && 0%{?rhel} < 10)
BuildRequires:  maven-local-openjdk11
%else
BuildRequires:  maven-local
%endif

%description
Swing utilities core

%{?javadoc_package}

%prep
%autosetup -n Core-master

%pom_xpath_set //pom:source 1.8
%pom_xpath_set //pom:target 1.8

%build
%mvn_build

%install
%mvn_install

%files -f .mfiles
%license licenses/gpl_v3.txt

%changelog
%autochangelog
