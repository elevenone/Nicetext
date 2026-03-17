#
# Makefile
# Mark T. Chapman
# 

include ../../config.mk

LIBTARGET=
LIBOBJS=
LIBDEPEND=$(LIBTARGET) ../../mtc++/lib/libmtc++.a

CPPFLAGS+=-I../include -I../../mtc++/include 
CXXFLAGS+=$(DEBUG)
LDLIBS+=-L../../mtc++/lib 

SRCS=impkimmo.cc impwbstr.cc impmsc.cc printint.cc

.cc.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

all: $(LIBTARGET) impkimmo impwbstr impmsc printint  

install: all
	cp impkimmo ../../bin
	cp impwbstr ../../bin
	cp impmsc ../../bin
	cp printint ../../bin
	strip ../../bin/impkimmo ../../bin/impwbstr ../../bin/impmsc ../../bin/printint

depend:
	makedepend -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f *.o impkimmo impwbstr impmsc printint $(LIBTARGET) 
	rm -f ../bin/impkimmo ../../bin/impkimmo
	rm -f ../bin/impwbstr ../../bin/impwbstr
	rm -f ../bin/impmsc ../../bin/impmsc
	rm -f ../bin/printint ../../bin/printint

impkimmo: impkimmo.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impkimmo impkimmo.o -ll -lmtc++ $(LDLIBS)

impkimmo.cc: impkimmo.l impmsc.cc  
	rm -f lex.yy.c
	$(LEX) impkimmo.l 
	mv lex.yy.c impkimmo.cc

impmsc: impmsc.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impmsc impmsc.o -ll $(LDLIBS)

impmsc.cc: impmsc.l impwbstr.cc  
	rm -f lex.yy.c
	$(LEX) impmsc.l 
	mv lex.yy.c impmsc.cc
	
impwbstr: impwbstr.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impwbstr impwbstr.o -ll $(LDLIBS)

impwbstr.cc: impwbstr.l 
	rm -f lex.yy.c
	$(LEX) impwbstr.l 
	mv lex.yy.c impwbstr.cc

printint: printint.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o printint printint.o -ll $(LDLIBS)

# DO NOT DELETE
