#
# Makefile
# Mark T. Chapman
# 

include ../../config.mk

LIBDEPEND=../../babble/lib/libbabb.a ../../gendict/lib/libgndct.a ../../mtc++/lib/libmtc++.a 

CPPFLAGS+=-I../include -I../../gendict/include -I../../mtc++/include 
CXXFLAGS+=$(CDEBUG)
LDLIBS+=-L../../babble/lib -L../../mtc++/lib -L../../gendict/lib -lbabb -lgndct -lmtc++ 

SRCS=nttpd.cc
LEX=flex -f -p $(LDEBUG)  
YACC=yacc -d -v $(YDEBUG) 

.cc.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

all: nttpd

depend:
	makedepend -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f *.o *.core $(LIBTARGET) nttpd 
	rm -f ../bin/nttpd ../../bin/nttpd

install: all
	cp nttpd ../../bin
	strip ../../bin/nttpd

nttpd: nttpd.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o nttpd nttpd.o $(LDLIBS) 

# DO NOT DELETE
