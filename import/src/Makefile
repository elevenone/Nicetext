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
LDLIBS+=-L../../mtc++/lib $(LEX_LIBS)

SRCS=impkimmo.cc impwbstr.cc impmsc.cc printint.cc

.cc.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

all: $(LIBTARGET) impkimmo impwbstr impmsc printint  

install: all
	@$(MKDIR_P) ../../bin
	$(INSTALL_PROGRAM) impkimmo ../../bin/impkimmo
	$(INSTALL_PROGRAM) impwbstr ../../bin/impwbstr
	$(INSTALL_PROGRAM) impmsc ../../bin/impmsc
	$(INSTALL_PROGRAM) printint ../../bin/printint
	-$(STRIP) ../../bin/impkimmo ../../bin/impwbstr ../../bin/impmsc ../../bin/printint

depend:
	$(MAKEDEPEND) -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f *.o impkimmo impwbstr impmsc printint $(LIBTARGET) 
	rm -f ../bin/impkimmo ../../bin/impkimmo
	rm -f ../bin/impwbstr ../../bin/impwbstr
	rm -f ../bin/impmsc ../../bin/impmsc
	rm -f ../bin/printint ../../bin/printint

impkimmo: impkimmo.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impkimmo impkimmo.o -lmtc++ $(LDLIBS)

impkimmo.cc: impkimmo.l impmsc.cc  
	rm -f lex.yy.c
	$(LEX) impkimmo.l 
	mv lex.yy.c impkimmo.cc

impmsc: impmsc.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impmsc impmsc.o $(LDLIBS)

impmsc.cc: impmsc.l impwbstr.cc  
	rm -f lex.yy.c
	$(LEX) impmsc.l 
	mv lex.yy.c impmsc.cc
	
impwbstr: impwbstr.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impwbstr impwbstr.o $(LDLIBS)

impwbstr.cc: impwbstr.l 
	rm -f lex.yy.c
	$(LEX) impwbstr.l 
	mv lex.yy.c impwbstr.cc

printint: printint.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o printint printint.o $(LDLIBS)

# DO NOT DELETE
