%define __jar_repack 0
%define _prefix /opt

Summary: Apache Kafka is publish-subscribe messaging rethought as a distributed commit log.
Name: kafka
Version: %{version}
Release: 1
License: Apache License, Version 2.0
Group: Applications
Source0: http://apache.mirrors.spacedump.net/kafka/%{version}/%{tarball}
Source1: kafka.init
URL: http://kafka.apache.org
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Prefix: /opt
Vendor: Apache Software Foundation
Packager: Ivan Dyachkov <ivan.dyachkov@klarna.com>
Provides: kafka

%description
Kafka is designed to allow a single cluster to serve as the central data backbone for a large organization. It can be elastically and transparently expanded without downtime. Data streams are partitioned and spread over a cluster of machines to allow data streams larger than the capability of any single machine and to allow clusters of co-ordinated consumers. Messages are persisted on disk and replicated within the cluster to prevent data loss.

%prep
%setup -n %{tarball_name}

%build

%install
mkdir -p $RPM_BUILD_ROOT%{_prefix}/kafka
mkdir $RPM_BUILD_ROOT%{_prefix}/kafka/bin
cp bin/kafka-*.sh $RPM_BUILD_ROOT%{_prefix}/kafka/bin/
cp -r libs $RPM_BUILD_ROOT%{_prefix}/kafka/
cp -r config $RPM_BUILD_ROOT%{_prefix}/kafka/config-sample
mkdir $RPM_BUILD_ROOT%{_prefix}/kafka/config
mkdir -p $RPM_BUILD_ROOT/etc/rc.d/init.d
install -m 755 %{S:1} $RPM_BUILD_ROOT/etc/rc.d/init.d/kafka

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc NOTICE
%doc LICENSE
/opt/kafka/bin
/opt/kafka/libs
/opt/kafka/config-sample
%config %attr(755,root,root) /opt/kafka/config
/etc/rc.d/init.d/kafka

