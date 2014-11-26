kafka-rpm
---------
A set of scripts to package kafka into an rpm

Setup
-----
    $ yum groupinstall "Development Tools"

Building
--------
    $ make rpm

Resulting RPM will be avaliable at $(shell pwd)

Installing and operating
------------------------
    $ sudo yum install kafka*.rpm
    $ sudo service kafka start
    $ sudo chkconfig kafka on

Libs, binaries, configs and logs are in /opt/kafka.
Default config assumes zookeeper is installed at localhost.
