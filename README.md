kafka-rpm
---------
A set of scripts to package kafka into an rpm

Setup
-----
    $ yum groupinstall "Development Tools"

Building
--------
	check [https://archive.apache.org/dist/kafka/](https://archive.apache.org/dist/kafka/) for supported versions.
    $ make rpm KAFKA_VERSION=1.0.2 SCALA_VERSION=2.12

Resulting RPM will be avaliable at $(shell pwd)

Installing and operating
------------------------
    $ sudo yum install kafka*.rpm
    $ sudo service kafka start
    $ sudo chkconfig kafka on

Libs, binaries, configs and logs are in /opt/kafka.
Default config assumes zookeeper is installed at localhost.
