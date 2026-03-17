
# UNIX Style Makefile for GCC 
# use to compile rinfo 

include ../config.mk

.PHONY: install clean

rinfo: rinfo.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -DUNIX=1 rinfo.c $(LDFLAGS) -o rinfo $(LDLIBS)

install: rinfo
	@$(MKDIR_P) $(TOP_BINDIR)
	$(INSTALL_PROGRAM) rinfo $(TOP_BINDIR)/rinfo
	
clean:
	rm -f rinfo ../bin/rinfo
