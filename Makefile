.PHONY:	rpm clean

KAFKA_VERSION ?= 0.11.0.1
SCALA_VERSION ?= 2.12
VERSION = $(shell echo $(KAFKA_VERSION) | sed "s/-/_/")
BUILD_NUMBER ?= 1
TARBALL_NAME = kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)
TARBALL = $(TARBALL_NAME).tgz
TOPDIR = /tmp/kafka-rpm
PWD = $(shell pwd)

rpm: $(TARBALL)
	@rpmbuild -v -bb \
			--define "version $(VERSION)" \
			--define "kafka_version $(KAFKA_VERSION)" \
			--define "build_number $(BUILD_NUMBER)" \
			--define "tarball $(TARBALL)" \
			--define "tarball_name $(TARBALL_NAME)" \
			--define "_sourcedir $(PWD)" \
			--define "_rpmdir $(PWD)" \
			--define "_topdir $(TOPDIR)" \
			kafka.spec

clean:
	@rm -rf $(TOPDIR) x86_64
	@rm -f $(TARBALL)

$(TARBALL):
	@spectool \
			--define "version $(VERSION)" \
			--define "kafka_version $(KAFKA_VERSION)" \
			--define "tarball $(TARBALL)" \
			-g kafka.spec

