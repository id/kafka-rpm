.PHONY:	rpm clean

KAFKA_VERSION = 0.8.1.1
SCALA_VERSION = 2.9.2
VERSION = $(KAFKA_VERSION)
TARBALL_NAME = kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)
TARBALL = $(TARBALL_NAME).tgz
TOPDIR = /tmp/kafka-rpm
PWD = $(shell pwd)

rpm: $(TOPDIR)/SOURCES/$(TARBALL) $(TOPDIR)/SOURCES/kafka.init
	@rpmbuild -v -bb \
			--define "version $(VERSION)" \
			--define "tarball $(TARBALL)" \
			--define "tarball_name $(TARBALL_NAME)" \
			--define "_topdir $(TOPDIR)" \
			kafka.spec
	@mv $(TOPDIR)/RPMS/x86_64/*.rpm ./

clean:
	@rm -rf $(TOPDIR)

$(TOPDIR)/SOURCES/$(TARBALL): $(TOPDIR)
	@spectool \
			--define "version $(VERSION)" \
			--define "tarball $(TARBALL)" \
			-C $(TOPDIR)/SOURCES \
			-g kafka.spec

$(TOPDIR)/SOURCES/kafka.init: $(TOPDIR)/SOURCES kafka.init
	cp kafka.init $(TOPDIR)/SOURCES/

$(TOPDIR):
	@mkdir -p $(TOPDIR)

$(TOPDIR)/SOURCES:
	@mkdir -p $(TOPDIR)/SOURCES
