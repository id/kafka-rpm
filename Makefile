.PHONY:	rpm clean

KAFKA_VERSION = 0.8.1.1
SCALA_VERSION = 2.9.2
VERSION = $(KAFKA_VERSION)
TARBALL_NAME = kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)
TARBALL = $(TARBALL_NAME).tgz
TOPDIR = /tmp/kafka-rpm
PWD = $(shell pwd)

rpm: $(TARBALL)
	@rpmbuild -v -bb \
			--define "version $(VERSION)" \
			--define "tarball $(TARBALL)" \
			--define "tarball_name $(TARBALL_NAME)" \
			--define "_sourcedir $(PWD)" \
			--define "_rpmdir $(PWD)" \
			--define "_topdir $(TOPDIR)" \
			kafka.spec

clean:
	@rm -rf $(TOPDIR)

$(TARBALL):
	@spectool \
			--define "version $(VERSION)" \
			--define "tarball $(TARBALL)" \
			-g kafka.spec

