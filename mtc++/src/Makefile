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
	cp raofmake ../bin
	cp raofmalt ../bin
	cp raofread ../bin
	cp listtest ../bin
	cp bsttest ../bin
	cp rbttest ../bin
	cp inittest ../bin
	cp numsize ../bin
	strip ../bin/raofmake ../bin/raofmalt ../bin/raofread ../bin/listtest ../bin/bsttest ../bin/rbttest ../bin/inittest ../bin/numsize

depend:
	makedepend -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f $(LIBTARGET) *.o *.core inittest bsttest rbttest listtest raofmake raofmalt raofread numsize ../bin/inittest ../bin/bsttest ../bin/rbttest ../bin/listtest ../bin/raofmake ../bin/raofmalt ../bin/raofread ../bin/numsize

$(LIBTARGET): $(LIBOBJS)
	$(AR) -rc $(LIBTARGET) $(LIBOBJS)
	$(RANLIB) $(LIBTARGET)

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
