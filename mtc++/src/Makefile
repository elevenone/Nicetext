#
# MTC++ MakeFile
# Copyright (c) Mark T. Chapman 1995
#

include ../../config.mk

LIBTARGET=../lib/libmtc++.a
LIBOBJS= mstring.o stdermsg.o initfile.o
SRCS=mstring.cc stdermsg.cc initfile.cc raofmake.cc raofmalt.cc raofread.cc bsttest.cc rbttest.cc listtest.cc inittest.cc numsize.cc

CPPFLAGS+=-I../include
CXXFLAGS+=$(CDEBUG)
LDLIBS+=-L../lib -lmtc++

.cc.o: 
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

all: $(LIBTARGET) raofmake raofmalt raofread bsttest rbttest listtest inittest numsize

install: all
	@$(MKDIR_P) $(MTC_BINDIR)
	$(INSTALL_PROGRAM) raofmake $(MTC_BINDIR)/raofmake
	$(INSTALL_PROGRAM) raofmalt $(MTC_BINDIR)/raofmalt
	$(INSTALL_PROGRAM) raofread $(MTC_BINDIR)/raofread
	$(INSTALL_PROGRAM) listtest $(MTC_BINDIR)/listtest
	$(INSTALL_PROGRAM) bsttest $(MTC_BINDIR)/bsttest
	$(INSTALL_PROGRAM) rbttest $(MTC_BINDIR)/rbttest
	$(INSTALL_PROGRAM) inittest $(MTC_BINDIR)/inittest
	$(INSTALL_PROGRAM) numsize $(MTC_BINDIR)/numsize
	-$(STRIP) $(MTC_BINDIR)/raofmake $(MTC_BINDIR)/raofmalt $(MTC_BINDIR)/raofread $(MTC_BINDIR)/listtest $(MTC_BINDIR)/bsttest $(MTC_BINDIR)/rbttest $(MTC_BINDIR)/inittest $(MTC_BINDIR)/numsize

depend:
	$(MAKEDEPEND) -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f $(LIBTARGET) *.o *.core inittest bsttest rbttest listtest raofmake raofmalt raofread numsize ../bin/inittest ../bin/bsttest ../bin/rbttest ../bin/listtest ../bin/raofmake ../bin/raofmalt ../bin/raofread ../bin/numsize

$(LIBTARGET): ../lib $(LIBOBJS)
	$(AR) -rc $(LIBTARGET) $(LIBOBJS)
	$(RANLIB) $(LIBTARGET)

../lib:
	$(MKDIR_P) $@

# THESE ARE SAMPLE PROGRAMS

raofmake: raofmake.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o raofmake raofmake.o $(LDLIBS)

raofmalt: raofmalt.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o raofmalt raofmalt.o $(LDLIBS)

raofread: raofread.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o raofread raofread.o $(LDLIBS)

listtest: listtest.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o listtest listtest.o $(LDLIBS)

bsttest: bsttest.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o bsttest bsttest.o $(LDLIBS)

rbttest: rbttest.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o rbttest rbttest.o $(LDLIBS)

inittest: inittest.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o inittest inittest.o $(LDLIBS)

numsize: numsize.o $(LIBTARGET)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o numsize numsize.o $(LDLIBS)
