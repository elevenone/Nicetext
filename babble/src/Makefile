#
# Makefile
# Mark T. Chapman
# 

include ../../config.mk

LIBTARGET=../lib/libbabb.a
LIBOBJS= bits2txt.o txt2bits.o bitstrm.o bitinput.o bitoutput.o grammar.o rule.o lexgram.o yaccgram.o
LIBDEPEND=../../gendict/lib/libgndct.a ../../mtc++/lib/libmtc++.a $(LIBTARGET) 

CPPFLAGS+=-I../include -I../../gendict/include -I../../mtc++/include 
CXXFLAGS+=$(CDEBUG)
LDLIBS+=-L../lib -L../../mtc++/lib -L../../gendict/lib -lbabb -lgndct -lmtc++ 

SRCS=bits2txt.cc txt2bits.cc nicetext.cc scramble.cc expgram.cc gramtest.cc bitcp.cc bitstrm.cc bitinput.cc bitoutput.cc grammar.cc rule.cc lexgram.cc yaccgram.cc

.cc.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

all: $(LIBTARGET) nicetext scramble expgram gramtest bitcp

depend:
	$(MAKEDEPEND) -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f *.o *.core $(LIBTARGET) nicetext scramble expgram gramtest bitcp 
	rm -f y.output 
	rm -f ../../bin/nicetext ../../bin/scramble ../../bin/expgram ../../bin/gramtest ../../bin/bitcp
	rm -f ../bin/nicetext ../bin/scramble ../bin/expgram ../bin/gramtest ../bin/bitcp

install: all
	@$(MKDIR_P) ../../bin
	$(INSTALL_PROGRAM) nicetext ../../bin/nicetext
	$(INSTALL_PROGRAM) scramble ../../bin/scramble
	$(INSTALL_PROGRAM) gramtest ../../bin/gramtest
	$(INSTALL_PROGRAM) expgram ../../bin/expgram
	$(INSTALL_PROGRAM) bitcp ../../bin/bitcp
	-$(STRIP) ../../bin/nicetext ../../bin/scramble ../../bin/gramtest ../../bin/expgram ../../bin/bitcp

$(LIBTARGET): ../lib $(LIBOBJS)
	$(AR) -rc $(LIBTARGET) $(LIBOBJS)
	$(RANLIB) $(LIBTARGET)

../lib:
	$(MKDIR_P) $@

nicetext: nicetext.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o nicetext nicetext.o $(LDLIBS) 

scramble: scramble.o txt2bits.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o scramble scramble.o txt2bits.o -lgndct $(LDLIBS) 

bitcp: bitcp.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o bitcp bitcp.o $(LDLIBS) 

gramtest: gramtest.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o gramtest gramtest.o $(LDLIBS)

expgram: expgram.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o expgram expgram.o $(LDLIBS)

lexgram.cc: yaccgram.cc lexgram.l 
	rm -f lex.yy.c
	$(LEX) lexgram.l 
	mv lex.yy.c lexgram.cc

y.tab.h: yaccgram.cc

yaccgram.cc: yaccgram.y
	rm -f y.tab.c y.tab.h
	$(YACC) yaccgram.y
	mv y.tab.c yaccgram.cc

# Manual dependancies -- used for parallel make before makedepend...
grammar.o: y.tab.h

# makedepend from here on down...
