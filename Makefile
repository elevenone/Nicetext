# Master Makefile
# NiceText

include config.mk

.PHONY: all check database depend clean backup snapshot tarball install RINFO test

all: 
	$(MAKE) -C rinfo
	$(MAKE) -C mtc++/src
	$(MAKE) -C gendict/src
	$(MAKE) -C babble/src
#	$(MAKE) -C import/src

database:
	$(MAKE) -C examples/database

depend: 
	$(MAKE) -C mtc++/src depend
	$(MAKE) -C gendict/src depend
	$(MAKE) -C babble/src depend
	$(MAKE) -C import/src depend

clean:
	$(MAKE) -C mtc++/src clean
	$(MAKE) -C gendict/src clean
	$(MAKE) -C babble/src clean
	$(MAKE) -C import/src clean
	$(MAKE) -C rinfo clean

backup: clean
	rm -f ../nicetext.zip; zip -9 -r ../nicetext.zip *; 

snapshot: RINFO
	rinfo/rinfo -s

RINFO:  
	$(MAKE) -C rinfo

tarball: clean
	rm -f ../nicetext-0.9.tar ../nicetext-0.9.tar.gz
	@echo "Creating tar archive..."
	cd ..; tar -cvf nicetext-0.9.tar nicetext-0.9; 
	@echo "Compressing tar archive..."
	cd ..; gzip --best nicetext-0.9.tar

install:
	$(MAKE) -C rinfo install
	$(MAKE) -C mtc++/src install
	$(MAKE) -C gendict/src install
	$(MAKE) -C babble/src install
	$(MAKE) -C import/src install

test: all
	./_tests/run_roundtrip_tests.sh

check: test
